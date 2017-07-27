//
//  UserInfoEntity.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/07/23.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import ObjectMapper

final class UserInfoEntity: Mappable {
    var castData: CastData!
    var channelData: [ChannelEntity]!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        castData <- map["castdata"]
        channelData <- map["channeldata"]
    }

    final class CastData: Mappable {
        var name: String!

        required init?(map: Map) {
        }

        func mapping(map: Map) {
            name <- map["name"]
        }

    }

}
