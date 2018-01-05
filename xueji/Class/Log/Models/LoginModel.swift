//
//  LoginModel.swift
//  xueji
//
//  Created by lvxin on 2018/1/4.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import ObjectMapper
class LoginModel_data: Mappable {
    var token: String!
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        token <- map["token"]
    }
}

class LoginModel: Mappable {
    var token: String!
    var data : LoginModel_data = LoginModel_data()
    
    init() {}
    required init?(map: Map){
        mapping(map: map)
    }
    // Mappable
    func mapping(map: Map) {
        token <- map["token"]
        data <- map["data"]
    }
}

