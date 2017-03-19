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
    
    var first : Int = 0
    var last : Int = 0
    
    
    let api = "http://52.41.80.130/api/backtests/results/trade?id=0&page=2&page_size=150&start_ts=0&end_ts=2481003761"
    
    @IBAction func timeChanged(_ sender: Any) {
        drawTimeFrame(timeFrame:  SegmentedControler.selectedSegmentIndex)
    }
    func drawTimeFrame(timeFrame:Int) {
        let json:[[Int]] = getJson(url: api, timeFrame: timeFrame)
        for i in 0..<graphView.graphPointsX.count {
            graphView.graphPointsX[i] = (graphView.graphPointsX[i] - first) / (last - first)
        }
        graphView.graphPointsY = json[1]
        graphView.graphPointsX = json[0]
        graphView.contentMode = .redraw
        graphView.setNeedsDisplay()
        //Should redraw graphView
    }

    
    func getJson(url: String, timeFrame: Int) -> [[Int]]{
        // Asynchronous Http call to your api url, using NSURLSession:
        guard URL(string: url) != nil else
        {
            print("Url conversion issue.")
            return []
        }
        
        let data: NSData = try! NSData(contentsOf: NSURL(string: url) as! URL);
        if let jsonObj = try? JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary {
            if let data_array = jsonObj?.value(forKey: "data") as? NSArray {
                for values in data_array {
                    if let valueDict = values as? NSDictionary {
                        if let worth = valueDict.value(forKey: "worth") { // usernames
                            self.graphView.graphPointsY.append(worth as! Int)
                        }
                        if let timestamps = valueDict.value(forKey: "ts") {
                            self.graphView.graphPointsX.append(timestamps as! Int)
                        }
                    }
                }
            }
            first = jsonObj?.value(forKey: "first_ts") as! Int
            last = jsonObj?.value(forKey: "last_ts") as! Int
        }

        let graphPoints:[[Int]] = [self.graphView.graphPointsX, self.graphView.graphPointsY]
        return graphPoints
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        selected.text = ""
        let json:[[Int]] = getJson(url: api, timeFrame: 3)
        graphView.graphPointsY = json[1]
        graphView.graphPointsX = json[0]
        drawTimeFrame(timeFrame: 3)
        //maxPT.text = "\(graphView.graphPointsY.max()!)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
