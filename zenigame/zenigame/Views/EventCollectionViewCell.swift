//
//  EventCollectionViewCell.swift
//  zenigame
//
//  Created by Thanh-Tam Le on 6/21/17.
//  Copyright © 2017 Anime Consortium Japan. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var thumbnailImgView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    static let kCellId = "EventCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func bindingData(event: Event) {

        titleLabel.text = event.title

        DispatchQueue.global(qos: .userInitiated).async {
            var overlayImage: NSData?

            if let path = event.thumbnailUrl {
                if let url = URL(string: path) {
                    if let data = NSData(contentsOf: url) {
                        overlayImage = data
                    }
                }
            }

            DispatchQueue.main.async {
                if let data = overlayImage {
                    self.thumbnailImgView.image = UIImage(data: data as Data)
                }
            }
        }
    }
}
