//
//  ImageData.swift
//  xueji
//
//  Created by lvxin on 2018/7/9.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper
class ImageData_data: Mappable {
    var name: String!
    var url: String!
    var size:Int!


    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        name <- map["name"]
        url <- map["url"]
        size <- map["size"]
    }
}



class ImageData: Mappable {
    var code: Int!
    var msg: String = ""
    var data:ImageData_data = ImageData_data()


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
