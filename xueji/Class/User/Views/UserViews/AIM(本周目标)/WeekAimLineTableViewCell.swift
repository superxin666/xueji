//
//  WeekAimLineTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/14.
//  Copyright © 2018年 lvxin. All rights reserved.
//  本周目标曲线图cell

import UIKit
import Charts
let WeekAimLineTableViewCellH = ip6(326)
let WeekAimLineTableViewCellID = "WeekAimLineTableViewCell_ID"

protocol WeekAimLineTableViewCellDelegate {
    func dateStepClick(stpeNum : Int)
}


class WeekAimLineTableViewCell: UITableViewCell {
    var titleLabel : UILabel!

    var titleBtn : UIButton!

    var leftBtn : UIButton!
    var rightBtn : UIButton!

    var timeLineView : UIView!
    var valueLineView :UIView!

    var timeLineLabel : UILabel!
    var valueLineLabel : UILabel!

    var lineChart : LineChartView!
    /// 横线
    var lineView : UIView!

    var dataModel : WeekAimDetailModel!
    /// 当前位置 左加 右减
    var stepNum = 0

    var delegate : WeekAimLineTableViewCellDelegate!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.creatUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func creatUI() {
        let Xappading = ip6(19)

        titleLabel = UILabel.getLabel(fream:  CGRect(x: Xappading, y: ip6(23), width: KSCREEN_WIDTH - Xappading * 2, height: ip6(20)), fontSize: 14, text: "目标完成情况统计曲线", textColor: black_53, textAlignment: .center)
        self.addSubview(titleLabel)

        titleBtn = UIButton.getBtn_titleStyle(title_normal: "", title_selected: "", fream: CGRect(x: ip6(15), y: titleLabel.frame.maxY + ip6(20), width: KSCREEN_WIDTH - ip6(30), height: ip6(25)), backgroundColor: .white, textColorSelectrd: black_53, textColor: black_53, fontSize: 14, textAlignment: .center, selector: #selector(click(sender:)), vc: self, tag: 0)
        titleBtn.xj_makeBorderWithBorderWidth(width: 1, color: black_53)
        titleBtn.xj_makeRadius(radius: 3)
        self.addSubview(titleBtn)

        leftBtn = UIButton.getBtn_picStyle(image_normal: #imageLiteral(resourceName: "base_left"), image_selected: #imageLiteral(resourceName: "base_left"), fream: CGRect(x: 0, y: 0, width: titleBtn.frame.size.width/2, height: titleBtn.frame.size.height), selector: #selector(click(sender:)), vc: self, tag: 1)
        leftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -(titleBtn.frame.size.width/2 - 20), bottom: 0, right: 0)

        self.titleBtn.addSubview(leftBtn)
        rightBtn = UIButton.getBtn_picStyle(image_normal: #imageLiteral(resourceName: "base_right"), image_selected: #imageLiteral(resourceName: "base_right"), fream: CGRect(x: titleBtn.frame.size.width/2, y: 0, width: titleBtn.frame.size.width/2, height: titleBtn.frame.size.height), selector: #selector(click(sender:)), vc: self, tag: 2)
        rightBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleBtn.frame.size.width/2 - 20, bottom: 0, right: 0)
        self.titleBtn.addSubview(rightBtn)

        timeLineView = UIView(frame: CGRect(x: KSCREEN_WIDTH - ip6(100), y:titleBtn.frame.maxY + ip6(40), width: ip6(30), height: ip6(1)))
        timeLineView.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0xBC2D33)

        timeLineLabel = UILabel.getLabel(fream:  CGRect(x: timeLineView.frame.maxX + ip6(2), y: timeLineView.frame.maxY - ip6(6), width: ip6(40), height: ip6(10)), fontSize: 8, text: "学习时间", textColor: black_53, textAlignment: .left)

        self.addSubview(timeLineView)
        self.addSubview(timeLineLabel)

        valueLineView = UIView(frame: CGRect(x: KSCREEN_WIDTH - ip6(100), y:timeLineView.frame.maxY + ip6(10), width: ip6(30), height: ip6(1)))
        valueLineView.backgroundColor = UIColor.xj_colorFromRGB(rgbValue: 0x4741BD)

        valueLineLabel = UILabel.getLabel(fream:  CGRect(x: valueLineView.frame.maxX + ip6(2), y: valueLineView.frame.maxY - ip6(4), width: ip6(50), height: ip6(10)), fontSize: 8, text: "学习量（页）", textColor: black_53, textAlignment: .left)
        self.addSubview(valueLineView)
        self.addSubview(valueLineLabel)

        lineChart = LineChartView(frame: CGRect(x: ip6(15), y: titleBtn.frame.maxY + ip6(85), width: KSCREEN_WIDTH  - ip6(30), height: ip6(125)))
        self.addSubview(lineChart)
        self.setChart()

        lineView = UIView(frame: CGRect(x: ip6(10), y: WeekAimLineTableViewCellH - 0.5, width: KSCREEN_WIDTH - ip6(20), height:  0.5))
        lineView.backgroundColor = black_e3e3e3
        self.addSubview(lineView)

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
        lineChart.xAxis.valueFormatter = WeekAimValueFormatter()
        lineChart.xAxis.granularity = 0.0
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.drawGridLinesEnabled = false

        lineChart.xAxis.axisLineColor = black_ebebee
        lineChart.xAxis.labelTextColor = black_53
        lineChart.xAxis.labelCount = 4
        lineChart.xAxis.axisMinimum = 0
        lineChart.xAxis.axisMaximum = 4
        lineChart.xAxis.granularityEnabled = true


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



    }

