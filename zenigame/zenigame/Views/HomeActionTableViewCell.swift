//
//  HomeActionTableViewCell.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/04/16.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import UIKit

// swiftlint:disable private_outlet
final class HomeActionTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    static let kCellId = "HomeActionTableViewCell"

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
