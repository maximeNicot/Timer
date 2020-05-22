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
    
    // single task + tout dossier
    var dataAllDossier = [[String]]()
    var dataAllDossierTimer = [[String]]()
    
    var dataDossier = [String]() // Les noms des dossiers
    
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
        
        
        //construction du data all dossier
        constructionAllDossier()
        
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
            print("----")
            print(dataAllDossier)
            print("----")
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
        return (dataAllDossier[section].count)
        
    }
    
    //Creation cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        cell.identifier = indexPath.row + 10000
        cell.starter()
        cell.label.text = dataAllDossier[indexPath.section][indexPath.row]
        
        //dedois pas add timer donc sa bug ici
        //cell.chrono = Int(dataAllDossierTimer[indexPath.section][indexPath.row])!
        
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
        
        
        //myDefaults.setValue(data, forKey: "keyData4" + String(identifier))
        //myDefaults.setValue(dataTimer, forKey: "keyDataTimer4" + String(identifier))
        
        print("Source : "  + String(sourceIndexPath.row) + " Destination : " + String(destinationIndexPath.row) )
        print("Source section : " + String(sourceIndexPath.section) + " Destination section : " + String(destinationIndexPath.section))
        
        
        var dataDossierSource = [String]()
        var dataDossierDestination = [String]()
        var dataDossierSourceTimer = [String]()
        var dataDossierDestinationTimer = [String]()
        var identifierSource = -1
        var identifierDestination = -1
        
        if(sourceIndexPath.section == 0){
            identifierSource = 1
            dataDossierSource = myDefaults.stringArrayForKey("keyData4" + String(identifierSource))!
            dataDossierSourceTimer = myDefaults.stringArrayForKey("keyDataTimer4" + String(identifierSource))!
        }
        else {
            identifierSource = (2 + (sourceIndexPath.section * 100)-100)
            dataDossierSource = myDefaults.stringArrayForKey("keyData4" + String(identifierSource))!
            dataDossierSourceTimer = myDefaults.stringArrayForKey("keyDataTimer4" + String(identifierSource))!
        }
        
        if(destinationIndexPath.section == 0){
            identifierDestination = 1
            dataDossierDestination = myDefaults.stringArrayForKey("keyData4" + String(identifierDestination))!
            dataDossierDestinationTimer = myDefaults.stringArrayForKey("keyDataTimer4" + String(identifierDestination))!
        }
        else {
            identifierDestination = (2 + (destinationIndexPath.section * 100)-100)
            dataDossierDestination = myDefaults.stringArrayForKey("keyData4" + String(identifierDestination))!
            dataDossierDestinationTimer = myDefaults.stringArrayForKey("keyDataTimer4" + String(identifierDestination))!
        }
        
        print("----------Dossier SOurce avant save---------")
        print(dataDossierSource)
        print("--------Dossier Destination avant save-----------")
        print(dataDossierDestination)
        
        
        dataDossierDestination.insert(dataDossierSource.removeAtIndex(sourceIndexPath.row), atIndex: destinationIndexPath.row)
        dataDossierDestinationTimer.insert(dataDossierSourceTimer.removeAtIndex(sourceIndexPath.row), atIndex: destinationIndexPath.row)
        
        myDefaults.setValue(dataDossierSource, forKey: "keyData4" + String(identifierSource))
        myDefaults.setValue(dataDossierSourceTimer, forKey: "keyDataTimer4" + String(identifierSource))
        myDefaults.setValue(dataDossierDestination, forKey: "keyData4" + String(identifierDestination))
        myDefaults.setValue(dataDossierDestinationTimer, forKey: "keyDataTimer4" + String(identifierDestination))
        
        
        print("---------Dossier SOurce apres save----------")
        print(dataDossierSource)
        print("---------Dossier Destination apres save----------")
        print(dataDossierDestination)
        
        deplacementBool = true
        constructionAllDossier()
        
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    
    func constructionAllDossier(){
        dataAllDossier.removeAll()
        dataAllDossierTimer.removeAll()
        for i in 0...dataDossier.count{
            
            identifierPourBoucle = (2 + (i * 100)-100) // -100 pour le single task
            if(i == 0){
                data = myDefaults.stringArrayForKey("keyData4" + String(identifierSingleTask))!
                dataTimer = myDefaults.stringArrayForKey("keyDataTimer4" + String(identifierSingleTask))!
            }
            else if(myDefaults.stringArrayForKey("keyData4" + String(identifierPourBoucle)) != nil){
                data = myDefaults.stringArrayForKey("keyData4" + String(identifierPourBoucle))!
                dataTimer = myDefaults.stringArrayForKey("keyDataTimer4" + String(identifierPourBoucle))!
            }
            dataAllDossier.append(data)
            dataAllDossierTimer.append(dataTimer)
            myDefaults.setValue(dataAllDossier, forKey: "dataAllDossier")
            myDefaults.setValue(dataAllDossierTimer, forKey: "dataAllDossierTimer")
            print("DATA ALL DOSSIER")
            print(dataAllDossier)
            print(dataAllDossier.count)
            print("DATA ALL TIMER")
            print(dataAllDossierTimer)
            print(dataAllDossierTimer.count)
        }
    }
        
}
