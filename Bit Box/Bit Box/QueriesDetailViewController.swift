//
//  QueriesDetailViewController.swift
//  BitBox
//
//  Created by Ashwin Aggarwal on 2/25/17.
//  Copyright © 2017 CoinTK. All rights reserved.
//

import UIKit

class QueriesDetailViewController: UIViewController {

    
    @IBOutlet weak var query_name: UILabel!
    
    var sentName = String()
    
    @IBOutlet weak var worthLabel: UILabel!
    
    @IBOutlet weak var maxWT: UILabel!
    
    @IBOutlet weak var predictionGraphView: PredictionGraphView!
    @IBAction func selectedTimeFrame(_ sender: Any) {
        drawTimeFrame(timeFrame:  TimeFrame.selectedSegmentIndex)
    }
    @IBOutlet weak var TimeFrame: UISegmentedControl!
    
    func makeList(n:Int ) -> [Int] {
        var result:[Int] = []
        for _ in 0..<n {
            result.append(Int(arc4random_uniform(20) + 1))
        }
        return result
    }
    
    func getJson(url: String, timeFrame: Int, query_name: String) -> [[Int]]{
        let size:Int = Int(arc4random_uniform(20) + 1)
        let graphPoints:[[Int]] = [(makeList(n:size).sorted()), makeList(n: size)]
        return graphPoints
    }
    
    func drawTimeFrame(timeFrame:Int) {
        maxWT.text = "\(predictionGraphView.graphPointsY.max()!)"
        let json:[[Int]] = getJson(url: "", timeFrame: timeFrame, query_name: self.sentName)
        predictionGraphView.graphPointsY = json[1]
        predictionGraphView.graphPointsX = json[0]
        predictionGraphView.contentMode = .redraw
        predictionGraphView.setNeedsDisplay()
        //Should redraw graphView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let json:[[Int]] = getJson(url: "", timeFrame: 3, query_name: self.sentName)
        predictionGraphView.graphPointsY = json[1]
        predictionGraphView.graphPointsX = json[0]

        worthLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        maxWT.text = "\(predictionGraphView.graphPointsY.max()!)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        query_name.text = sentName
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
