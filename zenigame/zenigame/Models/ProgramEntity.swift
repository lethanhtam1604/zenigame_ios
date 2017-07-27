//
//  ProgramEntity.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/07/22.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import ObjectMapper

final class ProgramEntity: Mappable {
    var programId: String!
    var channelId: String!
    var startDate: String!
    var endDate: String!

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        programId <- map["programid"]
        channelId <- map["channelid"]
        startDate <- map["startdate"]
        endDate <- map["enddate"]
    }
}
