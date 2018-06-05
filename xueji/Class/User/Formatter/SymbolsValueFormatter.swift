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

    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(value))%"
    }
}
