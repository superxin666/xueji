//
//  PageFormatter.swift
//  xueji
//
//  Created by lvxin on 2018/6/4.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import Charts

class PageFormatter: NSObject,IAxisValueFormatter {


    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(value))p"
    }
}
