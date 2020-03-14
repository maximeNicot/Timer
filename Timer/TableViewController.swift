//
//  TableViewController.swift
//  Timer
//
//  Created by Antoine NICOT on 14/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var data = ["Orleans", "Rys","Jigoula"]
    var dataTimer = ["0","0","0"]
    var timer = NSTimer()
    var chrono : Int = 0
    var oneTimer = true
    var myIndexPathRow = 0
    var myIndex = 0
    
    @IBOutlet var viewTable: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print(data.count)
        //self.tableView.delegate = self
        //self.tableView.dataSource = self
        
        tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
      
        
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
        return (data.count)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        print(indexPath.row)
        cell.labelTimer.text = dataTimer[indexPath.row]
        cell.label.text = data[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        myIndex = indexPath.row
        data[indexPath.row] = "Orlins"
        
        if(oneTimer){
            self.timer =  NSTimer.scheduledTimerWithTimeInterval(1.0,target: self, selector: Selector("incrementer"), userInfo: nil, repeats: true)
            oneTimer = false
        }
        myIndexPathRow = indexPath.row
        
        tableView.reloadData()
    }
    
    
    internal func incrementer(){
        
        chrono += 1
        dataTimer[myIndexPathRow] = String(chrono)
        tableView.reloadData()
    }

    
    
    /*@IBAction func quickStartAction(sender: AnyObject) {
        
        
        if(oneTimer){
            self.timer =  NSTimer.scheduledTimerWithTimeInterval(1.0,target: self, selector: Selector("incrementer"), userInfo: nil, repeats: true)
            oneTimer = false
        }
        
    }
    
    @IBOutlet weak var pause: UIButton!
    @IBAction func pause(sender: AnyObject) {
        oneTimer = true
        timer.invalidate()
    }
    
    @IBAction func stop(sender: AnyObject) {
        chrono = 0
        labelTimer.text = String(chrono)
        oneTimer = true
        timer.invalidate()
    }
    
    internal func incrementer(){
        chrono += 1
        labelTimer.text = "\(chrono)"
    }*/

    
    
    

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
