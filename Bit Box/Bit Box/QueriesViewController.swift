//
//  SecondViewController.swift
//  BitBox
//
//  Created by Ashwin Aggarwal on 2/24/17.
//

// import Soylent (HackIllinois2017)
import UIKit

class QueriesViewController: UITableViewController {
    
    var names : [String] = []
    var ids : [Int] = []
    // BitBox-Server
    let api = "http://52.41.80.130/api/backtests/list"
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.table.delegate = self
        self.table.dataSource = self
        // sets id values
        getJSON(urlAddress: api)
        for i in 0..<names.count {
            ids.append(i)
        }
        // customize navigation styles globally
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            destination.sentID = ids[detailIndex]
        }
    }
    
    func getJSON(urlAddress: String) {
        // check to see if url is valid
        guard let url = URL(string: urlAddress) else
        {
            present(ErrorManagement.sharedInstance.showAlert(message: "Check your connection!"), animated: true, completion: nil)
            return
        }
        
        // retrieves all data
        let data: NSData = try! NSData(contentsOf: url);
        if let jsonObj = try? JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSArray {
            let list_array = jsonObj as? [[String: Any]]
            for listitem in list_array! {
                if let itemsDict = listitem as? NSDictionary {
                    if let name  = itemsDict.value(forKey: "name") {
                        self.names.append(name as! String)
                    }
                }
            }
            
        }else {
            present(ErrorManagement.sharedInstance.showAlert(message: "Server is down for maintainence! Try again later!"), animated: true, completion: nil)
        }
    }
}

