//
//  ErrowCodeData.swift
//  xueji
//
//  Created by lvxin on 2018/1/11.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper
class ErrorCodeData: Mappable {
    var code: Int!
    var msg: String!
    var data:Any!
    
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        code <- map["code"]
        msg <- map["msg"]
        data <- map["data"]
    }

}

