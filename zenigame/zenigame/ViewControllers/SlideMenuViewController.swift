//
//  SlideMenuViewController.swift
//  zenigame
//
//  Created by 笹野駿 on 2017/04/18.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import UIKit

enum Menu: Int {
    case home = 0
    case deliver = 1
    case config = 2
    case help = 3
    case tutorial = 4
    case notation = 5
    case logout = 6
}

class SlideMenuViewController: UIViewController {

    @IBOutlet private weak var channelLabel: UILabel!
    @IBOutlet private weak var levelLabel: UILabel!
    @IBOutlet private weak var registeredNumberLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var tagLabel: UILabel!

    @IBOutlet private weak var tableView: UITableView!

    fileprivate var openedSections = Set<Int>()

    let menuArray = [(section: "配信", row: ["即時配信", "配信予約", "ランキング"]),
                     (section: "イベント", row: ["イベントトップ", "イベントランキング"]),
                     (section: "コミュニティ", row: ["ファンボード", "登録者一覧", "アバター配布"]),
                     (section: "設定、データ", row: ["チャンネル設定", "チャンネルデータ", "配信履歴", "SNS連携"]),
                     (section: "その他", row: ["お問い合わせ", "ヘルプ", "利用規約", "特定商取引法に基づく表記", "資金決済法に基づく表記", "個人情報保護方針", "著作権表記", "アプリ設定"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        closeLeft()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actionGoHome(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            let rootViewController = UINavigationController(rootViewController: viewController)
            self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
        }

    }

    func gestureSectionHeader(sender: UIGestureRecognizer) {
        if let section = sender.view?.tag {
            if self.openedSections.contains(section) {
                self.openedSections.remove(section)
            } else {
                self.openedSections.insert(section)
            }
            self.tableView.reloadSections(IndexSet(integer: section), with: .fade)
        }
    }
}

extension  SlideMenuViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return menuArray.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.openedSections.contains(section) {
            return self.menuArray[section].row.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "slideMenuCell", for: indexPath)
        cell.textLabel?.text = menuArray[indexPath.section].row[indexPath.row]
        return cell
    }

}

extension SlideMenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.menuArray[section].section
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UITableViewHeaderFooterView()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.gestureSectionHeader(sender:)))
        view.addGestureRecognizer(gesture)
        view.tag = section

        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let storyboard = UIStoryboard(name: "DeliverySetting", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "DeliverySettingViewController") as? DeliverySettingViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }

        case (0, 1):
            let storyboard = UIStoryboard(name: "DeliveryReservation", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "DeliveryReservationViewController") as? DeliveryReservationViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (0, 2):
            let storyboard = UIStoryboard(name: "Ranking", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "RankingViewController") as? RankingViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (1, 0):
            let storyboard = UIStoryboard(name: "EventTop", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "EventTopViewController") as? EventTopViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (1, 1):
            let storyboard = UIStoryboard(name: "EventRanking", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "EventRankingViewController") as? EventRankingViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (2, 0):
            let storyboard = UIStoryboard(name: "Fanboard", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "FanboardViewController") as? FanboardViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (2, 1):
            let storyboard = UIStoryboard(name: "RegisteredIndex", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "RegisteredIndexViewController") as? RegisteredIndexViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }

        case (2, 2):
            let storyboard = UIStoryboard(name: "DistributeAvatar", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "DistributeAvatarViewController") as? DistributeAvatarViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }

        case (3, 0):
            let storyboard = UIStoryboard(name: "ChannelSetting", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "ChannelSettingViewController") as? ChannelSettingViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (3, 1):
            let storyboard = UIStoryboard(name: "ChannelData", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "ChannelDataViewController") as? ChannelDataViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (3, 2):
            let storyboard = UIStoryboard(name: "DeliveryHistory", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "DeliveryHistoryViewController") as? DeliveryHistoryViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (3, 3):
            let storyboard = UIStoryboard(name: "SNSCooperation", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "SNSCooperationViewController") as? SNSCooperationViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (4, 0):
            let storyboard = UIStoryboard(name: "ContactUs", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "ContactUsViewController") as? ContactUsViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (4, 1):
            let storyboard = UIStoryboard(name: "Help", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "HelpViewController") as? HelpViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (4, 2):
            let storyboard = UIStoryboard(name: "TermsOfServise", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "TermsOfServiseViewController") as? TermsOfServiseViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (4, 3):
            let storyboard = UIStoryboard(name: "SpecifiedCommercial", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "SpecifiedCommercialViewController") as? SpecifiedCommercialViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (4, 4):
            let storyboard = UIStoryboard(name: "Settlement", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "SettlementViewController") as? SettlementViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (4, 5):
            let storyboard = UIStoryboard(name: "ProtectPersonalInformation", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "ProtectPersonalInformationViewController") as? ProtectPersonalInformationViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }
        case (4, 6):
            let storyboard = UIStoryboard(name: "Copyright", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "CopyrightViewController") as? CopyrightViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }

        case (4, 7):
            let storyboard = UIStoryboard(name: "Config", bundle: nil)
            if let viewController = storyboard
                .instantiateViewController(withIdentifier: "ConfigViewController") as? ConfigViewController {
                let rootViewController = UINavigationController(rootViewController: viewController)
                self.slideMenuController()?.changeMainViewController(rootViewController, close: true)
            }

        default:
            break
        }
    }
}
