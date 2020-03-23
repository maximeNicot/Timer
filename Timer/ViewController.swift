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
    
    //Pour page blanche et dossier
    var dataPageBlanche = ["Single Tasks" , "All tasks"]
    var dataDossier = [String]()
    var dataPageBlancheDefaults = NSUserDefaults.standardUserDefaults()
    var dataDossierDefaults = NSUserDefaults.standardUserDefaults()
    
    var dataTimer = [String]()
    
    var dataQuickTask = [String]()
    var dataQuickTaskTimer = [String]()
    var dataQuickTaskDefaults = NSUserDefaults.standardUserDefaults()
    var dataQuickTaskTimerDefaults = NSUserDefaults.standardUserDefaults()
    
    
    //pour les segue de tableViewController
    var monTitre = ""
    var identifierTableViewController = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("le viewcontroller principal démarre")
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
        if(dataPageBlancheDefaults.stringArrayForKey("keyPageBlanche") != nil){
            dataPageBlanche = dataPageBlancheDefaults.stringArrayForKey("keyPageBlanche")!
        }
        
        if(dataDossierDefaults.stringArrayForKey("keyDossier1") != nil){
            dataDossier = dataDossierDefaults.stringArrayForKey("keyDossier1")!
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
            return (dataPageBlanche.count)
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
            
            cell.label.text = dataPageBlanche[indexPath.row]
            cell.identifier = indexPath.row + 8000
            cell.starter()
            cell.pageBlanche()
            
            cell.delegate = self
        }
        
        if(indexPath.section == 2){
            
            cell.label.text = dataDossier[indexPath.row]
            cell.identifier = indexPath.row + 7000
            cell.starter()
            cell.dossier()
            
            cell.delegate = self
        }
       
        return cell
        
    }
    
    // click sur la cell
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
        
        if(currentCell.isDossier){
            self.monTitre = currentCell.label.text!
            self.identifierTableViewController = indexPath.row * 100 + indexPath.section
            self.performSegueWithIdentifier("segueTableView", sender: self)
        }
        if(currentCell.isPageBlanche){
            self.performSegueWithIdentifier("segueTableView", sender: self)
        }
        else{
            currentCell.activerTimer()
        }
        
        
        
    }
    // lancé avant chaque segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.identifier)
        
        if(segue.identifier == "segueTableView"){
            let vc = segue.destinationViewController as! TableViewController
            vc.identifier = self.identifierTableViewController
            vc.monTitre =  self.monTitre
        }
        if(segue.identifier == "seguePopUp"){
            let vc = segue.destinationViewController as! PopUpController
            vc.cellAppelante = "aa"
        }
        else{
            
        }
        
    }
    
    //protocol
    func SegueFromCell(mydata dataobject: AnyObject){
        //comment get la value ???
        self.performSegueWithIdentifier("seguePopUp", sender: dataobject)
    }

}

