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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)

        selected.text = ""
        setupGraphDisplay()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupGraphDisplay() {
        maxPT.text = "\(graphView.graphPoints.max()!)"
            }

}

extension LiveController: GraphViewDelegate {
    func getSelectedValue(string: String) {
        self.selected.text = string
    }
}
