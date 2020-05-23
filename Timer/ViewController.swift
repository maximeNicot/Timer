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
    
    var effacerDossierEdit = false
    
    var identifierCellEffacerChrono = -1
    //pour les segue de tableViewController
    var monTitre = ""
    var identifierTableViewController = 1
    // pour les segue de PopUpController
    var nomTask = ""
    
    @IBAction func onClickEdit(sender: AnyObject) {
        effacerDossierEdit = !effacerDossierEdit
        parcourirEffacerButton()
        tableView.reloadData()
    }
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
            
            
            
            cell.identifier = indexPath.row + 10000
            cell.starter()
        
            cell.quickStart()
            
            print("dataQuickTaskChrono ViewController")
            print(dataQuickTaskTimer)
            cell.chrono = Int(dataQuickTaskTimer[indexPath.row])!
            cell.labelTimer.text = dataQuickTaskTimer[indexPath.row]
            cell.majChrono()
            cell.delegate = self
        }
        
        else if(indexPath.section == 1){
            
            cell.label.text = dataPageBlanche[indexPath.row]
            cell.identifier = indexPath.row + 8000
            cell.actualiserChronoPageBlanche()
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
        
        //Pour effacer les dossiers
        if(effacerDossierEdit && currentCell.isDossier){
            
            print(dataDossier)
            dataDossier.removeAtIndex(indexPath.row)
            print(dataDossier)
            effacerDossierEdit = !effacerDossierEdit
            parcourirEffacerButton()
            dataDossierDefaults.setValue(dataDossier, forKey: "keyDossier1")
            
            //Pour effacer a l'interieur des dossiers, les taches en meme temps
            self.identifierTableViewController = indexPath.row * 100 + indexPath.section //2
            let dataTacheDossierEffacer = dataDossierDefaults.stringArrayForKey("keyData4" + String(identifierTableViewController))
            //faut aussi effacer les chrono default de chaque cell
            for i in 0...dataTacheDossierEffacer!.count{
                identifierCellEffacerChrono = i + 1000 + identifierTableViewController
                dataDossierDefaults.setValue(0, forKey: "keyChrono" + String(identifierCellEffacerChrono))
                
            }
            //pour que le total chrono soit aussi effacer
            dataDossierDefaults.setValue(0, forKey: "totalChrono" + String(identifierTableViewController))
            
            dataDossierDefaults.setValue([], forKey: "keyData4" + String(identifierTableViewController))
            dataDossierDefaults.setValue([], forKey: "keyDataTimer4" + String(identifierTableViewController))
            
            tableView.reloadData()
        }
            
        else{
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
    }
    
    func parcourirTableView(){
        var indice = 0
        for cell in tableView.visibleCells as! [CustomTableViewCell] {
            //pour juste avoir les quick start
            if(indice < dataQuickTaskTimer.count){
                //cell.chrono = Int(dataQuickTaskTimer[indice])!
                dataQuickTaskTimer[indice] = String(cell.chrono)
                indice = indice + 1
            }
            
        }
    }
    
    func parcourirEffacerButton(){
        for cell in tableView.visibleCells as! [CustomTableViewCell] {
            if(cell.isDossier){
                cell.activerEffacerButton()
            }
        }
    }
    
    // lancé avant chaque segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(dataQuickTaskDefaults.stringArrayForKey("keyQuickTaskTimer3") != nil){
            dataQuickTaskTimer = dataQuickTaskTimerDefaults.stringArrayForKey("keyQuickTaskTimer3")!
        }
        parcourirTableView()
        dataQuickTaskTimerDefaults.setValue(dataQuickTaskTimer, forKey: "keyQuickTaskTimer3")
        print(dataQuickTaskTimer)
        
        if(segue.identifier == "segueTableView"){
            let vc = segue.destinationViewController as! TableViewController
            vc.identifier = self.identifierTableViewController
            // bug en dessous ?
            vc.monTitre =  self.monTitre
            
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

