//
//  ViewController.swift
//  ChartsDemo3
//
//  Created by 南鑫林 on 2018/8/26.
//  Copyright © 2018年 南鑫林. All rights reserved.
//

import UIKit
import Charts

//Swift - 第三方图表库Charts使用详解4（折线图3：选中点高亮、十字线样式）

class ViewController: UIViewController {
    
    var chartView: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //当我们选中某个拐点时，该点会高亮（显示十字线），这个十字线的样式是可以修改的。
        
        //1，修改十字线的样式
        //折线图

        
        //创建折线图组件对象
        chartView = LineChartView()
        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,height: 270)
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
        chartDataSet.highlightColor = .blue //十字线颜色
        chartDataSet.highlightLineWidth = 2 //十字线线宽
        chartDataSet.highlightLineDashLengths = [4, 2] //使用虚线样式的十字线
        chartDataSet.drawVerticalHighlightIndicatorEnabled = false //不显示纵向十字线
        chartDataSet.highlightEnabled = false //不启用十字线
        //目前折线图只包括2根折线
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        //设置折现图数据
        chartView.data = chartData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pushAction(_ sender: Any) {
        self.present(OneViewController(), animated: true) {
            
        }
    }
    
}

