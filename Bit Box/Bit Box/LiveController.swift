//
//  FirstViewController.swift
//  BitBox
//
//  Created by Ashwin Aggarwal on 2/24/17.
//  Copyright © 2017 CoinTK. All rights reserved.
//

import UIKit
import SwiftCharts

class LiveController: UIViewController {

    @IBOutlet weak var graphView: GraphView!
        
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var maxPT: UILabel!
    
    @IBOutlet weak var selected: UILabel!
    
    @IBOutlet weak var SegmentedControler: UISegmentedControl!
    @IBAction func timeChanged(_ sender: Any) {
        drawTimeFrame(timeFrame:  SegmentedControler.selectedSegmentIndex)
    }
    func drawTimeFrame(timeFrame:Int) {
        setupGraphDisplay()
        let json:[[Int]] = getJson(url: "", timeFrame: timeFrame)
        graphView.graphPointsY = json[1]
        graphView.graphPointsX = json[0]
        graphView.contentMode = .redraw
        graphView.setNeedsDisplay()
        //Should redraw graphView
    }
    

    func getJson(url: String, timeFrame: Int) -> [[Int]]{

        let size:Int = Int(arc4random_uniform(20) + 1)
        let graphPoints:[[Int]] = [(makeList(n:size).sorted()), makeList(n: size)]
        return graphPoints
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        priceLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
//
//        selected.text = ""
//        let json:[[Int]] = getJson(url: "", timeFrame: 3)
//        graphView.graphPointsY = json[1]
//        graphView.graphPointsX = json[0]
//        setupGraphDisplay()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupGraphDisplay() {
        let chartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 0, to: 14, by: 2),
            yAxisConfig: ChartAxisConfig(from: 0, to: 14, by: 2)
        )
        
        let chart = LineChart(
            frame: CGRect(x: 47, y: 181, width: 300, height: 250),
            chartConfig: chartConfig,
            xTitle: "X axis",
            yTitle: "Y axis",
            lines: [
                (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.red),
                (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blue)
            ]
        )
        chart.view.backgroundColor = .green
        self.view.addSubview(chart.view)

        maxPT.text = "\(chartConfig.chartSettings.)"
        
        
        
    }

}

