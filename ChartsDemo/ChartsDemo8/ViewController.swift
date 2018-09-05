//
//  ViewController.swift
//  ChartsDemo8
//
//  Created by 南鑫林 on 2018/9/5.
//  Copyright © 2018年 南鑫林. All rights reserved.
//

import UIKit
import Charts

/// 折线图8：显示指定区域数据、选中居中） //拐点选中后自动居中
class ViewController: UIViewController {

    var chartView : LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView = LineChartView()
        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,height: 270)
        chartView.delegate = self //设置代理
        self.view.addSubview(chartView)
        
        //设置交互样式
        chartView.scaleYEnabled = false //取消X轴缩放
        chartView.scaleYEnabled = false //取消Y轴缩放
        chartView.doubleTapToZoomEnabled = false //双击缩放
        
        var dataEntries = [ChartDataEntry]()
        for i in 0..<100 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        //这50条数据作为1根折线里的所有数据
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "客流量(天)")
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        //设置折现图数据
        chartView.data = chartData
        
        //图表最多显示10个点
        chartView.setVisibleXRangeMaximum(10)
        //默认显示最一个数据
        chartView.moveViewToX(99)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        //将该点居中（其实就是将该点左边第5个点移动道图表左侧）
        self.chartView.moveViewToAnimated(xValue: entry.x - 5, yValue: 0, axis: .left, duration: 0.5)
    }
}