    func setCharData() {
        //数据填充 学习时间
        let xCont = 4

        var yArr : [Int] = []
        for model in dataModel.report {
            yArr.append(model.time_rate)
        }
        let dataCount = yArr.count
        if yArr.count<4 {
            for i in 0..<4 - yArr.count {
                yArr.append(0)
            }
        }
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<xCont {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(yArr[i]))
            dataEntries.append(dataEntry)
        }

        //学习量
        var yArr2 : [Int] = []
        for model in dataModel.report {
            yArr2.append(model.page_rate)
        }
        let dataCount2 = yArr2.count
        if yArr2.count<4 {
            for i in 0..<4 - yArr2.count {
                yArr2.append(0)
            }
        }
        var dataEntries2: [ChartDataEntry] = []
        for i in 0..<xCont {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(yArr2[i]))
            dataEntries2.append(dataEntry)
        }



        //学习时间
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "")
        //设置双击坐标轴是否能缩放
        lineChart.scaleXEnabled = false
        lineChart.scaleYEnabled = false
        //设置折线线条
        lineChartDataSet.lineWidth = 1

        //画外圆
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.lineDashPhase = 0.5


        var colourArr : [UIColor] = []
        switch dataCount {
        case 2:
            colourArr = [UIColor.xj_colorFromRGB(rgbValue: 0xBC2D33), .clear,UIColor.clear]
        case 3:
            colourArr = [UIColor.xj_colorFromRGB(rgbValue: 0xBC2D33),UIColor.xj_colorFromRGB(rgbValue: 0xBC2D33),UIColor.clear]
        case 4:
            colourArr = [UIColor.xj_colorFromRGB(rgbValue: 0xBC2D33)]
        default:
            colourArr = [UIColor.xj_colorFromRGB(rgbValue: 0xBC2D33)]
        }
        lineChartDataSet.colors = colourArr
        //显示
        lineChartDataSet.drawValuesEnabled = false

        //学习量
        let lineChartDataSet2 : LineChartDataSet =  LineChartDataSet()
        lineChartDataSet2.values = dataEntries2
        //设置折线线条
        lineChartDataSet2.lineWidth = 1
        //画外圆
        lineChartDataSet2.drawCirclesEnabled = false
        lineChartDataSet2.lineDashPhase = 0.5
        //显示
        lineChartDataSet2.drawValuesEnabled = false
        var colourArr2 : [UIColor] = []
        switch dataCount2 {
        case 2:
            colourArr2 = [UIColor.xj_colorFromRGB(rgbValue: 0x4741BD), .clear,UIColor.clear]
        case 3:
            colourArr2 = [UIColor.xj_colorFromRGB(rgbValue: 0x4741BD),UIColor.xj_colorFromRGB(rgbValue: 0xBC2D33),UIColor.clear]
        case 4:
            colourArr2 = [UIColor.xj_colorFromRGB(rgbValue: 0x4741BD)]
        default:
            colourArr2 = [UIColor.xj_colorFromRGB(rgbValue: 0x4741BD)]
        }
        lineChartDataSet2.colors = colourArr2

        let lineChartData = LineChartData(dataSets: [lineChartDataSet,lineChartDataSet2])
        lineChart.data = lineChartData
        //添加显示动画
        lineChart.animate(xAxisDuration: 1)

    }

    func setData(model : WeekAimDetailModel) {
        dataModel = model;
        //
        if let month = model.month {
            titleBtn.setTitle(month, for: .normal)
        }
        //表格
        if model.report.count > 1 {
            self.setCharData()
        } else {
            //只有一周时 此模型书当前周 不显示
       
        }
    }


    func click(sender:UIButton) {
        if sender.tag == 1 {
            XJLog(message: "左")
            stepNum = stepNum + 1

        } else if sender.tag == 2 {
            XJLog(message: "右")
            stepNum = stepNum - 1
            if stepNum < 0 {
                stepNum = 0
                SVPMessageShow.showErro(infoStr: "暂无数据")
                return
            } else {

            }
        }
        if (delegate != nil) {
            self.delegate.dateStepClick(stpeNum: stepNum)
        }
    }
}
