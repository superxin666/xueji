//
//  StudyValueView.swift
//  xueji
//
//  Created by lvxin on 2017/11/6.
//  Copyright © 2017年 lvxin. All rights reserved.
//  我的--学习力

import UIKit
import Charts
class StudyValueTableViewCell: UITableViewCell {
    var scoreView : UIView!
    var scoreLabel : UILabel!
    var lineChart : LineChartView!
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI() {

        //
        scoreView = UIView()
        scoreView.frame = CGRect(x: ip6(20), y: ip6(30), width: ip6(98), height: ip6(98))
        scoreView.backgroundColor = black_53
        scoreView.xj_makeRound()
        self.addSubview(scoreView)
        

        //分数
        scoreLabel = UILabel.getLabel(fream: CGRect(x: 0, y: ip6(15), width: ip6(98), height: ip6(47)), fontSize: 47, text: "120", textColor: black_fcf9f9, textAlignment: .center)
        scoreView.addSubview(scoreLabel)
        
        let scoreNameLabel = UILabel.getLabel(fream: CGRect(x: 0, y: scoreLabel.frame.maxY, width: ip6(98), height: ip6(21)), fontSize: 21, text: "分", textColor: black_fcf9f9, textAlignment: .center)
        scoreView.addSubview(scoreNameLabel)
        
        //标题
        let titleLabel = UILabel.getLabel(fream: CGRect(x: scoreView.frame.maxX + ip6(10), y: ip6(8), width: ip6(98), height: ip6(10)), fontSize: 10, text: "学习力增长曲线", textColor: black_53, textAlignment: .left)
        self.addSubview(titleLabel)
        
        //折线
        lineChart = LineChartView(frame: CGRect(x: scoreView.frame.maxX + ip6(10), y: ip6(37), width: KSCREEN_WIDTH - scoreView.frame.maxX - ip6(10) - ip6 (50), height: ip6(110)))
        self.addSubview(lineChart)

        self.setChart()
    }
    
    func setChart() {

        //右下角图标描述
        lineChart.chartDescription?.text = ""

        lineChart.legend.enabled = false
        lineChart.pinchZoomEnabled = false

        lineChart.doubleTapToZoomEnabled = false
        lineChart.scaleYEnabled = false
        lineChart.scaleXEnabled = false

        //设置X轴坐标
        lineChart.xAxis.valueFormatter = DateValueFormatter()
        lineChart.xAxis.granularity = 0.0
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.drawGridLinesEnabled = false

        lineChart.xAxis.axisLineColor = black_ebebee
        lineChart.xAxis.labelTextColor = black_53
        lineChart.xAxis.labelCount = 4
        lineChart.xAxis.axisMinimum = 1


    

        //不显示右侧Y轴
        lineChart.leftAxis.valueFormatter = SymbolsValueFormatter()
        lineChart.leftAxis.drawAxisLineEnabled = true
        lineChart.leftAxis.enabled = true
        
        lineChart.rightAxis.drawAxisLineEnabled = false
        lineChart.rightAxis.enabled = false
        
        lineChart.leftAxis.drawZeroLineEnabled = true
        lineChart.leftAxis.axisLineColor = black_ebebee
        lineChart.leftAxis.gridColor = black_53
        lineChart.leftAxis.labelTextColor = black_53
        lineChart.leftAxis.labelCount = 8
        lineChart.leftAxis.axisMinimum = 0
        lineChart.leftAxis.axisMaximum = 160

        lineChart.leftAxis.drawZeroLineEnabled = false
        //数据填充
        let xArr = [1,2,3,4]
        let yArr = [20,40,48,57]
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<xArr.count {
            let dataEntry = ChartDataEntry(x: Double(xArr[i]), y: Double(yArr[i]))
            dataEntries.append(dataEntry)
        }


        let yArr2 = [45,35,23,56]
        var dataEntries2: [ChartDataEntry] = []
        for i in 0..<xArr.count {
            let dataEntry = ChartDataEntry(x: Double(xArr[i]), y: Double(yArr2[i]))
            dataEntries2.append(dataEntry)
        }

        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "")
        //设置双击坐标轴是否能缩放
        lineChart.scaleXEnabled = false
        lineChart.scaleYEnabled = false

        //设置折线线条

        lineChartDataSet.lineWidth = 1

        //画外圆
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.lineDashPhase = 0.5
        lineChartDataSet.colors = [UIColor.xj_colorFromRGB(rgbValue: 0xBC2D33)]
        //显示
        lineChartDataSet.drawValuesEnabled = false


        let lineChartDataSet2 : LineChartDataSet =  LineChartDataSet()
        lineChartDataSet2.values = dataEntries2
        //设置折线线条
        lineChartDataSet2.lineWidth = 1
        //画外圆
        lineChartDataSet2.drawCirclesEnabled = false
        lineChartDataSet2.lineDashPhase = 0.5
        //显示
        lineChartDataSet2.drawValuesEnabled = false
        lineChartDataSet2.colors = [UIColor.xj_colorFromRGB(rgbValue: 0x4741BD)]
        let lineChartData = LineChartData(dataSets: [lineChartDataSet,lineChartDataSet2])
        lineChart.data = lineChartData
        //添加显示动画
        lineChart.animate(xAxisDuration: 1)
    }

}
