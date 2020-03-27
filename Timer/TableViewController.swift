//
//  TableViewController.swift
//  Timer
//
//  Created by Antoine NICOT on 14/03/2020.
//  Copyright © 2020 maxime. All rights reserved.


import UIKit

class TableViewController: UITableViewController, CellDelegate {
    var data = [String]()
    var dataTimer = [String]()
    var dataDefaults = NSUserDefaults.standardUserDefaults()
    var dataTimerDefaults = NSUserDefaults.standardUserDefaults()
    
    
    var totalChrono = 0
    var identifier = 1
    var monTitre = ""
    
    
    
    @IBOutlet var viewTable: UITableView!
   
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.topItem?.title = monTitre
        print("identifier" + String(identifier))
        
        tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
      
        if(dataDefaults.stringArrayForKey("keyData4" + String(identifier)) != nil){
        data = dataDefaults.stringArrayForKey("keyData4" + String(identifier))!
        dataTimer = dataTimerDefaults.stringArrayForKey("keyDataTimer4" + String(identifier))!
        //tableView.reloadData()
        }
        dataDefaults.setValue(data, forKey: "keyData4" + String(identifier))
        dataTimerDefaults.setValue(dataTimer, forKey: "keyDataTimer4" + String(identifier))
        
        print(totalChrono)
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
        
        let nbRow = dataTimerDefaults.stringArrayForKey("keyDataTimer4" + String(identifier))!.count
        
        return (nbRow)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        
        dataTimer[indexPath.row] = cell.labelTimer.text!
        //cell.labelTimer.text = dataTimer[indexPath.row]
        
        cell.label.text = data[indexPath.row]
        
        cell.identifier = indexPath.row + 1000 + identifier
        cell.starter()
        cell.delegate = self
        
        
        totalChrono = totalChrono + cell.chrono
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
        
        currentCell.activerTimer()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        dataDefaults.setValue(totalChrono, forKey: "totalChrono" + String(identifier))
        
        if(segue.identifier == "segueNewTask"){
            let vc = segue.destinationViewController as! NewTaskController
            vc.identifier = self.identifier
            vc.projectTitre = self.monTitre
        }
        else{
        }
        
    }
   
    //protocol
    func SegueFromCell(mydata dataobject: AnyObject){
        self.performSegueWithIdentifier("segueBrochure", sender: dataobject)
    }


}
