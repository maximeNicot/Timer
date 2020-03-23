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
        dataDefaults.setValue(data, forKey: "keyData3" + String(identifier))
        dataTimerDefaults.setValue(dataTimer, forKey: "keyDataTimer3" + String(identifier))
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
        data = dataDefaults.stringArrayForKey("keyData3" + String(identifier))!
        dataTimer = dataTimerDefaults.stringArrayForKey("keyDataTimer3" + String(identifier))!
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
