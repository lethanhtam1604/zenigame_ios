//  配信前設定画面
//  DeliverySettingViewController.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/04/26.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import UIKit

final class DeliverySettingViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    final fileprivate class SettingContent {
        let title: String
        let actions: [String]
        var current: String

        init(title: String, actions: [String]) {
            self.title = title
            self.actions = actions
            self.current = ""
        }
    }

    fileprivate let settings = [
        SettingContent(title: "配信予約", actions: ["即時配信", "配信予約"]),
        SettingContent(title: "テロップ", actions: [""]),
        SettingContent(title: "配信モード", actions: ["動画", "静止画", "フォトスクロール"]),
        SettingContent(title: "新着表示", actions: ["表示する", "表示しない"]),
        SettingContent(title: "配信前告知", actions: ["告知する", "告知しない"]),
        SettingContent(title: "配信時間", actions: ["30分", "60分", "90分"]),
        SettingContent(title: "追加タグ", actions: ["ゲーム", "アニメ", "マンガ"]),
        SettingContent(title: "BGM設定", actions: ["セット1", "セット2", "セット3", "セット4"]),
        SettingContent(title: "SE設定", actions: ["セット1", "セット2", "セット3", "セット4"]),
        SettingContent(title: "スキン設定", actions: ["スキン1", "スキン2", "スキン3"]),
        SettingContent(title: "バルーン表示", actions: ["許可する", "許可しない"]),
        SettingContent(title: "バルーン使用", actions: ["使用する", "使用しない"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let cellNib = UINib(nibName: DeliverySettingTableViewCell.kCellId, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: DeliverySettingTableViewCell.kCellId)

        for setting in settings {
            // 初期値の設定
            setting.current = setting.actions.first ?? ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actionTapStartBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Delivery", bundle: nil)
        if let viewController = storyboard
            .instantiateViewController(withIdentifier: "DeliveryViewController") as? DeliveryViewController {
            let rootViewController = UINavigationController(rootViewController: viewController)
//            self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            present(rootViewController, animated: true, completion: nil)
        }
    }

    @IBAction func actionTapBackBtn(_ sender: Any) {
    }

    private func share() {
        let message = "配信を開始しました"
        let url = URL(string: "https://zenigame.com/delivery/1234567890")! // swiftlint:disable:this force_unwrapping
        let vc = UIActivityViewController(activityItems: [message, url], applicationActivities: nil)
        let excluded = [
            UIActivityType.postToWeibo, UIActivityType.message, UIActivityType.mail,
            UIActivityType.print, UIActivityType.copyToPasteboard, UIActivityType.assignToContact,
            UIActivityType.addToReadingList, UIActivityType.postToFlickr, UIActivityType.postToVimeo,
            UIActivityType.postToTencentWeibo, UIActivityType.airDrop
        ]
        vc.excludedActivityTypes = excluded
        vc.completionWithItemsHandler = shareCompleted()
        present(vc, animated: true, completion: nil)
    }

    private func shareCompleted() -> UIActivityViewControllerCompletionWithItemsHandler {
        return { (activityType, completed, _, error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
                return
            }
            print("activityType: \(String(describing: activityType)), completed: \(completed)")
        }
    }

}

extension DeliverySettingViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
                                withIdentifier: DeliverySettingTableViewCell.kCellId,
                                for: indexPath) as! DeliverySettingTableViewCell // swiftlint:disable:this force_cast
        let setting = settings[indexPath.row]
        cell.bind(title: setting.title, state: setting.current)
        return cell
    }

}

extension DeliverySettingViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        func didSelectSetting(string: String) {
            setting.current = string
            tableView.reloadRows(at: [indexPath], with: .automatic)

            if setting.title == "配信予約" && setting.current == "配信予約" {
                print("配信予約設定画面へ遷移")
            }

            if setting.title == "配信モード" {
                print("配信モードへ遷移")
            }

            if setting.title == "BGM設定" {
                print("BGM設定画面へ遷移")
            }

            if setting.title == "SE設定" {
                print("SE設定画面へ遷移")
            }
        }

        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 1:
            openInputAlert(title: setting.title,
                           message: nil,
                           content: setting.current,
                           completion: didSelectSetting(string:))
        default:
            openActionSheet(title: setting.title,
                            message: nil,
                            actions: setting.actions,
                            completion: didSelectSetting(string:))
        }
    }

    private func openActionSheet(title: String?, message: String?, actions: [String], completion: ((String) -> ())?) {
        let sheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        for actionName in actions {
            sheet.addAction(UIAlertAction(title: actionName, style: .default, handler: { _ in
                completion?(actionName)
            }))
        }
        present(sheet, animated: true, completion: nil)
    }

    private func openInputAlert(title: String?, message: String?, content: String?, completion: ((String) -> ())?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "変更", style: .default, handler: { _ in
            if let content = alert.textFields?.first?.text {
                completion?(content)
            }
        }))
        alert.addTextField(configurationHandler: { textField in
            textField.text = content
        })
        present(alert, animated: true, completion: nil)
    }

}
