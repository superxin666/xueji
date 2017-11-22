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
        //左下角图例
        //        lineChart.legend.formSize = 30
        //        lineChart.legend.form = .square
//        lineChart.legend.textColor = black_8c8484
        lineChart.legend.drawInside = true
        lineChart.legend.form = .none//没有
        //设置X轴坐标
//        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:  ["1", "2", "3", "4", "5", "6","7"])
        lineChart.xAxis.granularity = 0.0
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.axisLineColor = black_ebebee
        lineChart.xAxis.labelTextColor = black_53
    
        
        //设置Y轴坐标
        //        lineChart.rightAxis.isEnabled = false
        //不显示右侧Y轴
//        lineChart.leftAxis.valueFormatter = IndexAxisValueFormatter(values:  ["0","200", "300", "400", "500", "600", "700"])
        lineChart.leftAxis.drawAxisLineEnabled = true
        lineChart.leftAxis.enabled = true
        
        lineChart.rightAxis.drawAxisLineEnabled = false
        lineChart.rightAxis.enabled = false
        
        lineChart.leftAxis.drawZeroLineEnabled = true
        lineChart.leftAxis.axisLineColor = black_ebebee
        lineChart.leftAxis.gridColor = black_53
        lineChart.leftAxis.labelTextColor = black_53
        
        //数据填充
        let xArr = ["1", "2", "3", "4", "5", "6","7"]
        let yArr = [100,200, 300, 400, 500, 600, 700]
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<yArr.count {
            let dataEntry = ChartDataEntry(x: Double(xArr[i])!, y: Double(yArr[i]))
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChart.data = lineChartData
        
        //设置双击坐标轴是否能缩放
        lineChart.scaleXEnabled = false
        lineChart.scaleYEnabled = false
        
        //        lineChart.dragEnabled = true
        //        lineChart.dragDecelerationEnabled = true
        
        //设置图表背景色和border
        //必须设置enable才能有效
        //        lineChart.drawGridBackgroundEnabled = true
        //        lineChart.drawBordersEnabled = true
        //        lineChart.gridBackgroundColor = UIColor.red
        //        lineChart.borderColor = UIColor.orange
        //        lineChart.borderLineWidth = 5
        
        //设置折线线条
                lineChartDataSet.fillColor = orange_F46F56
                lineChartDataSet.lineWidth = 1
        
        //外圆
//        lineChartDataSet.setCircleColor(kDefault_0xff6600_4_clolr)
        //画外圆
                lineChartDataSet.drawCirclesEnabled = false
        //内圆
//        lineChartDataSet.circleHoleColor = kDefault_0xff6600_clolr
        //画内圆
          lineChartDataSet.drawCircleHoleEnabled = false
        
        //线条显示样式
//        lineChartDataSet.lineDashLengths = [1,3,4,2]
        lineChartDataSet.lineDashPhase = 0.5
        lineChartDataSet.colors = [orange_F46F56]
        
        //线条上的文字
//        lineChartDataSet.valueColors = [kDefault_0xff872e_clolr]
        //显示
        lineChartDataSet.drawValuesEnabled = false
        //添加显示动画
        lineChart.animate(xAxisDuration: 1)
    }

}
