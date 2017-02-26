//
//  FirstViewController.swift
//  BitBox
//
//  Created by Ashwin Aggarwal on 2/24/17.
//  Copyright © 2017 CoinTK. All rights reserved.
//

import UIKit

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
    
    func makeList(n:Int ) -> [Int] {
        var result:[Int] = []
        for _ in 0..<n {
            result.append(Int(arc4random_uniform(20) + 1))
        }
        return result
    }

    func getJson(url: String, timeFrame: Int) -> [[Int]]{
        let size:Int = Int(arc4random_uniform(20) + 1)
        let graphPoints:[[Int]] = [(makeList(n:size).sorted()), makeList(n: size)]
        return graphPoints
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        priceLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)

        selected.text = ""
        let json:[[Int]] = getJson(url: "", timeFrame: 3)
        graphView.graphPointsY = json[1]
        graphView.graphPointsX = json[0]
        setupGraphDisplay()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupGraphDisplay() {
        maxPT.text = "\(graphView.graphPointsY.max()!)"
            }

}

extension LiveController: GraphViewDelegate {
    func getSelectedValue(string: String) {
        self.selected.text = string
    }
}
