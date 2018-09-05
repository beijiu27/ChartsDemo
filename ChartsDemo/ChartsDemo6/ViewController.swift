//
//  ViewController.swift
//  ChartsDemo6
//
//  Created by 南鑫林 on 2018/9/3.
//  Copyright © 2018年 南鑫林. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    var chartView : LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //六、限制线、警戒线
        
        chartView = LineChartView()
        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,height: 270)
        //1，基本用法
        let limitLine = ChartLimitLine(limit: 85, label: "优秀")
        chartView.leftAxis.addLimitLine(limitLine)
        //（2）可以同时显示多根限制线
//        let limitLine1 = ChartLimitLine(limit: 85, label: "优秀")
//        chartView.leftAxis.addLimitLine(limitLine1)
//
//        let limitLine2 = ChartLimitLine(limit: 60, label: "合格")
//        chartView.leftAxis.addLimitLine(limitLine2)
        //2，将限制线绘制在折线后面
        // 默认情况下限制线是在图表的最上层，如果嫌它挡住了折线，可以将其绘制到折线后面。
        chartView.leftAxis.drawLimitLinesBehindDataEnabled = true
        //3，修改限制线文字样式
        limitLine.valueTextColor = .blue
        limitLine.valueFont = UIFont.systemFont(ofSize: 13)
        //4.修改限制线文字位置
        /*
        1）通过 labelPosition 属性可以设置文字的显示位置，有如下 4 个可选值：
            .leftTop：左上
            .leftBottom：左下
            .rightTop：右上（默认）
            .rightBottom：右下
         */
        limitLine.labelPosition = .leftTop
        
        //5. 不显示文字
//        limitLine.drawLabelEnabled = false //不绘制文字
        //6. 修改限制线的样式
        limitLine.lineWidth = 1 //线宽
        limitLine.lineColor = .blue //线条颜色
        limitLine.lineDashLengths = [5,2] ////虚线样式

        self.view.addSubview(chartView)
        
        //生成10条随机数据
        var dataEntries = [ChartDataEntry]()
        for i in 0..<10 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        //这10条数据作为1根折线里的所有数据
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "图例1")
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        //设置折现图数据
        chartView.data = chartData
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

