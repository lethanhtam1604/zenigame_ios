//
//  ConfigViewController.swift
//  zenigame
//
//  Created by 笹野駿 on 2017/04/18.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import UIKit

class ConfigViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    fileprivate let headerArray = ["基本設定", "NG 設定", "アプリ設定"]

    fileprivate let actionArray = [
        ["基本情報", "SNS連携設定/解除"],
        ["NGワード設定/変更", "NGユーザー一覧"],
        ["プッシュ通知設定", "キャッシュのクリア"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "設定"

        tableView.dataSource = self
        tableView.delegate = self
        let cellNib = UINib(nibName: SettingActionTableViewCell.kCellId, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: SettingActionTableViewCell.kCellId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ConfigViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return actionArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionArray[section].count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerArray[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingActionTableViewCell.kCellId, for: indexPath) as! SettingActionTableViewCell
        cell.bindText(at: actionArray[indexPath.section][indexPath.row])
        return cell
    }
}

extension ConfigViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (0, 0): // 基本情報
            break
        case (0, 1): // SNS連携設定/解除
            break
        case (1, 0): // NGワード設定/変更
            break
        case (1, 1): // NGユーザー一覧
            break
        case (2, 0): // プッシュ通知設定
            break
        case (2, 1): // キャッシュのクリア
            break
        default:
            break
        }
    }

}
