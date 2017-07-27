//
//  SettingActionTableViewCell.swift
//  zenigame
//
//  Created by Thanh-Tam Le on 4/25/17.
//  Copyright © 2017 Anime Consortium Japan. All rights reserved.
//

import UIKit

// swiftlint:disable private_outlet
class SettingActionTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    static let kCellId = "SettingActionTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func bindText(at name: String) {
        nameLabel.text = name
    }
}
