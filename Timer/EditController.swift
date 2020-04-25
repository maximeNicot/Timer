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
    
    
    var dataTableView = [String]()
    var fromQuickTask = true
    var identifierTableView = -1
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldProjet: UITextField!
    
    @IBAction func onProjetClick(sender: AnyObject) {
        performSegueWithIdentifier("segueChoix", sender: nil)
    }
    
    
    
    @IBAction func saveOnClick(sender: AnyObject) {
        
        // pour l'instant que supprimmer, faut aussi ajouter au bon projet
        
        //ouvert depuis le ViewController
        if(fromQuickTask){
            if(myDefaults.stringArrayForKey("keyQuickTask3") != nil){
                dataQuickTask = myDefaults.stringArrayForKey("keyQuickTask3")!
                dataQuickTaskTimer = myDefaults.stringArrayForKey("keyQuickTaskTimer3")!
            }
            dataQuickTask.removeAtIndex(identifierCell-10000)
            dataQuickTaskTimer.removeAtIndex(identifierCell-10000)
            
            myDefaults.setValue(dataQuickTask, forKey: "keyQuickTask3")
            myDefaults.setValue(dataQuickTaskTimer, forKey: "keyQuickTaskTimer3")
            self.performSegueWithIdentifier("segueSaveToQuickStart", sender: self)
        }
            
        // ouvert depuis TableViewController
        else{
            dataTableView[identifierCell] = textField.text!
            
            myDefaults.setValue(dataTableView, forKey: "keyData4" + String(identifierTableView))
            self.performSegueWithIdentifier("segueSaveToTableView", sender: self)
            
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        textField.text = myDefaults.stringForKey("labelTextCell")!
        textFieldProjet.text = nomProjet
        
    }
    
    
    




    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if(segue.identifier == "segueSaveToTableView"){
            let vc = segue.destinationViewController as! TableViewController
            vc.identifier = identifierTableView
        }

    }
}
