//
//  StudyDistributeTableViewCell.swift
//  xueji
//
//  Created by lvxin on 2017/11/10.
//  Copyright © 2017年 lvxin. All rights reserved.
//  学习分布

import UIKit
import Charts
let study_distribute_sectionHeight = ip6(318)//学习分布
let study_distribute_cell_ID = "study_distreibute_cell_id"

typealias StudyDistributeTableViewCellBlock = (_ tagNum : Int) ->()
class StudyDistributeTableViewCell: UITableViewCell {

     var nestBlock :StudyDistributeTableViewCellBlock!

    var topBackView : UIView!
    var bottomView : UIView!
    
    
    var timePieChartView : PieChartView!
    var amountPieChartView : PieChartView!

    var timeNestBtn : UIButton!
    var valeNestBtn : UIButton!

    var dataModel : ReportModel_sum = ReportModel_sum()


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
            let titleLabel = UILabel.getLabel(fream:CGRect(x: ip6(15), y: ip6(12), width: ip6(84), height: ip6(14)), fontSize: 10, text: nameArr[i], textColor: black_53, textAlignment: .center)
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
       
        let count = dataModel.book.count//饼状图总共有几块组成
         //时间
        var yVals : [BarChartDataEntry] = Array()
        var colors : [UIColor] = Array()
        for i in 0..<count {
            let bookModel = dataModel.book[i]
            let entry = BarChartDataEntry(x:Double(i) , y: Double(bookModel.time_count))
            yVals.append(entry)
            if let str =  bookModel.color {
                colors.append(UIColor.xj_colorFromString(hexColor: str))
            }

        }
        //页数
        var yVals2 : [BarChartDataEntry] = Array()
        var colors2 : [UIColor] = Array()
        for i in 0..<count {
            let bookModel = dataModel.book[i]
            let entry = BarChartDataEntry(x:Double(i) , y: Double(bookModel.page_count))
            yVals2.append(entry)
            if let str =  bookModel.color {
                colors2.append(UIColor.xj_colorFromString(hexColor: str))
            }

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


        let dataSet2 = PieChartDataSet(values: yVals2, label: "")
        dataSet2.drawValuesEnabled = true
        dataSet2.colors = colors2
        dataSet2.sliceSpace = 0
        dataSet2.selectionShift = 8
        dataSet2.drawIconsEnabled  = false
        dataSet2.xValuePosition = .outsideSlice
        dataSet2.yValuePosition = .insideSlice
        dataSet2.valueLineWidth = 0
        dataSet2.valueLinePart1Length = 0
        dataSet2.valueLinePart2Length = 0
        let data2 = PieChartData(dataSet: dataSet2)
        data2.setValueFont(xj_fontThin(ip6(10)))

        timePieChartView.data = data
        amountPieChartView.data = data2
    }


    
    func setLineData_top() {
        //画线赋值
        
        for i in 0..<dataModel.first5_time.count {
            let model = dataModel.first5_time[i]

            let subBackView = UIView(frame: CGRect(x: self.timePieChartView.frame.maxX + ip6(15), y:self.timePieChartView.frame.origin.y + CGFloat(i) * (ip6(12) + ip6(10)), width: ip6(140), height: ip6(12)))
            self.topBackView.addSubview(subBackView)
    
            let titleLabel = UILabel.getLabel(fream:CGRect(x: 0, y: 0, width: ip6(140), height: ip6(11)), fontSize: 8, text: model.title, textColor: black_53, textAlignment: .left)
            subBackView.addSubview(titleLabel)
            
            let lineView : UIView = UIView(frame: CGRect(x: 0, y: ip6(11), width: ip6(140), height: ip6(1)))
            if let str = model.book_color {

                lineView.backgroundColor = UIColor.xj_colorFromString(hexColor: str)
            }

            subBackView.addSubview(lineView)

        }
        timeNestBtn = UIButton.getBtn_picStyle(image_normal: #imageLiteral(resourceName: "study_shape_>"), image_selected: #imageLiteral(resourceName: "study_shape_>"), fream: CGRect(x: KSCREEN_WIDTH - ip6(40), y: 0, width: ip6(40), height: study_distribute_sectionHeight/2), selector: #selector(nestClick(sender:)), vc: self, tag: 0)
        timeNestBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        self.addSubview(timeNestBtn)


        
    }
    func setLineData_bottom() {
        //画线赋值
        for i in 0..<dataModel.first5_page.count{
            let model = dataModel.first5_page[i]
            let subBackView = UIView(frame: CGRect(x: self.amountPieChartView.frame.maxX + ip6(15), y:self.amountPieChartView.frame.origin.y + CGFloat(i) * (ip6(12) + ip6(10)), width: ip6(140), height: ip6(12)))
            self.bottomView.addSubview(subBackView)
            
            let titleLabel = UILabel.getLabel(fream:CGRect(x: 0, y: 0, width: ip6(140), height: ip6(11)), fontSize: 8, text: model.title, textColor: black_53, textAlignment: .left)
            subBackView.addSubview(titleLabel)
            
            let lineView : UIView = UIView(frame: CGRect(x: 0, y: ip6(11), width: ip6(140), height: ip6(1)))

            if let str = model.book_color {
                lineView.backgroundColor = UIColor.xj_colorFromString(hexColor: str)
            }
            subBackView.addSubview(lineView)
            
        }

        valeNestBtn = UIButton.getBtn_picStyle(image_normal: #imageLiteral(resourceName: "study_shape_>"), image_selected: #imageLiteral(resourceName: "study_shape_>"), fream: CGRect(x: KSCREEN_WIDTH - ip6(20), y: study_distribute_sectionHeight/2, width: ip6(20), height: study_distribute_sectionHeight/2), selector: #selector(nestClick(sender:)), vc: self, tag: 1)
        self.addSubview(valeNestBtn)
    }

    /// 赋值
    ///
    /// - Parameter model: <#model description#>
    func setData(model : ReportModel_sum) {
        dataModel = model
        self.setLineData_top()
        self.setLineData_bottom()
        self.setPieData()
    }

    func nestClick(sender : UIButton) {
        self.nestBlock(sender.tag)
    }
    
}
