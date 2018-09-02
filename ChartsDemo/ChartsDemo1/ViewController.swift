//
//  ViewController.swift
//  ChartsDemo1
//
//  Created by 南鑫林 on 2018/8/24.
//  Copyright © 2018年 南鑫林. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    //折线图
    var chartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         （1）效果图
         我们将折线图整体背景修改成黄色。
         当折线图无数据时显示“暂无数据”提示文字。
         右下角添加了个红色的描述文字“考试成绩”。
         修改默认的手势功能，让表格只能在横向缩放（x 轴），纵向不能缩放（y 轴）。
         */
        //创建折线图组件对象
        chartView = LineChartView()
        chartView.frame = CGRect(x: 0, y: 80, width: self.view.bounds.width, height: 300)
        self.view.addSubview(chartView)
        //折线图背景图
        chartView.backgroundColor = UIColor.yellow
         //折线图无数据时显示的提示文字
        chartView.noDataText = "暂无数据"
        //折线图描述文字和样式
        chartView.chartDescription?.text = "考试成绩"
        chartView.chartDescription?.textColor = UIColor.red
        
         //设置交互样式
        chartView.scaleYEnabled = false //取消Y轴缩放
        chartView.doubleTapToZoomEnabled = true //双击缩放
        chartView.dragEnabled = true //启用拖动手势
        chartView.dragDecelerationEnabled = true //拖拽后是否有惯性效果
        chartView.dragDecelerationFrictionCoef = 0.9 //拖拽后惯性效果摩擦系数(0~1)越小惯性越不明显
        //（1）下面样例绘制出图形区域（坐标轴内的区域）的背景色和边框，默认绘制为灰色
        chartView.drawGridBackgroundEnabled = true  //绘制图形区域背景
        chartView.drawBordersEnabled = true  //绘制图形区域边框
        // (2)下面修改背景色和边框样式：
        chartView.gridBackgroundColor = .yellow //背景改成黄色
        chartView.borderColor = .blue  //边框为蓝色
        chartView.borderLineWidth = 3  //边框线条大小为3
        //图例文字颜色
        chartView.legend.textColor = UIColor.purple
        //（2）图例大小（头部）
        chartView.legend.formSize = 5
        /*
         图例头部样式
         圆形：.circle
         矩形：.square（默认值）
         横线：.line
         无：.none
         空：.empty（与 .none 一样都不显示头部，但不同的是 empty 头部仍然会占一个位置）
         */
        chartView.legend.form = .circle
       
        
        //生成8条随机数据
        var dataEntries = [ChartDataEntry]()
        for i in 0..<8 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        //这50条数据作为1根折线里的所有数据
        let chartDataSet1 = LineChartDataSet(values: dataEntries, label: "李子明")
        chartDataSet1.colors = [.orange]
        
        //生成第二条折线数据
        var dataEntries2 = [ChartDataEntry]()
        for i in 0..<8 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries2.append(entry)
        }
        let chartDataSet2 = LineChartDataSet(values: dataEntries2, label: "王大锤")
        chartDataSet2.colors = [.green]

        
        //目前折线图包括2根折线
        let chartData = LineChartData(dataSets: [chartDataSet1, chartDataSet2])
        
        //设置折现图数据
        chartView.data = chartData

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

