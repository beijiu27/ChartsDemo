//
//  ViewController.swift
//  ChartsDemo5
//
//  Created by 南鑫林 on 2018/9/2.
//  Copyright © 2018年 南鑫林. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    var chartView : LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView = LineChartView()
        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,height: 270)
        //1，只显示左侧的 Y 轴
        //（1）默认情况下表格左右两侧均有 Y 轴显示：左侧 Y 轴为 leftAxis、右侧 Y 轴为 rightAxis。
        chartView.rightAxis.drawLabelsEnabled = false
        //3）右侧 Y 轴的文字和轴线均不显示。
        chartView.rightAxis.enabled = false //禁用右侧的Y轴
//        chartView.rightAxis.drawLabelsEnabled = false //不绘制右侧Y轴文字
//        chartView.rightAxis.drawAxisLineEnabled = false //不显示右侧Y轴
        chartView.leftAxis.inverted = true //刻度值反向排列
        
        //3，设置坐标轴刻度文字显示位置
        //和 X 轴一样，我们也可以将 Y 轴文字显示在轴线内侧。
        chartView.leftAxis.labelPosition = .insideChart //文字显示在内侧
        //4，设置 Y 轴的颜色和线宽
        chartView.leftAxis.axisLineWidth = 2 //左x轴宽度
        chartView.leftAxis.axisLineColor = .orange //左x轴颜色
        //5.指定最小、最大刻度值
        chartView.leftAxis.axisMinimum = -100 //最小刻度值
        chartView.leftAxis.axisMaximum = 100 //最大刻度值
        //6.指定刻度间的最小间隔
        chartView.leftAxis.granularity = 50 //最小间隔
        //7.绘制 0 刻度线
        // （1）将 drawZeroLineEnabled 设置为 true 则会在 0 刻度位置绘制一条有别于其它网格线的横线。
        chartView.leftAxis.drawZeroLineEnabled = true //绘制0刻度线
        chartView.leftAxis.zeroLineColor = .orange  //0刻度线颜色
        chartView.leftAxis.zeroLineWidth = 2 //0刻度线线宽
        chartView.leftAxis.zeroLineDashLengths = [4, 2] //0刻度线使用虚线样式
        //8，设置刻度文字的样式
        chartView.leftAxis.labelTextColor = .orange //刻度文字颜色
        chartView.leftAxis.labelFont = .systemFont(ofSize: 14) //刻度文字大小
        //9，设置对应网格线的样式
        chartView.leftAxis.gridColor = .orange //左Y轴对应网格线的颜色
        chartView.leftAxis.gridLineWidth = 2 //右Y轴对应网格线的大小
        chartView.xAxis.gridLineDashLengths = [4,2]  //虚线各段长度
        chartView.leftAxis.drawGridLinesEnabled = false //不绘制网格线
        //10，刻度文字的格式化
        let formatter = NumberFormatter()  //自定义格式
        formatter.positiveSuffix = "%"  //数字后缀
        chartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        
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

