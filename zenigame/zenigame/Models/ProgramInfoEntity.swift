//
//  ProgramInfoEntity.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/07/23.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import ObjectMapper

final class ProgramInfoEntity: Mappable {
    var title: String!
    var timing: String!
    var openRange: String!
    var text: String!
    var type: String!
    var newList: String!
    var notice: String!
    var duration: String!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        title <- map["title"]
        timing <- map["timing"]
        openRange <- map["openrange"]
        text <- map["text"]
        type <- map["type"]
        newList <- map["newlist"]
        notice <- map["notice"]
        duration <- map["duration"]
    }

}
