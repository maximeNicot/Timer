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
    var dataTask = ["Single Task", "All Tasks"]
    var dataDossier = ["Axari Graphics", "Website Ions"]
    
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

    
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //blank space
        let label = UILabel()
        label.backgroundColor = UIColor.lightGrayColor()
        return label
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
   
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return (data.count)
        }
        if(section == 1){
            return (dataTask.count)
        }
        if(section == 2){
            return (dataDossier.count)
        }
        return (data.count)
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        if(indexPath.section == 0){
        dataTimer[indexPath.row] = cell.labelTimer.text!
        cell.label.text = data[indexPath.row]
        
        cell.identifier = indexPath.row + 9999
        cell.starter()
        //cell.activerTimer()
        cell.delegate = self
        }
        
        if(indexPath.section == 1){
            
            cell.label.text = dataTask[indexPath.row]
            cell.identifier = indexPath.row + 8000
            cell.starter()
            cell.pageBlanche()
            
            cell.delegate = self
        }
        
        if(indexPath.section == 2){
            
            cell.label.text = dataDossier[indexPath.row]
            cell.identifier = indexPath.row + 8000
            cell.starter()
            cell.dossier()
            
            cell.delegate = self
        }
       
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

