//
//  MenuHeaderTableViewCell.swift
//  zenigame
//
//  Created by Thanh-Tam Le on 7/17/17.
//  Copyright © 2017 Anime Consortium Japan. All rights reserved.
//

import UIKit
import FontAwesomeKit

// swiftlint:disable private_outlet
class MenuHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarIconButton: UIButton!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var coinView: UIView!
    @IBOutlet weak var bcView: UIView!
    @IBOutlet weak var numberOfCoinLabel: UILabel!

    @IBOutlet weak var pointView: UIView!
    @IBOutlet weak var pView: UIView!
    @IBOutlet weak var numberOfPointLabel: UILabel!

    static let kCellId = "MenuHeaderTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = UIColor.white

        avatarIconButton.imageView?.clipsToBounds = true
        avatarIconButton.imageView?.contentMode = .scaleAspectFit

        coinView.layer.cornerRadius = 15
        coinView.layer.borderColor = Global.colorMenu.cgColor
        coinView.layer.borderWidth = 2

        bcView.layer.cornerRadius = 10

        pointView.layer.cornerRadius = 15
        pointView.layer.borderColor = Global.colorMenu.cgColor
        pointView.layer.borderWidth = 2

        pView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
