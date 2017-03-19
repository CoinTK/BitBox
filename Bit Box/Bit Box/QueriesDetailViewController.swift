//
//  QueriesDetailViewController.swift
//  BitBox
//
//  Created by Ashwin Aggarwal on 2/25/17.


import UIKit

class QueriesDetailViewController: UIViewController {

    @IBOutlet weak var query_name: UILabel!
    
    var sentName = String()
    var sentID = Int()
    
    @IBOutlet weak var worthLabel: UILabel!
    
    @IBOutlet weak var maxWT: UILabel!
    
    var first : Int = 0
    var last : Int = 0
    
    var minY : Int = 0
    
    let shared = ErrorManagement.sharedInstance
    
    @IBOutlet weak var predictionGraphView: PredictionGraphView!
        
    func getJson(id: Int) -> [[Int]] {
        let api = "http://52.41.80.130/api/backtests/results/trade?id=\(id)&page=0&page_size=1000"
        let data: NSData = try! NSData(contentsOf: NSURL(string: api) as! URL);
        if let jsonObj = try? JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary {
            if let data_array = jsonObj?.value(forKey: "data") as? NSArray {
                for values in data_array {
                    if let valueDict = values as? NSDictionary {
                        if let worth = valueDict.value(forKey: "worth") { // usernames
                            self.predictionGraphView.graphPointsY.append(worth as! Int)
                        }
                        if let timestamps = valueDict.value(forKey: "ts") {
                            self.predictionGraphView.graphPointsX.append(timestamps as! Int)
                        }
                    }
                }
            }
            first = jsonObj?.value(forKey: "first_ts") as! Int
            last = jsonObj?.value(forKey: "last_ts") as! Int
            
            
        }else {
            present(shared.showAlert(message: "Check your connection to WiFi!"), animated: true, completion: nil)

        }
        
        let graphPoints:[[Int]] = [self.predictionGraphView.graphPointsX, self.predictionGraphView.graphPointsY]
        return graphPoints
    }
    
    func drawTimeFrame(timeFrame:Int) {
        predictionGraphView.graphPointsY = []
        predictionGraphView.graphPointsX = []
        
        var _ = getJson(id: sentID)
        // stores timestamps as the x values
        // makes all values in graphPointsX between [0, 1]
        for i in 0..<predictionGraphView.graphPointsX.count {
            predictionGraphView.graphPointsX[i] = (predictionGraphView.graphPointsX[i] - first)
        }
        maxWT.text = "\(predictionGraphView.graphPointsY.max()!)"
        // sets the y values
        minY = predictionGraphView.graphPointsY.min()!
        
        predictionGraphView.contentMode = .redraw
        predictionGraphView.setNeedsDisplay()
        //Should redraw graphView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawTimeFrame(timeFrame: 3)
        
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

}
