//
//  HYValueFormatter.swift
//  xueji
//
//  Created by lvxin on 2018/5/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  Y轴 h转换

import UIKit
import Charts
class HYValueFormatter: NSObject,IAxisValueFormatter {


    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(value)h"
    }
}
