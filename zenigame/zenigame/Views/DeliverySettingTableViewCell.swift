//
//  DeliverySettingTableViewCell.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/04/26.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import UIKit

// swiftlint:disable private_outlet
class DeliverySettingTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!

    static let kCellId = "DeliverySettingTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func bind(title: String, state: String) {
        titleLabel.text = title
        stateLabel.text = state
    }

}
