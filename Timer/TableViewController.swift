//
//  TableViewController.swift
//  Timer
//
//  Created by Antoine NICOT on 14/03/2020.
//  Copyright © 2020 maxime. All rights reserved.


import UIKit
import MessageUI

class TableViewController: UITableViewController,MFMailComposeViewControllerDelegate, CellDelegate {
    var data = [String]()
    var dataTimer = [String]()
    var dataDefaults = NSUserDefaults.standardUserDefaults()
    var dataTimerDefaults = NSUserDefaults.standardUserDefaults()
    
    var nomTache = ""
    
    var totalChrono = 0
    var identifier = 1
    var monTitre = ""
    var editingBool = false
    var deplacementBool = false
    
    var fromQuickStart = false
    
    var identifierCellEditing = -1
    
    @IBAction func onMessage(sender: AnyObject) {
        mail()
    }
    
    func mail(){
    
        let mailEnregistre = dataDefaults.stringForKey("mail_preference")
        if(mailEnregistre != nil){
            print("le mail enregistré est : " + mailEnregistre!)
        }
        else{
            print("Pas de mail enregistré")
        }
        
        if (!MFMailComposeViewController.canSendMail()){
            print("Pas autorisation d'envois de mail")
            
        }
        else{
            print("Send mail OK")
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            composer.setToRecipients([mailEnregistre!])
            composer.setSubject("Objet du mail")
            composer.setMessageBody("Le corps du mails", isHTML: false)
        
            presentViewController(composer, animated: true, completion: nil)
        }
    }
    
    
    
    @IBOutlet var viewTable: UITableView!
    
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
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.setEditing(false, animated: false)

        
        navigationBar.topItem?.title = monTitre
        //print("identifier" + String(identifier))
        
        tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
      
        if(dataDefaults.stringArrayForKey("keyData4" + String(identifier)) != nil){
        data = dataDefaults.stringArrayForKey("keyData4" + String(identifier))!
        dataTimer = dataTimerDefaults.stringArrayForKey("keyDataTimer4" + String(identifier))!
        
        }
        dataDefaults.setValue(data, forKey: "keyData4" + String(identifier))
        dataTimerDefaults.setValue(dataTimer, forKey: "keyDataTimer4" + String(identifier))
        
        print("data du TableViewController")
        print(data)
        print("dataTimer du tableViewController")
        print(dataTimer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let nbRow = dataTimerDefaults.stringArrayForKey("keyDataTimer4" + String(identifier))!.count
        
        return (nbRow)
    }

        // creation cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        cell.label.text = data[indexPath.row]
        
        cell.identifier = indexPath.row + 1000 + identifier
        print("-----identifier cell table view-----")
        print(cell.identifier)
        cell.starter()
        
        
        
        if(deplacementBool){
            
            cell.chrono = Int(dataTimer[indexPath.row])!
            cell.setChrono()
            cell.labelTimer.text = dataTimer[indexPath.row]
        }
        else{
            //Pour bien envoyer le timer de la quick task dans la nouvelle du dossier
            if(fromQuickStart){
                cell.chrono = Int(dataTimer[indexPath.row])!
                cell.setChrono()
                cell.afficherChronoFormat()
            }
            else{
                dataTimer[indexPath.row] = String(cell.chrono)
            }
            
            
            
        }
        if(indexPath.row == 2){
            deplacementBool = false
        }
        
        
        cell.delegate = self
        
        
        if(editingBool){
            cell.editSensInterdit()
        }
        else{
            cell.editTriangle()
        }
        
        return cell
    }
    
    //click sur une cell
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
        nomTache = currentCell.label.text!
        if(!editingBool){
            currentCell.activerTimer()
        }
        else{
            dataDefaults.setValue(currentCell.label.text, forKey: "labelTextCell")
            identifierCellEditing = indexPath.item
            self.performSegueWithIdentifier("segueEditController", sender: self)
            
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        dataTimerDefaults.setValue(dataTimer, forKey: "keyDataTimer4" + String(identifier))
        print("identifier TableView avant total chrono")
        print(identifier)
        parcourirTableView()
        dataDefaults.setValue(totalChrono, forKey: "totalChrono" + String(identifier))
        
        
        
        if(segue.identifier == "segueNewTask"){
            let vc = segue.destinationViewController as! NewTaskController
            vc.identifier = self.identifier
            vc.projectTitre = self.monTitre
        }
        else if(segue.identifier == "segueEditController"){
            let vc = segue.destinationViewController as! EditController
            vc.dataTableView = self.data
            vc.identifierCell = self.identifierCellEditing
            vc.identifierTableView = self.identifier
            vc.fromQuickTask = false
            vc.fromTableView = true
            
            dataDefaults.setValue(nomTache, forKey: "nomTask")
            
        }
        
    }
   

    func parcourirTableView(){
        for cell in tableView.visibleCells as! [CustomTableViewCell] {
            totalChrono = totalChrono + cell.chrono
        }
    }
    
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    
    // Changement de cell edidting
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        data.insert(data.removeAtIndex(sourceIndexPath.row), atIndex: destinationIndexPath.row)
        dataTimer.insert(dataTimer.removeAtIndex(sourceIndexPath.row), atIndex: destinationIndexPath.row)
        
    
        dataDefaults.setValue(data, forKey: "keyData4" + String(identifier))
        dataTimerDefaults.setValue(dataTimer, forKey: "keyDataTimer4" + String(identifier))
        
        deplacementBool = true
        
        }
    
    
    //protocol
    func SegueFromCell(mydata dataobject: AnyObject){
        self.performSegueWithIdentifier("segueBrochure", sender: dataobject)
    }
}


