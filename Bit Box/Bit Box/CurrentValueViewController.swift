//
//  CurrentValueViewController.swift
//  Bit Box
//
//  Created by Ashwin Aggarwal on 2/27/17.
//  Copyright © 2017 CoinTK. All rights reserved.
//

import UIKit

class CurrentValueViewController: UIViewController {

    let current_api = "http://52.41.80.130/api/live/bitcoin_current"
    
    @IBOutlet weak var value_label: UILabel!
    
    @IBOutlet weak var currency: UILabel!
    
    @IBOutlet weak var as_of_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
