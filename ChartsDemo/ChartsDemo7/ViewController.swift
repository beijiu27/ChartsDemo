//
//  ViewController.swift
//  ChartsDemo7
//
//  Created by 南鑫林 on 2018/9/3.
//  Copyright © 2018年 南鑫林. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    var chartsView : LineChartView!
    var circleColors: [UIColor] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        chartsView = LineChartView()
        chartsView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,height: 270)
        chartsView.delegate = self
        self.view.addSubview(chartsView)
        
        var dataEntries = [ChartDataEntry]()
        for i in 0..<10 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries.append(entry)
            //每个点默认颜色都是蓝色
            circleColors.append(.cyan)
        }
        //这10条数据作为1根折线里的所有数据
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "图例1")
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        //设置折现图数据
        chartsView.data = chartData
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: ChartViewDelegate {
    //折线上的点选中回调
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("选中了一个数据")
        //显示该点的MarkerView标签
        self.showMarkerView(value: "\(entry.y)")
        //将选中的数据点的颜色改成黄色
        var chartDataSet = LineChartDataSet()
        chartDataSet = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        let values = chartDataSet.values
        let index = values.index(where: {$0.x == highlight.x})  //获取索引
        chartDataSet.circleColors = circleColors //还原
        chartDataSet.circleColors[index!] = .orange
        
        //重新渲染表格
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }
//    //显示MarkerView标签
//    func showMarkerView(value:String){
//        let marker = MarkerView(frame: CGRect(x: 20, y: 20, width: 80, height: 20))
//        marker.chartView = self.chartsView
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
//        label.text = "数据：\(value)"
//        label.textColor = UIColor.white
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.backgroundColor = UIColor.gray
//        label.textAlignment = .center
//        marker.addSubview(label)
//        self.chartsView.marker = marker
//    }
    
    //显示MarkerView标签
    func showMarkerView(value:String){
        //使用气泡状的标签
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = self.chartsView
        marker.minimumSize = CGSize(width: 80, height: 40)
        marker.setLabel("数据：\(value)")
        self.chartsView.marker = marker
    }
    
    //折线上的点取消选中回调
    internal func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("取消选中的数据")
        //还原所有点的颜色
        var chartDataSet = LineChartDataSet()
        chartDataSet = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        chartDataSet.circleColors = circleColors
        
        //重新渲染表格
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }
    
    //图表通过手势缩放后的回调
    func chartScaled(_ chartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        print("图表缩放了")
    }
    
    //图表通过手势拖动后的回调
    func chartTranslated(_ chartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        print("图表移动了")
    }
    
}

