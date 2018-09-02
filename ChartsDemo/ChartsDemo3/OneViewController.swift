//
//  OneViewController.swift
//  ChartsDemo3
//
//  Created by 南鑫林 on 2018/8/26.
//  Copyright © 2018年 南鑫林. All rights reserved.
//

import UIKit
import Charts

/*附：拐点被选中后自动改变颜色
1，效果图
当一个拐点被选中后默认只会在它的位置处显示一个十字线，这样可能还不够明显。下面我们将选中点的颜色做个变化，这样就与其他的点区分开了。

*/
class OneViewController: UIViewController,ChartViewDelegate {
    //折线图
    var chartView: LineChartView!
    //所有点的颜色
    var circleColors: [UIColor] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor  = UIColor.white
        //创建折线图组件对象
        chartView = LineChartView()
        chartView.frame = CGRect(x: 20, y: 80, width: self.view.bounds.width - 40,
                                 height: 270)
        chartView.delegate = self //设置代理
        self.view.addSubview(chartView)
        
        //生成10条随机数据
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
        //目前折线图只包括1根折线
        let chartData = LineChartData(dataSets: [chartDataSet])
        //设置折点颜色
        chartDataSet.circleColors = circleColors
        
        //设置折现图数据
        chartView.data = chartData
        
    }
    
    //折线上的点选中回调
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry,
                            highlight: Highlight) {
        print("选中了一个数据")
        
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
    //折线上的点取消选中回调
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("取消选中的数据")
        
        //还原所有点的颜色
        var chartDataSet = LineChartDataSet()
        chartDataSet = (chartView.data?.dataSets[0] as? LineChartDataSet)!
        chartDataSet.circleColors = circleColors
        
        //重新渲染表格
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
