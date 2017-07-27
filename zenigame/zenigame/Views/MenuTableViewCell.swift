//
//  MenuTableViewCell.swift
//  zenigame
//
//  Created by Thanh-Tam Le on 7/17/17.
//  Copyright © 2017 Anime Consortium Japan. All rights reserved.
//

import UIKit

// swiftlint:disable private_outlet
class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var numberOfBadgeLabel: UILabel!

    static let kCellId = "MenuTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        iconImgView.image = UIImage(named: "ic_home")

        titleLabel.text = "設定中の称号"

        badgeView.layer.cornerRadius = 10
        badgeView.backgroundColor = UIColor.red

        numberOfBadgeLabel.text = "10"
        numberOfBadgeLabel.textAlignment = .center
        numberOfBadgeLabel.textColor = Global.colorMenu
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func bindingData(menu: MenuModel) {
        titleLabel.text = menu.title
        iconImgView.image = menu.icon

        if let badge = menu.numberOfBadge {
            badgeView.isHidden = false
            numberOfBadgeLabel.text = String(badge)
        } else {
            badgeView.isHidden = true
        }

        if menu.id % 2 == 0 {
            backgroundColor = Global.colorMenu
        }
        else {
            backgroundColor = Global.colorChannel
        }
    }
}
