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
    // "Quick Task X"
    var nomProjet = ""
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldProjet: UITextField!
    
    @IBAction func onProjetClick(sender: AnyObject) {
        performSegueWithIdentifier("segueChoix", sender: nil)
    }
    
    
    
    @IBAction func saveOnClick(sender: AnyObject) {
        
        
        if(myDefaults.stringArrayForKey("keyQuickTask3") != nil){
            dataQuickTask = myDefaults.stringArrayForKey("keyQuickTask3")!
            dataQuickTaskTimer = myDefaults.stringArrayForKey("keyQuickTaskTimer3")!
        }
        
        //error car on perd l'identifier quand on va dans le COntroller CHoix
        dataQuickTask.removeAtIndex(identifierCell-10000)
        dataQuickTaskTimer.removeAtIndex(identifierCell-10000)
        
        myDefaults.setValue(dataQuickTask, forKey: "keyQuickTask3")
        myDefaults.setValue(dataQuickTaskTimer, forKey: "keyQuickTaskTimer3")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        textField.text = myDefaults.stringForKey("labelTextCell")!
        textFieldProjet.text = nomProjet
        
    }
}
