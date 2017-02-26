//
//  SecondViewController.swift
//  BitBox
//
//  Created by Ashwin Aggarwal on 2/24/17.
//  Copyright © 2017 CoinTK. All rights reserved.
//

import UIKit

class QueriesViewController: UITableViewController {
    
    var names : [String] = ["Naive", "Reverse Naive"]
    
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.table.delegate = self
        self.table.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        table.reloadData()
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QueriesTableViewCell
        cell.queryname.text = names[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
            let destination = segue.destination as? QueriesDetailViewController,
            let detailIndex = table.indexPathForSelectedRow?.row
        {
            
            destination.sentName = names[detailIndex]
        }
    }
    //    func getJSON(urlAddress : String)
//    {
//        // Asynchronous Http call to your api url, using NSURLSession:
//        guard let url = URL(string: urlAddress) else
//        {
//            print("Url conversion issue.")
//            return
//        }
//        // task
//        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
//            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
//                if let related_topics_array = jsonObj?.value(forKey: "RelatedTopics") as? NSArray {
//                    for topic in related_topics_array {
//                        if let topicDict = topic as? NSDictionary {
//                            if let firsturl = topicDict.value(forKey: "FirstURL") { // usernames
//                                self.firsturls.append(firsturl as! String)
//                            }
//                            if let text = topicDict.value(forKey: "Text") {
//                                self.texts.append(text as! String)
//                            }
//                            
//                            // get back to main thread before reloading
//                            OperationQueue.main.addOperation ({
//                                self.table.reloadData()
//                            })
//                        }
//                    }
//                }
//                
//                
//            }
//        }).resume()
//    }


}

