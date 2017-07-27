//
//  TokenEntity.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/07/22.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import ObjectMapper

final class TokenEntity: Mappable {
    var accessToken: String!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        accessToken <- map["access_token"]
    }
}
