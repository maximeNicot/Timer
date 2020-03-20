//
//  ViewController.swift
//  Timer
//
//  Created by Antoine NICOT on 01/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, CellDelegate{
  
    
    @IBOutlet weak var tableView: UITableView!

    
    //on affiche a partir des data
    var data = [String]()
    var dataTimer = [String]()
    
    var dataQuickTask = [String]()
    var dataQuickTaskTimer = [String]()
    var dataQuickTaskDefaults = NSUserDefaults.standardUserDefaults()
    var dataQuickTaskTimerDefaults = NSUserDefaults.standardUserDefaults()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(dataQuickTaskDefaults.stringArrayForKey("keyQuickTask3") != nil){
            dataQuickTask = dataQuickTaskDefaults.stringArrayForKey("keyQuickTask3")!
            dataQuickTaskTimer = dataQuickTaskTimerDefaults.stringArrayForKey("keyQuickTaskTimer3")!
            
            for i in dataQuickTask{
                data.append(i)
            }
            for i in dataQuickTaskTimer{
                dataTimer.append(i)
            }
        }
        
        tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func quickStart(sender: AnyObject) {
        dataQuickTask.append("Quick Task" + String(dataQuickTask.count))
        dataQuickTaskTimer.append("0")
        dataQuickTaskDefaults.setValue(dataQuickTask, forKey: "keyQuickTask3")
        dataQuickTaskTimerDefaults.setValue(dataQuickTaskTimer, forKey: "keyQuickTaskTimer3")
        
        data.append("Quick Task " + String(dataQuickTask.count + 1))
        dataTimer.append("0")
        
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
   
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (data.count)
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        
        dataTimer[indexPath.row] = cell.labelTimer.text!
        
        cell.label.text = data[indexPath.row]
        
        cell.identifier = indexPath.row + 9999
        cell.starter()
        //cell.activerTimer()
        cell.delegate = self
       
        return cell
        
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
        
        currentCell.activerTimer()
        
    }
    
    //protocol
    func SegueFromCell(mydata dataobject: AnyObject){
        //comment get la value ???
        self.performSegueWithIdentifier("segueMain", sender: dataobject)
    }

}

