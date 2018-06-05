//
//  DateValueFormatter.swift
//  xueji
//
//  Created by lvxin on 2018/5/14.
//  Copyright © 2018年 lvxin. All rights reserved.
//

import UIKit
import Charts
class DateValueFormatter: NSObject,IAxisValueFormatter{


    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "第\(NSInteger(value))周"

    }
}
