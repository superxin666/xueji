//
//  HistogramTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2018/5/21.
//  Copyright © 2018年 lvxin. All rights reserved.
//  柱状图

import UIKit
import Charts

let HistogramTableViewCellH = ip6(160)
let HistogramTableViewCellID = "HistogramTableViewCell_id"

class HistogramTableViewCell: UITableViewCell {

    var barCharView : BarChartView!
    var reportModel : MyDetailModel!


    ///0 教材  1分类
    var typeNum = 0

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.creatChart()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func creatChart() {
        barCharView = BarChartView(frame: CGRect(x: ip6(20), y: ip6(22), width: KSCREEN_WIDTH - ip6(40), height: ip6(138)))
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


        //Y轴
        barCharView.rightAxis.enabled = false
        let leftAxis : YAxis = barCharView.leftAxis
        leftAxis.valueFormatter = HYValueFormatter()
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



    }

    func setChartData()  {

        let xVals_count = 7 //X轴上要显示多少条数据
        //Y轴上面需要显示的数据
        var dataSets : [BarChartDataSet] = Array()
        for i in 1...xVals_count {
            let model : MyDetailModel_report = reportModel.report[i-1]


            let leftAxis : YAxis = barCharView.leftAxis

            //Y轴
            let dayNum = reportModel.max.time
            XJLog(message: dayNum)
            leftAxis.axisMinimum = 0//设置Y轴的最小值
            leftAxis.axisMaximum = Double(String.getHour_more(min: dayNum!));//设置Y轴的最大值
            //X轴
            var dateArr : [String] = []
            dateArr.append("")
            for model in reportModel.report {
                dateArr.append(String.xj_getDate_dayMonth(dateStr: model.day))
            }
            let xAxis : XAxis = barCharView.xAxis
            xAxis.valueFormatter = MonthDayFormatter(arr: dateArr)
            var arr : [ReportModel_date_book] = []
            if typeNum == 0 {
                arr = model.book
            } else {
                arr = model.category
            }
            if arr.count > 0 {
                XJLog(message: "有学习记录")
                var bookArr : [Double] = []
                var colourArr : [UIColor] = []

                for subModel in arr {
                    bookArr.append(Double(String.getHour(min: subModel.time_count)))
                    if let str = subModel.color {
                        colourArr.append(UIColor.xj_colorFromString(hexColor: str))
                    }
                }
                XJLog(message: colourArr.count)
                var  yVals :[BarChartDataEntry] = []
                let entry : BarChartDataEntry = BarChartDataEntry(x: Double(i), yValues: bookArr)
                yVals.append(entry)

                let set =  BarChartDataSet(values: yVals, label: nil)
                set.drawValuesEnabled = false
                set.highlightEnabled = false
                //书本颜色
                set.setColors(colourArr, alpha: 1)
                dataSets.append(set)


            } else {
                XJLog(message: "没有学习记录")
            }
        }

        let data : BarChartData = BarChartData(dataSets: dataSets)
        data.barWidth = Double(0.4)
        barCharView.data = data
        barCharView.animate(yAxisDuration: 1)



    }

    /// <#Description#>
    ///
    /// - Parameters:
    ///   - model: <#model description#>
    ///   - model2: <#model2 description#>
    ///   - type: 0 教材  1分类
    func setData(model:MyDetailModel,type : Int) {
        reportModel = model

        //柱形图
        if reportModel.report.count > 0 {
            self.setChartData()
        }

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
