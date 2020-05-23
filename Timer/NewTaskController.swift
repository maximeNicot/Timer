//
//  NewTaskController.swift
//  Timer
//
//  Created by Antoine NICOT on 15/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class NewTaskController: UIViewController {

    var identifier = 1
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var save: UIBarButtonItem!
    
    @IBOutlet weak var textFieldProject: UITextField!
    
    @IBAction func saveButton(sender: AnyObject) {
        data.append(textField.text!)
        dataTimer.append("0")
        dataDefaults.setValue(data, forKey: "keyData4" + String(identifier))
        dataTimerDefaults.setValue(dataTimer, forKey: "keyDataTimer4" + String(identifier))
        print("Nouvelle cell")
        
    }
    
    var data = [""]
    var dataTimer = [""]
    var dataDefaults = NSUserDefaults.standardUserDefaults()
    var dataTimerDefaults = NSUserDefaults.standardUserDefaults()
    var projectTitre = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldProject.text = projectTitre
        data = dataDefaults.stringArrayForKey("keyData4" + String(identifier))!
        dataTimer = dataTimerDefaults.stringArrayForKey("keyDataTimer4" + String(identifier))!
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "segueSave"){
            let vc = segue.destinationViewController as! TableViewController
            vc.identifier = self.identifier
            vc.monTitre = self.projectTitre
        }
        else{
        }
    }
}
