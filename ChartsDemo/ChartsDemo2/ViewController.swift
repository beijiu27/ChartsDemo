//
//  ViewController.swift
//  ChartsDemo2
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
        
        //将线条颜色设置为橙色
//        chartDataSet.colors = [.orange]
        //将线条颜色设置为3种颜色交替显示
        chartDataSet.colors = [.orange, .red, .yellow]
        //修改线条大小
        chartDataSet.lineWidth = 2
        
        //2，修改折点的颜色、大小
        chartDataSet.circleColors = [.yellow]  //外圆颜色
        chartDataSet.circleHoleColor = .red  //内圆颜色
        chartDataSet.circleRadius = 6 //外圆半径
        chartDataSet.circleHoleRadius = 2 //内圆半径
        
        // 3，不显示折点
        //（1）内外圆均不显示
//        chartDataSet.drawCirclesEnabled = false //不绘制转折点
        //（2）仅仅不显示内圆。
        chartDataSet.drawCircleHoleEnabled = false  //不绘制转折点内圆
        
        //4，使用虚线显示
        chartDataSet.lineDashLengths = [4,2] //设置虚线各段长度
        //5，曲线平滑显示
        //（1）使用 mode 属性可以设置折线显示模式：
        chartDataSet.mode = .horizontalBezier  //贝塞尔曲线
        //（2）该属性可选值有 4 种：.line、.cubicBezier、.horizontalBezier、.stepped。其中默认样式是 line，其它 3 种的效果分别如下：
        //6，修改线条上的文字颜色
        chartDataSet.valueColors = [.blue] //拐点上的文字颜色
        chartDataSet.valueFont = .systemFont(ofSize: 9) //拐点上的文字大小
        //7，不显示线条上的文字
        chartDataSet.drawValuesEnabled = false //不绘制拐点上的文字
        //8，线条上文字的格式化显示
        //下面对所有拐点文字在外部标注百分比（%）
        let formatter = NumberFormatter()  //自定义格式
        formatter.positiveSuffix = "%"  //数字后缀单位
        chartDataSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
        //9，绘制填充色背景
        //1）下面样例给折线添加一个半透明的填充色，使其变成面积图。
        chartDataSet.drawFilledEnabled = true //开启填充色绘制
        chartDataSet.fillColor = .orange  //设置填充色
        chartDataSet.fillAlpha = 0.5 //设置填充色透明度
        //（2）当然也可以使用渐变色填充：
        //开启填充色绘制
        chartDataSet.drawFilledEnabled = true
        //渐变颜色数组
        let gradientColors = [UIColor.orange.cgColor, UIColor.white.cgColor] as CFArray
        //每组颜色所在位置（范围0~1)
        let colorLocations:[CGFloat] = [1.0, 0.0]
        //生成渐变色
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                       colors: gradientColors, locations: colorLocations)
        //将渐变色作为填充对象s
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        
        
        //目前折线图只包括1根折线
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        //设置折现图数据
        chartView.data = chartData
        
        
        
    }

    @IBAction func button(_ sender: UIButton) {
        let oneVC = OneViewController()
        self.present(oneVC, animated: true) {
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

