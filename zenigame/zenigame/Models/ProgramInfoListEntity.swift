//
//  ProgramInfoEntity.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/07/23.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import ObjectMapper

final class ProgramInfoListEntity: Mappable {
    var programInfoList: [ChildEntity]!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        programInfoList <- map["programinfolist"]
    }

    final class ChildEntity: Mappable {
        var channelId: String!
        var programInfo: ProgramInfoEntity!

        required init?(map: Map) {
        }

        func mapping(map: Map) {
            channelId <- map["channelid"]
            programInfo <- map["programinfo"]
        }
    }

}
