//
//  MenuViewController.swift
//  zenigame
//
//  Created by Thanh-Tam Le on 7/17/17.
//  Copyright © 2017 Anime Consortium Japan. All rights reserved.
//

import UIKit
import FontAwesomeKit

protocol MenuViewDelegate: class {
    func actionTapToMenuItem(viewController: UIViewController, navigateType: Int)
    func actionTapToCloseMenu()
    func actionTapToHeaderMenu()
}

class MenuViewController: UIViewController {

    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeMenuButton: UIButton!

    fileprivate var menus = [MenuModel]()
    weak var delegate: MenuViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        createMenuData()

        containView.layer.cornerRadius = 8
        containView.backgroundColor = UIColor.white

        closeMenuButton.imageView?.clipsToBounds = true
        closeMenuButton.imageView?.contentMode = .scaleAspectFit

        tableView.dataSource = self
        tableView.delegate = self
        let cellNib = UINib(nibName: MenuTableViewCell.kCellId, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: MenuTableViewCell.kCellId)
        let headerNib = UINib(nibName: MenuHeaderTableViewCell.kCellId, bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: MenuHeaderTableViewCell.kCellId)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Global.colorMenu
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        tableView.showsVerticalScrollIndicator = false
    }

    func createMenuData() {

        var menu = MenuModel()
        menu.id = 0
        menu.title = "配信修了"
        menu.icon = UIImage(named: "icon_menu_home")
        menus.append(menu)

        menu = MenuModel()
        menu.id = 1
        menu.title = "配信者一覧"
        menu.icon = UIImage(named: "icon_menu_live")
        menus.append(menu)

        menu = MenuModel()
        menu.id = 2
        menu.title = "SE"
        menu.icon = UIImage(named: "icon_menu_programs")
        menus.append(menu)

        menu = MenuModel()
        menu.id = 3
        menu.title = "BGM"
        menu.icon = UIImage(named: "icon_menu_official")
        menus.append(menu)

        menu = MenuModel()
        menu.id = 4
        menu.title = "バルーン"
        menu.icon = UIImage(named: "event")
        menus.append(menu)

        menu = MenuModel()
        menu.id = 5
        menu.title = "シエア"
        menu.icon = UIImage(named: "icon_menu_ranking")
        menus.append(menu)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func actionTapToCloseMenu(_ sender: Any) {
        delegate?.actionTapToCloseMenu()
    }

    func actionTapToHeaderMenu() {
        delegate?.actionTapToHeaderMenu()
    }
}

extension MenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuHeaderTableViewCell.kCellId) as! MenuHeaderTableViewCell // swiftlint:disable:this force_cast
        cell.contentView.backgroundColor = UIColor.white
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionTapToHeaderMenu))
        cell.contentView.addGestureRecognizer(tapGestureRecognizer)

        return cell.contentView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.kCellId, for: indexPath) as! MenuTableViewCell // swiftlint:disable:this force_cast
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero

        cell.bindingData(menu: menus[indexPath.row])

        return cell
    }
}

extension MenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = menus[indexPath.row]
        switch menu.id {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        case 6:
            break
        default:
            break
        }
    }
}
