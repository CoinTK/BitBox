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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        worthLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        maxWT.text = "\(predictionGraphView.graphPoints.max()!)"

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
