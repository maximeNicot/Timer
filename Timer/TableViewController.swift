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
    
    
    var totalChrono = 0
    var identifier = 1
    var monTitre = ""
    var editingBool = false
    
    
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
        print("identifier" + String(identifier))
        
        tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
      
        if(dataDefaults.stringArrayForKey("keyData4" + String(identifier)) != nil){
        data = dataDefaults.stringArrayForKey("keyData4" + String(identifier))!
        dataTimer = dataTimerDefaults.stringArrayForKey("keyDataTimer4" + String(identifier))!
        
        }
        dataDefaults.setValue(data, forKey: "keyData4" + String(identifier))
        dataTimerDefaults.setValue(dataTimer, forKey: "keyDataTimer4" + String(identifier))
        
        print(totalChrono)
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

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        
        
        
        
        cell.label.text = data[indexPath.row]
        
        
        
        cell.identifier = indexPath.row + 1000 + identifier
        cell.starter()
        //en dessous le probleme
        //cell.labelTimer.text = dataTimer[indexPath.row]
        dataTimer[indexPath.row] = cell.labelTimer.text!
        
        
        cell.delegate = self
        
        
        totalChrono = totalChrono + cell.chrono
        
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
   

    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        //let sourceCell = tableView.cellForRowAtIndexPath(sourceIndexPath) as! CustomTableViewCell
        //let destinationCell = tableView.cellForRowAtIndexPath(destinationIndexPath) as! CustomTableViewCell
        
        
        data.insert(data.removeAtIndex(sourceIndexPath.row), atIndex: destinationIndexPath.row)
        dataTimer.insert(dataTimer.removeAtIndex(sourceIndexPath.row), atIndex: destinationIndexPath.row)
        
        
        dataDefaults.setValue(data, forKey: "keyData4" + String(identifier))
        dataTimerDefaults.setValue(dataTimer, forKey: "keyDataTimer4" + String(identifier))
        
        tableView.reloadData()
        }
    
    
    //protocol
    func SegueFromCell(mydata dataobject: AnyObject){
        self.performSegueWithIdentifier("segueBrochure", sender: dataobject)
    }
}


