//
//  PreDeliveryViewController.swift
//  zenigame
//
//  Created by ykkc on 2017/07/20.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import AVFoundation
import LFLiveKit
import UIKit
//import WebKit

class PreDeliveryViewController: BaseDeliveryViewController {

    @IBOutlet private weak var cameraView: UIView!
    @IBOutlet fileprivate weak var renderImageView: UIImageView!

    private let closeDeliveryButton = UIButton()
    private let changeCameraButton = UIButton()
    private var isBack = true

    fileprivate let kStreamSize = CGSize(width: 640, height: 360)
    fileprivate let kCIContext = CIContext(options: [kCIContextWorkingColorSpace: CGColorSpaceCreateDeviceRGB()])

    private var input: AVCaptureDeviceInput!
    private var output: AVCaptureVideoDataOutput!
    private var session: AVCaptureSession!
    private var camera: AVCaptureDevice!
    private var useCameraPosition = AVCaptureDevicePosition.back

//    fileprivate lazy var liveSession: LFLiveSession = {
//        let audioConfiguration = LFLiveAudioConfiguration.defaultConfiguration(for: .medium)
//        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: .medium3, outputImageOrientation: .unknown)
//        videoConfiguration?.videoSize = self.kStreamSize
//        videoConfiguration?.videoSizeRespectingAspectRatio = false
//
//        let session = LFLiveSession(audioConfiguration: audioConfiguration,
//                                    videoConfiguration: videoConfiguration,
//                                    captureType: .captureMaskAudioInputVideo)! // swiftlint:disable:this force_unwrapping
//        session.delegate = self
//        session.captureDevicePosition = .back
//        session.preView = self.cameraView
//        session.reconnectInterval = 5
//        session.reconnectCount = 60
//        session.showDebugInfo = false
//        return session
//    }()

    //ここでURLを受け取る。
    var receiveURL: URL?

    override func viewDidLoad() {

        cameraView.bounds.origin.y = -40.0

        changeCameraButton.frame = CGRect(x: UIScreen.main.bounds.size.width/3.0, y: (UIScreen.main.bounds.size.width*9.0/16.0)*1.5, width: UIScreen.main.bounds.size.width/3.0, height: UIScreen.main.bounds.size.width/8.0)

        changeCameraButton.backgroundColor = UIColor.orange
        changeCameraButton.cornerRadius = 10
        changeCameraButton.setTitle("配信開始", for: .normal)
        changeCameraButton.setTitleColor(UIColor.white, for: .normal)
        changeCameraButton.addTarget(self, action: #selector(PreDeliveryViewController.onClick), for: .touchUpInside)

        self.view.addSubview(changeCameraButton)


        closeDeliveryButton.frame = CGRect(x: 10.0, y: UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.width/8.0 + 10.0), width: UIScreen.main.bounds.size.width/4.0, height: UIScreen.main.bounds.size.width/8.0)

        closeDeliveryButton.backgroundColor = UIColor(red:1.0,green:0.9,blue:0.6,alpha:1.0)
        closeDeliveryButton.cornerRadius = 10
        closeDeliveryButton.layer.borderColor = UIColor.orange.cgColor
        closeDeliveryButton.layer.borderWidth = 3
        closeDeliveryButton.layer.cornerRadius = 10
        closeDeliveryButton.setTitle("配信中止", for: .normal)
        closeDeliveryButton.setTitleColor(UIColor.orange, for: .normal)
        closeDeliveryButton.addTarget(self, action: #selector(PreDeliveryViewController.onClose), for: .touchUpInside)

        self.view.addSubview(closeDeliveryButton)

        super.viewDidLoad()
    }

    // changeCameraButtonをタップしたときのアクション
    func onClick() {

        stopCamera()

        let vc = DeliveryViewController.instantiate(storyboard: "Delivery")
        let navigationController = UINavigationController(rootViewController: vc)
        present(navigationController, animated: false, completion: nil)
    }

    func onClose() {

        stopCamera()

        self.dismiss(animated: false, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startLive()
    }

    private func startLive() {
        do {
            try startCamera()
        } catch let e {
            print("エラーが発生しました: \(e.localizedDescription)")
            return
        }

//        liveSession.running = true
//        let stream = LFLiveStreamInfo()
//        stream.url = "\(kStreamServer)\(kStreamKey)"
//        liveSession.startLive(stream)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        stopLive()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func startCamera() throws {
        session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetPhoto

        if #available(iOS 10.0, *) {
            camera = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera,
                                                   mediaType: AVMediaTypeVideo,
                                                   position: useCameraPosition)
        } else {
            if let videoDevices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) {
                for device in videoDevices {
                    if let d = device as? AVCaptureDevice, d.position == useCameraPosition {
                        camera = d
                        break
                    }
                }
            } else {
                camera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            }
        }

