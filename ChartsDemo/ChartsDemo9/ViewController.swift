//
//  ViewController.swift
//  ChartsDemo9
//
//  Created by 南鑫林 on 2018/9/5.
//  Copyright © 2018年 南鑫林. All rights reserved.
//

import UIKit
import Charts

/// （折线图9：自动显示中间拐点标签、滑动居中）
class ViewController: UIViewController {
    
    var chartView : LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        highlightCenterValue()
    }
    
    //自动选中图表中央的数据点
    func highlightCenterValue() {
        //获取中点坐标
        let x = Double(chartView.bounds.width/2)
        let selectionPoint = CGPoint(x: x, y: 0)
        //获取最接近中点位置的数据点
        let h = chartView.getHighlightByTouchPoint(selectionPoint)
        //将这个数据点高亮（同时自动调用 chartValueSelected 这个代理方法）
        chartView.highlightValue(h, callDelegate: true)
    }
    
    //显示MarkerView标签
    func showMarkerView(value:String){
        //使用气泡状的标签
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = self.chartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        marker.setLabel("数据：\(value)")
        self.chartView.marker = marker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: ChartViewDelegate {
    
    //图表通过手势拖动后的回调
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        //自动选中图表中央的数据点
        highlightCenterValue()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        //将该点居中（其实就是将该点左边第5个点移动道图表左侧）
        self.chartView.moveViewToAnimated(xValue: entry.x - 5, yValue: 0, axis: .left, duration: 0.5)
        showMarkerView(value: "\(entry.y)")
    }
}


