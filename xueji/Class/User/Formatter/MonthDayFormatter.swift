//
//  MonthDayFormatter.swift
//  xueji
//
//  Created by lvxin on 2018/6/4.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import Charts
class MonthDayFormatter: NSObject,IAxisValueFormatter {
    var nameArr : [String] = []

    init(arr : Array<String>) {
        super.init()
        nameArr = arr
    }

    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return nameArr[Int(value)]
    }
}
