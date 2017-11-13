//
//  StudyDistributeTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/11/10.
//  Copyright © 2017年 lvxin. All rights reserved.
//  学习分布

import UIKit
import Charts

class StudyDistributeTableViewCell: UITableViewCell {
    
    var topBackView : UIView!
    var bottomView : UIView!
    
    
    var timePieChartView : PieChartView!
    var amountPieChartView : PieChartView!
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI()  {
        let viewH = study_distribute_sectionHeight/2
        let nameArr = ["学习时间","学习量"]
        
        for i in 0..<2 {
            let backView = UIView(frame: CGRect(x: 0, y: CGFloat(i) * viewH , width: KSCREEN_WIDTH, height: viewH))

            self.addSubview(backView)
            
            let titleLabel = UILabel(frame: CGRect(x: ip6(15), y: ip6(12), width: ip6(84), height: ip6(14)))
            titleLabel.text = nameArr[i]
            titleLabel.textAlignment = .center
            titleLabel.font = xj_fzFontMedium(ip6(10))
            titleLabel.textColor = black_53
            backView.addSubview(titleLabel)
            
            //表格
            let  pieChartView = PieChartView()
            pieChartView.frame = CGRect(x: ip6(5), y:titleLabel.frame.maxY + ip6(10), width: ip6(104), height: ip6(104))
            backView.addSubview(pieChartView)
            
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
           
            if i == 0 {
                topBackView = backView
                timePieChartView = pieChartView
            } else {
                bottomView = backView
                amountPieChartView = pieChartView
            }
        }
        
        self.setPieData()
        self.setLineData_top()
        self.setLineData_bottom()
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
        amountPieChartView.data = data
    }
    
    func setLineData_top() {
        //画线赋值
        
        for i in 0..<5 {
            let subBackView = UIView(frame: CGRect(x: self.timePieChartView.frame.maxX + ip6(15), y:self.timePieChartView.frame.origin.y + CGFloat(i) * (ip6(12) + ip6(10)), width: ip6(140), height: ip6(12)))
            self.topBackView.addSubview(subBackView)
    
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: ip6(140), height: ip6(11)))
            titleLabel.text = "母猪的产后护理"
            titleLabel.textAlignment = .left
            titleLabel.font = xj_fzFontMedium(ip6(8))
            titleLabel.textColor = black_53
            subBackView.addSubview(titleLabel)
            
            let lineView : UIView = UIView(frame: CGRect(x: 0, y: ip6(11), width: ip6(140), height: ip6(1)))
            lineView.backgroundColor = orange_F46F56
            subBackView.addSubview(lineView)
            
        }
        
    }
    func setLineData_bottom() {
        //画线赋值
        for i in 0..<5 {
            let subBackView = UIView(frame: CGRect(x: self.amountPieChartView.frame.maxX + ip6(15), y:self.amountPieChartView.frame.origin.y + CGFloat(i) * (ip6(12) + ip6(10)), width: ip6(140), height: ip6(12)))
            self.bottomView.addSubview(subBackView)
            
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: ip6(140), height: ip6(11)))
            titleLabel.text = "母猪的产后护理"
            titleLabel.textAlignment = .left
            titleLabel.font = xj_fzFontMedium(ip6(8))
            titleLabel.textColor = black_53
            subBackView.addSubview(titleLabel)
            
            let lineView : UIView = UIView(frame: CGRect(x: 0, y: ip6(11), width: ip6(140), height: ip6(1)))
            lineView.backgroundColor = orange_F46F56
            subBackView.addSubview(lineView)
            
        }
        
    }
    
}
