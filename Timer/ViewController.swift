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
    // pour les segue de PopUpController
    var nomTask = ""
    
    override func viewDidLoad() {
        
        let mailEnregistre = dataPageBlancheDefaults.stringForKey("mail_preference")
        if(mailEnregistre != nil){
            print("le mail enregistré est : " + mailEnregistre!)
        }
        else{
            print("Pas de mail enregistré")
        }
        
        super.viewDidLoad()
        print("le viewController principal démarre")
        if(dataQuickTaskDefaults.stringArrayForKey("keyQuickTask3") != nil){
            dataQuickTask = dataQuickTaskDefaults.stringArrayForKey("keyQuickTask3")!
            dataQuickTaskTimer = dataQuickTaskTimerDefaults.stringArrayForKey("keyQuickTaskTimer3")!
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
        
        tableView.reloadData()
    }
    
    
    @IBAction func quickStart(sender: AnyObject) {
        if(dataQuickTask.count == 0 ){
            dataQuickTask.append("Quick Task " + String(1))
        }
        else {
            dataQuickTask.append("Quick Task " + String(dataQuickTask.count + 1))
        }
        
        dataQuickTaskTimer.append("0")
        dataQuickTaskDefaults.setValue(dataQuickTask, forKey: "keyQuickTask3")
        dataQuickTaskTimerDefaults.setValue(dataQuickTaskTimer, forKey: "keyQuickTaskTimer3")
       
        dataTimer.append("0")
        
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //blank space
        if(dataQuickTask.count == 0 && section == 0){
            let label = UILabel()
            return label
        }
        else{
            let label = UILabel()
            label.backgroundColor = UIColor.lightGrayColor()
            return label
        }
        
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
   
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return (dataQuickTask.count)
        }
        if(section == 1){
            return (dataPageBlanche.count)
        }
        if(section == 2){
            return (dataDossier.count)
        }
        return (0)
    }
    
    //Creation cell
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        if(indexPath.section == 0){
        //dataQuickTaskTimer[indexPath.row] = cell.labelTimer.text!
            
            cell.label.text = dataQuickTask[indexPath.row]
            
            dataQuickTaskTimer[indexPath.row] = String(cell.chrono)
            
            
            cell.identifier = indexPath.row + 10000
            cell.starter()
        
            cell.quickStart()
            cell.delegate = self
        }
        
        else if(indexPath.section == 1){
            
            cell.label.text = dataPageBlanche[indexPath.row]
            cell.identifier = indexPath.row + 8000
            cell.starter()
            cell.pageBlanche()
            
            cell.delegate = self
        }
        
        else if(indexPath.section == 2){
            
            cell.label.text = dataDossier[indexPath.row]
            
            cell.identifier = indexPath.row + 7000
            cell.starter()
            cell.dossier()
            cell.actualiserChronoDossier()
            cell.starter()
            
            cell.delegate = self
        }
       
        
        return cell
        
    }
    
    // click sur la cell entiere
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
        if(currentCell.isQuickStart){
            currentCell.activerTimer()
        }
        else if(currentCell.isDossier){
            self.monTitre = currentCell.label.text!
            self.identifierTableViewController = indexPath.row * 100 + indexPath.section //2
            print(identifierTableViewController)
            self.performSegueWithIdentifier("segueTableView", sender: self)
        }
        else if(currentCell.isPageBlanche){
            self.monTitre = currentCell.label.text!
            self.identifierTableViewController = indexPath.row * 200 + indexPath.section //1
            print(identifierTableViewController)
            if(self.monTitre == "All tasks"){
                self.performSegueWithIdentifier("segueAllTasks", sender: self)
            }
            else{
                self.performSegueWithIdentifier("segueTableView", sender: self)
            }
            
        }
    }
    
    // lancé avant chaque segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.identifier)
        
        if(segue.identifier == "segueTableView"){
            let vc = segue.destinationViewController as! TableViewController
            vc.identifier = self.identifierTableViewController
            // bug en dessous
            //vc.monTitre =  self.monTitre
            
        }
        if(segue.identifier == "seguePopUp"){
            let vc = segue.destinationViewController as! PopUpController
            vc.identifierCell = sender as! Int
            dataQuickTaskDefaults.setValue(dataQuickTask, forKey: "keyQuickTask3")
            dataQuickTaskTimerDefaults.setValue(dataQuickTaskTimer, forKey: "keyQuickTaskTimer3")
            
        }
        else{
            
        }
        
    }
    
    //protocol
    func SegueFromCell(mydata identifierCell: AnyObject){
        self.performSegueWithIdentifier("seguePopUp", sender: identifierCell)
    }

}

