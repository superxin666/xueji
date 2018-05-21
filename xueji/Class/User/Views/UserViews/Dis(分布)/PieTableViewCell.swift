//
//  PieTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  饼形图

import UIKit
import Charts
let PieTableViewCellH = ip6(170)
let PieTableViewCellID = "PieTableViewCell_ID"


class PieTableViewCell: UITableViewCell {
    var timePieChartView : PieChartView!
   


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.creatUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func creatUI()  {
        let  pieChartView = PieChartView()
        pieChartView.frame = CGRect(x: (KSCREEN_WIDTH - ip6(150))/2, y: ip6(20), width: ip6(150), height: ip6(150))
        self.addSubview(pieChartView)
        pieChartView.backgroundColor = .clear
        pieChartView.drawSlicesUnderHoleEnabled = false
        pieChartView.drawHoleEnabled = false//饼状图是否是空心
        pieChartView.dragDecelerationEnabled = false
        pieChartView.chartDescription?.text = ""
        pieChartView.usePercentValuesEnabled = true
        pieChartView.legend.maxSizePercent = 0.1;//图例在饼状图中的大小占比, 这会影响图例的宽高
        pieChartView.legend.formToTextSpace = 5;//文本间隔
        pieChartView.legend.font = xj_fzFontMedium(10);//字体大小
        pieChartView.legend.textColor = black_53;//字体颜色
        //        timePieChartView.legend.position = .piechartCenter;//图例在饼状图中的位置
        pieChartView.legend.form = .none;//图示样式: 方形、线条、圆形
        pieChartView.legend.formSize = 12;//图示大小
        timePieChartView = pieChartView

        self.setPieData()
    }

    func setPieData() {

        let count = 5//饼状图总共有几块组成
        //每个区块的数据
        var yVals : [BarChartDataEntry] = Array()
        for i in 0..<count {
            let entry = BarChartDataEntry(x:Double(i) , y: Double(10))
            yVals.append(entry)
        }

        //每个区块的名称或描述
        var xVals : [String] = Array()
        for i in 0..<count {
            let title = "\(i+1)"
            xVals.append(title)
        }
        //dataSet
        let dataSet = PieChartDataSet(values: yVals, label: "")
        dataSet.drawValuesEnabled = true

        var colors : [UIColor] = Array()
        colors.append(UIColor.green)
        colors.append(UIColor.darkGray)
        colors.append(UIColor.red)
        colors.append(UIColor.purple)
        colors.append(UIColor.brown)

        dataSet.colors = colors
        dataSet.sliceSpace = 0
        dataSet.selectionShift = 8
        dataSet.drawIconsEnabled  = false
        dataSet.xValuePosition = .outsideSlice
        dataSet.yValuePosition = .insideSlice

        dataSet.valueLineWidth = 0
        dataSet.valueLinePart1Length = 0
        dataSet.valueLinePart2Length = 0
        let data = PieChartData(dataSet: dataSet)
        data.setValueFont(xj_fontThin(ip6(10)))

        timePieChartView.data = data
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
