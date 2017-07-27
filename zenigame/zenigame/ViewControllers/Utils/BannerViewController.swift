//
//  BannerViewController.swift
//  zenigame
//
//  Created by Thanh-Tam Le on 6/23/17.
//  Copyright © 2017 Anime Consortium Japan. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController {

    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    var event: Event?

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func bindingData(event: Event?) {
        self.event = event

        DispatchQueue.global(qos: .userInitiated).async {
            var overlayImage: NSData?

            if let currentEvent = event {
                if let path = currentEvent.thumbnailUrl {
                    if let url = URL(string: path) {
                        if let data = NSData(contentsOf: url) {
                            overlayImage = data
                        }
                    }
                }
            }

            DispatchQueue.main.async {
                self.titleLabel.text = event?.title
                if let data = overlayImage {
                    self.imageView.image = UIImage(data: data as Data)
                }
            }
        }
    }
}
