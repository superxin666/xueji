//
//  StudyTimeTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/11/7.
//  Copyright © 2017年 lvxin. All rights reserved.
//  我的--学习时间

import UIKit
import Charts
class StudyTimeTableViewCell: UITableViewCell {
    var leftBackView : UIView!
    var leftTitleLabel :UILabel!
    var leftTimeLabel :UILabel!
    var leftBtn : UIButton!
    
    var midBackView : UIView!
    var midTitleLabel :UILabel!
    var midTimeLabel :UILabel!
    var midBtn : UIButton!
    
    var rightBackView : UIView!
    var rightTitleLabel :UILabel!
    var rightTimeLabel :UILabel!
    var rightdBtn : UIButton!
    
    var barCharView : BarChartView!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI() {
        let backViewW = (KSCREEN_WIDTH - ip6(40))/3
        let backViewH = ip6(91)
        let titleLabelY = ip6(8)
        let titleLabelH = ip6(14)
        let titleNameArr = ["今天","本月","总计",]
        let btnNameArr = ["日","周","月",]
        
        for i in 0..<titleNameArr.count {
           let  backView = UIView(frame: CGRect(x: ip6(20) + CGFloat(i) * backViewW, y: 0, width: backViewW, height: backViewH))
            self.addSubview(backView)
            
            let titleLabel = UILabel(frame: CGRect(x: 0, y: titleLabelY, width: backViewW, height: titleLabelH))
            titleLabel.text = titleNameArr[i]
            titleLabel.textAlignment = .center
            titleLabel.font = xj_fzFontMedium(ip6(10))
            titleLabel.textColor = black_53
            backView.addSubview(titleLabel)
            
            let timeLabel = UILabel(frame: CGRect(x: 0, y: titleLabel.frame.maxY + ip6(5), width: backViewW, height: ip6(30)))
            timeLabel.text = "1000h"
            timeLabel.textAlignment = .center
            timeLabel.font = xj_fzFontMedium(ip6(22))
            timeLabel.textColor = black_8c8484
            backView.addSubview(timeLabel)
            
            let btn = UIButton.getBtn_titleStyle(title_normal: btnNameArr[i], title_selected: btnNameArr[i], fream: CGRect(x: ip6(1), y: timeLabel.frame.maxY + ip6(10) , width: backViewW - ip6(2), height: ip6(23)), backgroundColor: .white, textColor: black_53, fontSize: 14, textAlignment: .center, selector: #selector(self.btnClick(sender:)), vc: self, tag: i)
            btn.xj_makeBorderWithBorderWidth(width: 1, color: black_53)
            btn.xj_makeRadius(radius: 3)
            backView.addSubview(btn)
            
            if i == 0 {
                leftBackView = backView
                leftTitleLabel = titleLabel
                leftTimeLabel = timeLabel
                leftBtn = btn
                btn.backgroundColor = black_8c8484
            } else if i == 1{
                midBackView = backView
                midTitleLabel = titleLabel
                midTimeLabel = timeLabel
                midBtn = btn
            } else{
                rightBackView = backView
                rightTitleLabel = titleLabel
                rightTimeLabel = timeLabel
                rightdBtn = btn
            }
        }
        
        //表格
        self.creatChart()
        
    }
    
    func creatChart() {
        barCharView = BarChartView(frame: CGRect(x: ip6(20), y: ip6(97), width: KSCREEN_WIDTH - ip6(40), height: ip6(138)))
        self.addSubview(barCharView)
        barCharView.legend.enabled = false
        barCharView.chartDescription?.text = ""//不显示，就设为空字符串即
        barCharView.noDataText = "暂无数据"//没有数据时的文字提示
        barCharView.drawValueAboveBarEnabled = true//数值显示在柱形的上面还是下面
        barCharView.highlightFullBarEnabled = false//点击柱形图是否显示箭头
        barCharView.drawBarShadowEnabled = false//是否绘制柱形的阴影背景
        barCharView.doubleTapToZoomEnabled = false
        barCharView.drawBarShadowEnabled = false
        barCharView.dragDecelerationEnabled = true
        barCharView.dragDecelerationFrictionCoef = 0.9
        barCharView.backgroundColor = .white
        barCharView.drawBarShadowEnabled = false
     
//        barCharView.bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        //x轴样式
        let xAxis : XAxis = barCharView.xAxis
        xAxis.axisLineWidth = 1//设置X轴线宽
        xAxis.labelPosition = .bottom//X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = false;//不绘制网格线
        xAxis.labelTextColor = black_53//label文字颜色
        xAxis.drawLimitLinesBehindDataEnabled = false
        xAxis.axisLineColor = black_ebebee
        
        //X轴坐标系个数设置
        xAxis.spaceMin = 1//设置label间隔，若设置为1，则如果能全部显示，则每个柱形下面都会显示label
        xAxis.axisMinimum = 1
        xAxis.axisMaximum = 7
//        xAxis.labelCount = 7
        
        //Y轴
        barCharView.rightAxis.enabled = false
        let leftAxis : YAxis = barCharView.leftAxis
        leftAxis.forceLabelsEnabled = false//不强制绘制制定数量的label
//        leftAxis.showOnlyMinMaxEnabled = false//是否只显示最大值和最小值
        leftAxis.inverted = false//是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0.5;//Y轴线宽
        leftAxis.axisLineColor = .clear//Y轴颜色
//        leftAxis.minWidth = 2.0
        leftAxis.drawLimitLinesBehindDataEnabled = false
        

        //Y轴坐标系个数设置
        leftAxis.drawZeroLineEnabled = true//从0开始绘制
        leftAxis.axisMinimum = 0//设置Y轴的最小值
        leftAxis.axisMaximum = 12;//设置Y轴的最大值
        leftAxis.labelCount = 6
        leftAxis.forceLabelsEnabled = false
        
        leftAxis.labelPosition = .outsideChart//label位置
        leftAxis.labelTextColor = black_53//文字颜色
        leftAxis.labelFont = xj_fzFontMedium(10)
        
        self.setChartData()
        
    }
    
    
    func setChartData()  {
        let xVals_count = 7 //X轴上要显示多少条数据
        //Y轴上面需要显示的数据
        var  yVals :[BarChartDataEntry] = Array()
        for i in 0...xVals_count {
//            let mult : Int = maxYVal + 1
//            let val =  5.0
            let entry : BarChartDataEntry = BarChartDataEntry(x: Double(i), yValues: [Double(2),Double(4),Double(1.5)])
            yVals.append(entry)
            
        }
         //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
        let set1 =  BarChartDataSet(values: yVals, label: nil)
        set1.drawValuesEnabled = false
        set1.highlightEnabled = false
        set1.setColors(bluek_0068be,orange_F46F56,UIColor.red)
        var dataSets : [BarChartDataSet] = Array()
        dataSets.append(set1)
        
        
        //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
        
        let data : BarChartData = BarChartData(dataSets: dataSets)
        data.barWidth = Double(0.4)
    
        barCharView.data = data
        barCharView.animate(yAxisDuration: 1)
        
    }
    
    func btnClick(sender : UIButton) {
        let tagNum : Int = sender.tag
        sender.backgroundColor = black_8c8484
        if tagNum == 0 {
           midBtn.backgroundColor = .white
           rightdBtn.backgroundColor = .white
        } else if tagNum == 1 {
            leftBtn.backgroundColor = .white
            rightdBtn.backgroundColor = .white
        } else {
            leftBtn.backgroundColor = .white
            midBtn.backgroundColor = .white
        }
        
    }
    
}
