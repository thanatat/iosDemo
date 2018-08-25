//
//  TableViewController.swift
//  Hello
//
//  Created by Thanatat Boorapan on 21/8/18.
//  Copyright © 2018 Thanatat Boorapan. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {
    
    var editState = false
    @IBOutlet weak var tblTask: UITableView!
    @IBAction func btnEdit(_ sender: UIBarButtonItem) {
        if editState == false {
            self.tblTask.isEditing = true
            self.tblTask.setEditing(true, animated: true)
            editState = true
        } else {
            self.tblTask.isEditing = false
            editState = false
        }
    }
    
   
    
    let dailyTasks = ["Check all windows \n other string \n some",
                      "Check all doors",
                      "Is the boiler fueled?",
                      "Check the mailbox",
                      "Empty trash containers",
                      "If freezing, check water pipes",
                      "Document \"strange and unusual\" occurrences",]
    
    let weeklyTasks = ["Check inside all cabins",
                       "Flush all lavatories in cabins",
                       "Walk the perimeter of property",]
    
    let monthlyTasks = ["Test security alarm",
                        "Test motion detectors",
                        "Test smoke alarms"]
    var products: [Product] = []
    
    static let SERVICEURL = "http://localhost:3000/products"

    func fetchData(url: String) {
        Alamofire.request(url).responseString(completionHandler: { (response) in
            if response.value?.isEmpty == false {
                print("Show data")
            } else {
                print("No data")
            }
        }).responseJSON(completionHandler: { (response) in
            let decoder = JSONDecoder()
            do {
                self.products = try decoder.decode([Product].self, from: response.data!)
                self.tblTask.reloadData()
//                print(self.products[0].productName)
//                print(self.products[0].comments[0].message)
            } catch {
                print("Error: Can't decode json data")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblTask.estimatedRowHeight = 43
        self.tblTask.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData(url: TableViewController.SERVICEURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Products"
        case 1:
            return "Daily Tasks"
        case 2:
            return "Weekly Tasks"
        case 3:
            return "Monthly Tasks"
        default:
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.products.count
        case 1:
            return self.weeklyTasks.count
        case 2:
            return self.monthlyTasks.count
        case 3:
            return self.dailyTasks.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = CustomTableViewCell()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell") as! CustomTableViewCell

        switch indexPath.section {
        case 0:
            cell.lblTasks?.text = self.products[indexPath.row].productName
        case 1:
            cell.lblTasks?.text = self.dailyTasks[indexPath.row]
        case 2:
            cell.lblTasks?.text = self.weeklyTasks[indexPath.row]
        case 3:
            cell.lblTasks?.text = self.monthlyTasks[indexPath.row]
        default:
            cell.lblTasks?.text = "No Data"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You just selected \(indexPath.row) on section \(indexPath.section)")
        var message = String()
        
        
        switch indexPath.section {
        case 0:
            message = products[indexPath.row].productName
        case 1:
            message = dailyTasks[indexPath.row]
        case 2:
            message = weeklyTasks[indexPath.row]
        case 3:
            message = monthlyTasks[indexPath.row]
        default:
            print("")
        }
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        destination.message = message
        self.navigationController?.pushViewController(destination, animated: true)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return true
        } else {
            return false
        }
        
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("indexrow: \(indexPath.row)")
            self.removeData(row: products[indexPath.row].id)
            self.products.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func removeData(row: Int) {
        print("row: \(row)")
        Alamofire.request("\(TableViewController.SERVICEURL)/\(row)", method: .delete)
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
