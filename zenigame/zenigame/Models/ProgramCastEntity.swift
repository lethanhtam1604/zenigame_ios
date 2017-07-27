//
//  ProgramCastEntity.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/07/23.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import ObjectMapper

final class ProgramCastEntity: Mappable {
    var channelList: [ChildEntity]!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        channelList <- map["channellist"]
    }

    final class ChildEntity: Mappable {
        var channelId: String!
        var programList: [ProgramEntity]!

        required init?(map: Map) {
        }

        func mapping(map: Map) {
            channelId <- map["channelid"]
            programList <- map["programlist"]
        }
    }

}
