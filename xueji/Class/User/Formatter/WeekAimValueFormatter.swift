

//
//  WeekAimValueFormatter.swift
//  xueji
//
//  Created by lvxin on 2018/6/17.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import Charts
class WeekAimValueFormatter: NSObject,IAxisValueFormatter{


    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if value < 4 {
            return "第\(NSInteger(value)+1)周"
        } else {
            return ""
        }
    }
}
