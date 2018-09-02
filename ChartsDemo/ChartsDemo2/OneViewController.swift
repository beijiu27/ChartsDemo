//
//  OneViewController.swift
//  ChartsDemo2
//
//  Created by 南鑫林 on 2018/8/24.
//  Copyright © 2018年 南鑫林. All rights reserved.
//

import UIKit
import Charts

class OneViewController: UIViewController {

    //折线图
    var chartView: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //创建折线图组件对象
        chartView = LineChartView()
        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,
                                 height: 250)
        //半透明蓝色背景
        chartView.gridBackgroundColor = UIColor(red: 51/255, green: 181/255, blue: 229/255,
                                                alpha: 150/255)
        chartView.drawGridBackgroundEnabled = true
        
        self.view.addSubview(chartView)
        
        //生成第一根折线的数据
        var dataEntries1 = [ChartDataEntry]()
        for i in 0..<20 {
            let y = arc4random()%10 + 20
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries1.append(entry)
        }
        let chartDataSet1 = LineChartDataSet(values: dataEntries1, label: "最高温度")
        chartDataSet1.drawCirclesEnabled = false
        chartDataSet1.fillAlpha = 1
        chartDataSet1.drawFilledEnabled = true
        chartDataSet1.fillColor = .white
        chartDataSet1.lineWidth = 2
        chartDataSet1.drawValuesEnabled = false //不绘制拐点上的文字
        chartDataSet1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.chartView.leftAxis.axisMaximum) //向上绘制填充区域
        }
        
        //生成二根折线的数据
        var dataEntries2 = [ChartDataEntry]()
        for i in 0..<20 {
            let y = arc4random()%10
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries2.append(entry)
        }
        let chartDataSet2 = LineChartDataSet(values: dataEntries2, label: "最低温度")
        chartDataSet2.colors = [.green]
        chartDataSet2.drawCirclesEnabled = false
        chartDataSet2.fillAlpha = 1
        chartDataSet2.drawFilledEnabled = true
        chartDataSet2.fillColor = .white
        chartDataSet2.lineWidth = 2
        chartDataSet2.drawValuesEnabled = false //不绘制拐点上的文字
        chartDataSet2.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(self.chartView.leftAxis.axisMinimum) //向下绘制填充区域
        }
        
        //目前折线图只包括2根折线
        let chartData = LineChartData(dataSets: [chartDataSet1, chartDataSet2])
        
        //设置折现图数据
        chartView.data = chartData
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