        input = try AVCaptureDeviceInput(device: camera) as AVCaptureDeviceInput
        output = AVCaptureVideoDataOutput()
        if session.canAddInput(input) {
            session.addInput(input)
        }
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable: Int(kCVPixelFormatType_32BGRA)]
        output.setSampleBufferDelegate(self, queue: DispatchQueue.global())
        output.alwaysDiscardsLateVideoFrames = true

        session.startRunning()

        try camera.lockForConfiguration()
        camera.activeVideoMinFrameDuration = CMTimeMake(1, 30)
        camera.unlockForConfiguration()
    }

    private func stopCamera() {
        session.stopRunning()
        for output in session.outputs {
            session.removeOutput(output as? AVCaptureOutput)
        }
        for input in session.inputs {
            session.removeInput(input as? AVCaptureInput)
        }
        session = nil
        camera = nil
    }

}

extension PreDeliveryViewController: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        let ciImage = captureForStream(sampleBuffer)
        publishStream(ciImage)
        DispatchQueue.main.async { [weak self] in
            self?.renderImageView.image = UIImage(ciImage: ciImage)
        }
    }

    // swiftlint:disable force_unwrapping
    private func captureForStream(_ sampleBuffer: CMSampleBuffer) -> CIImage {
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        CVPixelBufferLockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)))

        let baseAddress = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0)!
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let newContext = CGContext(data: baseAddress,
                                   width: width,
                                   height: height,
                                   bitsPerComponent: 8,
                                   bytesPerRow: bytesPerRow,
                                   space: colorSpace,
                                   bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)!

        let imageRef = newContext.makeImage()!
        CVPixelBufferUnlockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))

        var output = CIImage(cgImage: imageRef)

        var transform = output.imageTransform(forOrientation: 6) // UIImageOrientation.right
        output = output.applying(transform)

        let minSize = min(kStreamSize.width, output.extent.size.width)
        let maxSize = max(kStreamSize.width, output.extent.size.width)
        let ratio = minSize / maxSize
        transform = output.imageTransform(forOrientation: 1)
        transform = transform.scaledBy(x: ratio, y: ratio)
        output = output.applying(transform)

        transform = output.imageTransform(forOrientation: 1)
        transform = transform.translatedBy(x: 0, y: -(output.extent.size.height - kStreamSize.height) / 2)
        output = output.applying(transform)

        return output.cropping(to: CGRect(origin: CGPoint.zero, size: kStreamSize))
    }

    private func publishStream(_ output: CIImage) {
        var newPixelBuffer: CVPixelBuffer? = nil
        CVPixelBufferCreate(kCFAllocatorDefault,
                            Int(kStreamSize.width),
                            Int(kStreamSize.height),
                            kCVPixelFormatType_32BGRA,
                            nil,
                            &newPixelBuffer)
        kCIContext.render(output, to: newPixelBuffer!)
//        liveSession.pushVideo(newPixelBuffer)
    }
    // swiftlint:enable force_unwrapping

}

extension PreDeliveryViewController: LFLiveSessionDelegate {

    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        switch errorCode {
        case .preView:
            print("プレビューエラー")
        case .getStreamInfo:
            print("ストリーム取得エラー")
        case .connectSocket:
            print("接続エラー")
        case .verification:
            print("認証エラー")
        case .reConnectTimeOut:
            print("タイムアウト")
        }
    }

    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        switch state {
        case .ready:
            print("準備")
        case .pending:
            print("接続中")
        case .start:
            print("開始")
        case .stop:
            print("終了")
        case .error:
            print("エラー")
        case .refresh:
            print("更新")
        }
    }
    
}
