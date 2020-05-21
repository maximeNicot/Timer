//
//  EditController.swift
//  Timer
//
//  Created by Antoine NICOT on 26/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class EditController: UIViewController {
    
    var myDefaults = NSUserDefaults.standardUserDefaults()
    var dataQuickTask = [String]()
    var dataQuickTaskTimer = [String]()
    var identifierCell = -1
    var nomProjet = ""
    var nomTache = ""
    
    var dataDossier = [String]() //nom des dossiers
    var identifierInstanceDossier = -1
    var data = [String]()
    var dataTimer = [String]()
    
    var dataTableView = [String]()
    var fromQuickTask = true
    var fromTableView = false
    
    var identifierTableView = -1
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldProjet: UITextField!
    
    @IBAction func onProjetClick(sender: AnyObject) {
        //pour lier le nom au changement de page
        
        myDefaults.setValue((textField.text), forKey: "nomTask")
        
        performSegueWithIdentifier("segueChoix", sender: nil)
    }
    
    
    
    @IBAction func saveOnClick(sender: AnyObject) {
        
        //ouvert depuis le ViewController
        
        if(fromQuickTask){
            myDefaults.setValue(("Quick Task"), forKey: "nomTask")
            
            if(myDefaults.stringArrayForKey("keyQuickTask3") != nil){
                dataQuickTask = myDefaults.stringArrayForKey("keyQuickTask3")!
                dataQuickTaskTimer = myDefaults.stringArrayForKey("keyQuickTaskTimer3")!
            }
            dataQuickTask.removeAtIndex(identifierCell-10000)
            dataQuickTaskTimer.removeAtIndex(identifierCell-10000)
            
            myDefaults.setValue(dataQuickTask, forKey: "keyQuickTask3")
            myDefaults.setValue(dataQuickTaskTimer, forKey: "keyQuickTaskTimer3")
            
            let index = dataDossier.indexOf(nomProjet)
            identifierInstanceDossier = 2 + (index! * 100)
            
            if(myDefaults.stringArrayForKey("keyData4" + String(identifierInstanceDossier)) != nil){
                data = myDefaults.stringArrayForKey("keyData4" + String(identifierInstanceDossier))!
                dataTimer = myDefaults.stringArrayForKey("keyDataTimer4" + String(identifierInstanceDossier))!
                
                data.append(textField.text!)
                print(textField.text!)
                
               
                dataTimer.append("100")
               
                myDefaults.setValue(data, forKey: ("keyData4" + String(identifierInstanceDossier)))
                myDefaults.setValue(dataTimer, forKey: ("keyDataTimer4" + String(identifierInstanceDossier)))
            }
            
            //myDefaults.setValue(0, forKey: "keyChrono" + String(identifierCell))

            self.performSegueWithIdentifier("segueSaveToQuickStart", sender: self)
        }
            
        // ouvert depuis TableViewController
        else if(fromTableView || (myDefaults.boolForKey("depuisTableViewController") == true)){
            myDefaults.setValue(false, forKey: "depuisTableViewController")
            
            
            // ici pour renvoyer sur la bonne tableView
            let index = dataDossier.indexOf(nomProjet)
            identifierInstanceDossier = 2 + (index! * 100)
            
            if(myDefaults.stringArrayForKey("keyData4" + String(identifierInstanceDossier)) != nil){
                data = myDefaults.stringArrayForKey("keyData4" + String(identifierInstanceDossier))!
                dataTimer = myDefaults.stringArrayForKey("keyDataTimer4" + String(identifierInstanceDossier))!
                
                //on veut pas append
                data[identifierCell] = textField.text!
                dataTimer[identifierCell] = "100"
               
                
                
                myDefaults.setValue(data, forKey: ("keyData4" + String(identifierInstanceDossier)))
                myDefaults.setValue(dataTimer, forKey: ("keyDataTimer4" + String(identifierInstanceDossier)))
            }

            
            
            identifierTableView = identifierInstanceDossier
            self.performSegueWithIdentifier("segueSaveToTableView", sender: self)
            
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        if(myDefaults.stringArrayForKey("keyDossier1") != nil){
            dataDossier = myDefaults.stringArrayForKey("keyDossier1")!
        }
      
        
        if(fromTableView || (myDefaults.boolForKey("depuisTableViewController") == true)){
            myDefaults.setValue(fromTableView, forKey: "depuisTableViewController")
            fromQuickTask = false
        }
        
        textField.text = myDefaults.stringForKey("labelTextCell")!
        if(myDefaults.stringForKey("nomTask") != nil){
            textField.text = myDefaults.stringForKey("nomTask")!
        }
        textFieldProjet.text = nomProjet
        
        if(!fromQuickTask){
            fromTableView = true
        }
        
    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if(segue.identifier == "segueSaveToTableView"){
            let vc = segue.destinationViewController as! TableViewController
            vc.identifier = identifierTableView
        }
        if(segue.identifier == "segueChoix"){
            let vc = segue.destinationViewController as! ChoixProjetViewController
            vc.identifierCell = self.identifierCell
        }
    }
}
