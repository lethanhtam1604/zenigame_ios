//
//  ChannelEntity.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/07/23.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import ObjectMapper

final class ChannelEntity: Mappable {
    var channelId: String!
    var doc: String!
    var imageUrl: String!
    var programData: [ProgramEntity]!
    var title: String!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        channelId <- map["channelid"]
        doc <- map["doc"]
        imageUrl <- map["imageurl"]
        programData <- map["programdata"]
        title <- map["title"]
    }
}
