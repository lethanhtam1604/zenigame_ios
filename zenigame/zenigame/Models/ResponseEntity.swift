//
//  ResponseEntity.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/07/22.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import ObjectMapper

class ResponseEntity: Mappable {
    var status: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        status <- map["meta.status"]
    }

}
