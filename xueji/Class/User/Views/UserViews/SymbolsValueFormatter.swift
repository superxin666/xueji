//
//  SymbolsValueFormatter.swift
//  xueji
//
//  Created by lvxin on 2018/5/14.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import Charts
class SymbolsValueFormatter: NSObject,IAxisValueFormatter {
    var dataArr : [String]!


    init(arr : [String]) {
        dataArr = arr
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(value))%"
    }
}
