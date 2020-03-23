//
//  TableViewController.swift
//  Timer
//
//  Created by Antoine NICOT on 14/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, CellDelegate {
    var data = ["Jigoula","Paul"]
    var dataTimer = ["0","0"]
   
    var dataDefaults = NSUserDefaults.standardUserDefaults()
    var dataTimerDefaults = NSUserDefaults.standardUserDefaults()
    
    var identifier = 0
    var monTitre = "a"
    
    @IBOutlet var viewTable: UITableView!
   
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(monTitre)

        navigationBar.topItem?.title = monTitre
        
        tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
      
        if(dataDefaults.stringArrayForKey("keyData3") != nil){
        data = dataDefaults.stringArrayForKey("keyData3")!
        dataTimer = dataTimerDefaults.stringArrayForKey("keyDataTimer3")!
        //tableView.reloadData()
        }
        dataDefaults.setValue(data, forKey: "keyData3")
        dataTimerDefaults.setValue(dataTimer, forKey: "keyDataTimer3")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let nbRow = dataTimerDefaults.stringArrayForKey("keyDataTimer3")!.count
        
        return (nbRow)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        
        dataTimer[indexPath.row] = cell.labelTimer.text!
        //cell.labelTimer.text = dataTimer[indexPath.row]
        
        cell.label.text = data[indexPath.row]
        
        cell.identifier = indexPath.row + 100
        cell.starter()
        cell.delegate = self
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
        
        currentCell.activerTimer()
    }
    
    //protocol
    func SegueFromCell(mydata dataobject: AnyObject){
        self.performSegueWithIdentifier("segueBrochure", sender: dataobject)
    }

    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
