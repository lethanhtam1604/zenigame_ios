//
//  HomeViewController.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/04/14.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import Alamofire
import ObjectMapper
import UIKit

final class HomeViewController: BaseViewController {

    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var channelLabel: UILabel!
    @IBOutlet private weak var levelNumberLabel: UILabel!
    @IBOutlet private weak var registeredNumberLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var tagLabel: UILabel!
    @IBOutlet private weak var buttonsTableView: UITableView!

    fileprivate var openedSections = Set<Int>()

    fileprivate let actionDic = [
        (section: "配信", row: ["即時配信", "配信予約", "ランキング"]),
        (section: "イベント", row: ["イベントトップ", "イベントランキング"]),
        (section: "コミュニティ", row: ["ファンボード", "登録者一覧", "アバター配布"]),
        (section: "設定、データ", row: ["チャンネル設定", "チャンネルデータ", "配信履歴", "SNS連携"]),
        (section: "デバッグ用", row: ["プッシュ許可", "ローカルプッシュ(3秒後)", "APIサンプル"])
        ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "ホーム"

        buttonsTableView.dataSource = self
        buttonsTableView.delegate = self
        let cellNib = UINib(nibName: HomeActionTableViewCell.kCellId, bundle: nil)
        buttonsTableView.register(cellNib, forCellReuseIdentifier: HomeActionTableViewCell.kCellId)

        headerView.layer.borderColor = UIColor.black.cgColor
        headerView.layer.borderWidth = 1
        titleLabel.text = "次回配信は12/12 18:00~"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func gestureSectionHeader(sender: UIGestureRecognizer) {
        if let section = sender.view?.tag {
            if self.openedSections.contains(section) {
                self.openedSections.remove(section)
            } else {
                self.openedSections.insert(section)
            }
            self.buttonsTableView.reloadSections(IndexSet(integer: section), with: .fade)
        }
    }

}

extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return actionDic.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.openedSections.contains(section) {
            return self.actionDic[section].row.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeActionTableViewCell.kCellId, for: indexPath) as! HomeActionTableViewCell
        cell.bindText(at: actionDic[indexPath.section].row[indexPath.row])
        return cell
    }

}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.actionDic[section].section
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UITableViewHeaderFooterView()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.gestureSectionHeader(sender:)))
        view.addGestureRecognizer(gesture)
        view.tag = section

        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let vc = PreDeliveryViewController.instantiate(storyboard: "PreDeliveryViewController")
            present(vc, animated: true, completion: nil)
        case (0, 1):
            let storyboard = UIStoryboard(name: "DeliverySetting", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "DeliverySettingViewController") as? DeliverySettingViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (4, 0):
            PushManager.registerNotificationSetting()
        case (4, 1):
            // 3秒後にアプリがバックグラウンドである必要がある
            PushManager.scheduleLocalNotification(title: "テスト", body: "ローカルプッシュテストです", delay: 3.0, params: ["hoge": "fuga"])
        case (4, 2):
            sampleRequest()
        default:
            break
        }
    }

    private func sampleRequest() {
        Alamofire.request(Router.getToken("token").mock())
            .responseJSON(completionHandler: { response in
                print("getToken >-----------------------------------")
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }

                if let value = response.result.value as? [String: Any], let json = Mapper<ResponseDataEntity<TokenEntity>>().map(JSON: value) {
                    if let status = json.status {
                        print("status: \(status)")
                    }
                    if let entity = json.data {
                        print("data: \(entity.accessToken)")
                    }
                }
            })

        Alamofire.request(Router.getUserInfo("token").mock())
            .responseJSON(completionHandler: { response in
                print("getUserInfo >-----------------------------------")
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                if let value = response.result.value as? [String: Any], let json = Mapper<ResponseDataEntity<UserInfoEntity>>().map(JSON: value) {
                    if let status = json.status {
                        print("status: \(status)")
                    }

                    if let entity = json.data {
                        for e in entity.channelData {
                            print("data: \(e.channelId)")
                            print("data: \(e.title)")
                            for program in e.programData {
                                print("programId: \(program.programId)")
                            }
                        }
                    }
                }
            })

        Alamofire.request(Router.getProgram("token").mock())
            .responseJSON(completionHandler: { response in
                print("getProgram >-----------------------------------")
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }

                if let value = response.result.value as? [String: Any], let json = Mapper<ResponseListDataEntity<ProgramEntity>>().map(JSON: value) {
                    if let status = json.status {
                        print("status: \(status)")
                    }
                    if let entities = json.data {
                        for e in entities {
                            print("data: \(e.programId)")
                        }
                    }
                }
            })

        Alamofire.request(Router.setProgram("", "", "", 0, nil, nil, nil, nil).mock())
            .responseJSON(completionHandler: { response in
                print("setProgram >-----------------------------------")
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                if let value = response.result.value as? [String: Any], let json = Mapper<ResponseEntity>().map(JSON: value) {
                    if let status = json.status {
                        print("status: \(status)")
                    }
                }
            })

        Alamofire.request(Router.updateProgram("", "", nil, "", 0, nil, nil, nil).mock())
            .responseJSON(completionHandler: { response in
                print("updateProgram >-----------------------------------")
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                if let value = response.result.value as? [String: Any], let json = Mapper<ResponseEntity>().map(JSON: value) {
                    if let status = json.status {
                        print("status: \(status)")
                    }
                }
            })

        Alamofire.request(Router.deleteProgram("", "").mock())
            .responseJSON(completionHandler: { response in
                print("deleteProgram >-----------------------------------")
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                if let value = response.result.value as? [String: Any], let json = Mapper<ResponseEntity>().map(JSON: value) {
                    if let status = json.status {
                        print("status: \(status)")
                    }
                }
            })

        Alamofire.request(Router.getProgramCast("token").mock())
            .responseJSON(completionHandler: { response in
                print("getProgramCast >-----------------------------------")
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                if let value = response.result.value as? [String: Any], let json = Mapper<ResponseDataEntity<ProgramCastEntity>>().map(JSON: value) {
                    if let status = json.status {
                        print("status: \(status)")
                    }

                    if let entity = json.data {
                        for e in entity.channelList {
                            print("data: \(e.channelId)")
                            for program in e.programList {
                                print("programId: \(program.programId)")
                            }
                        }
                    }
                }
            })

        Alamofire.request(Router.getProgramInfo("token").mock())
            .responseJSON(completionHandler: { response in
                print("getProgramInfo >-----------------------------------")
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                if let value = response.result.value as? [String: Any], let json = Mapper<ResponseDataEntity<ProgramInfoListEntity>>().map(JSON: value) {
                    if let status = json.status {
                        print("status: \(status)")
                    }

                    if let entity = json.data {
                        for e in entity.programInfoList {
                            print("data: \(e.channelId)")
                            print("title: \(e.programInfo.title)")
                        }
                    }
                }
            })

        Alamofire.request(Router.setProgramInfo("", "", nil, 0, nil, nil, nil, nil, nil, 0).mock())
            .responseJSON(completionHandler: { response in
                print("setProgramInfo >-----------------------------------")
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                if let value = response.result.value as? [String: Any], let json = Mapper<ResponseEntity>().map(JSON: value) {
                    if let status = json.status {
                        print("status: \(status)")
                    }
                }
            })

        Alamofire.request(Router.setProgramSoon("token", "").mock())
            .responseJSON(completionHandler: { response in
                print("setProgramSoon >-----------------------------------")
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                if let value = response.result.value as? [String: Any], let json = Mapper<ResponseEntity>().map(JSON: value) {
                    if let status = json.status {
                        print("status: \(status)")
                    }
                }
            })

        Alamofire.request(Router.setChannel("", "", nil, nil, nil).mock())
            .responseJSON(completionHandler: { response in
                print("setChannel >-----------------------------------")
                if let error = response.error {
                    print("error: \(error.localizedDescription)")
                    return
                }
                if let value = response.result.value as? [String: Any], let json = Mapper<ResponseEntity>().map(JSON: value) {
                    if let status = json.status {
                        print("status: \(status)")
                    }
                }
            })
    }

}
