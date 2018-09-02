//
//  ViewController.swift
//  ChartsDemo4
//
//  Created by 南鑫林 on 2018/8/31.
//  Copyright © 2018年 南鑫林. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    //四、X 轴的样式设置
    var chartView : LineChartView!;
    override func viewDidLoad() {
        super.viewDidLoad()
        /*1，设置 x 轴位置
        （1）默认情况下 x 轴是在图表上方，我们可以通过 xAxis.labelPosition 属性修改它的位置：
            .top：上方（默认）
            .bottom：下方
            .bothSided：上下均有
         */
        //创建折线图组件对象
        chartView = LineChartView()
        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,height: 270)
//        chartView.xAxis.labelPosition = .bottom //x轴显示在下方
//        chartView.xAxis.labelPosition = .top //x轴显示在上方
        chartView.xAxis.labelPosition = .bothSided //上下均有
        //2，设置 x 轴的颜色和线宽
        chartView.xAxis.axisLineWidth = 2; //x轴宽度
        chartView.xAxis.axisLineColor = .orange //x轴颜色
        
        //3，指定最小、最大刻度值
        chartView.xAxis.axisMinimum = -15 //最小刻度
        chartView.xAxis.axisMaximum = 15 //最大刻度
        
        //4，指定刻度间的最小间隔
        chartView.xAxis.granularity = 1 //最小间隔
        
        //5，设置刻度文字的样式
        chartView.xAxis.labelTextColor = .orange //刻度文字颜色
        chartView.xAxis.labelFont = .systemFont(ofSize: 14) //刻度文字大小
        chartView.xAxis.labelRotationAngle = -30 //刻度文字倾斜角度
        
        //6，设置对应网格线的样式
        //（1）修改网格线的颜色和粗细。
        chartView.xAxis.gridColor = .orange //x轴对应网格线的颜色
        chartView.xAxis.gridLineWidth = 2 //x轴对应网格线的大小
        
        //(2）显示虚线形式的网格线。
        chartView.xAxis.gridLineDashLengths = [4,2]
        //(3) 不显示网格
        chartView.xAxis.drawGridLinesEnabled = false //不绘制网格
        /// 7.刻度文字的格式化
        let formatter = NumberFormatter() //自定时格式
        formatter.positivePrefix = "#"
        chartView.xAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        /// 8.自定义刻度标签
        let xValues = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月"]
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        
        

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

