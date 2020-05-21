//
//  AllTasksViewController.swift
//  Timer
//
//  Created by Antoine NICOT on 26/04/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class AllTasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var myDefaults = NSUserDefaults.standardUserDefaults()
    
    var data = [String]()
    var dataTimer = [String]()
    
    var dataDossier = [String]()
    var deplacementBool = false
    var editingBool = false
    var ancienSection = 0
    var ancienSectionCount = 0
    
    var identifierPourBoucle = -1
    
    
    var identifierSingleTask = 1

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.setEditing(false, animated: false)
        
        
        if(myDefaults.stringArrayForKey("keyDossier1") != nil){
            dataDossier = myDefaults.stringArrayForKey("keyDossier1")!
        }
        
       
        if(myDefaults.stringArrayForKey("keyData4" + String(identifierSingleTask)) != nil){
            
            data = myDefaults.stringArrayForKey("keyData4" + String(identifierSingleTask))!
            
            dataTimer = myDefaults.stringArrayForKey("keyDataTimer4" + String(identifierSingleTask))!
            
        }
        //print(data)
        myDefaults.setValue(data, forKey: "keyData4" + String(identifierSingleTask))
        myDefaults.setValue(dataTimer, forKey: "keyDataTimer4" + String(identifierSingleTask))
        
        
        tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
    }

    @IBAction func editClick(sender: AnyObject) {
        if(!editingBool){
            tableView.setEditing(true, animated: true)
            tableView.allowsSelectionDuringEditing = true
            editingBool = true
            tableView.reloadData()
        }
        else{
            tableView.setEditing(false, animated: false)
            editingBool = false
            tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Header sections
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if(section == 0){
            label.text = "Single Tasks"
        }
        else{
            label.text = dataDossier[section-1]
        }
        
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.lightGrayColor()
        return label
    }
   
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // + 1 pour singles tasks
        return dataDossier.count + 1
    }
    
    //count
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            ancienSectionCount = section
            data = myDefaults.stringArrayForKey("keyData4" + String(identifierSingleTask))!
            
            return data.count
        }
        else {
            if(ancienSectionCount != section){
                //changement de section
                identifierPourBoucle = (2 + (section * 100)-100) // -100 pour le single task
                if(myDefaults.stringArrayForKey("keyData4" + String(identifierPourBoucle)) != nil){
                    data = myDefaults.stringArrayForKey("keyData4" + String(identifierPourBoucle))!
                    dataTimer = myDefaults.stringArrayForKey("keyDataTimer4" + String(identifierPourBoucle))!
                }
            }
            ancienSectionCount = section
            return data.count
        }
        
    }
    
    //Creation cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        cell.identifier = indexPath.row + 10000
        cell.starter()
        
        //changement de section, pas de data général, on disperse
        if(ancienSection != indexPath.section){
            identifierPourBoucle = (2 + (indexPath.section * 100)-100) // -100 pour le single task
            if(myDefaults.stringArrayForKey("keyData4" + String(identifierPourBoucle)) != nil){
                data = myDefaults.stringArrayForKey("keyData4" + String(identifierPourBoucle))!
                dataTimer = myDefaults.stringArrayForKey("keyDataTimer4" + String(identifierPourBoucle))!
            }
        }
        
        
        if(indexPath.section == 0){
            
            //pour single task du debut
            if(myDefaults.stringArrayForKey("keyData4" + String(identifierSingleTask)) != nil){
                
                data = myDefaults.stringArrayForKey("keyData4" + String(identifierSingleTask))!
                dataTimer = myDefaults.stringArrayForKey("keyDataTimer4" + String(identifierSingleTask))!
                
            }
            print(data)
            
            print(dataTimer)
            cell.label.text = data[indexPath.row]
        }
        else {
            cell.label.text = data[indexPath.row]
        }
        
        
        
        cell.chrono = Int(dataTimer[indexPath.row])!
        cell.setChrono()
        
        if(editingBool){
            cell.editSensInterdit()
        }
        else{
            cell.editTriangle()
        }
        ancienSection = indexPath.section
        return cell
    }
    
    
    // click sur cell entiere
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
        
        if(!editingBool){
            currentCell.activerTimer()
        }
        else{
            
        }
        
    }
    
    // changement de cell edit
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        //data.insert(data.removeAtIndex(sourceIndexPath.row), atIndex: destinationIndexPath.row)
        //dataTimer.insert(dataTimer.removeAtIndex(sourceIndexPath.row), atIndex: destinationIndexPath.row)
        //let objMoving = data[sourceIndexPath.item]
        //data.removeAtIndex(sourceIndexPath.item)
        
        
        //myDefaults.setValue(data, forKey: "keyData4" + String(identifier))
        //myDefaults.setValue(dataTimer, forKey: "keyDataTimer4" + String(identifier))
        
        deplacementBool = true
        
    }
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
        
}
