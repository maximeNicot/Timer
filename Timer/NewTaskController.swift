//
//  NewTaskController.swift
//  Timer
//
//  Created by Antoine NICOT on 15/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class NewTaskController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var save: UIBarButtonItem!
    
    @IBAction func saveButton(sender: AnyObject) {
        data.append(textField.text!)
        dataTimer.append("0")
        dataDefaults.setValue(data, forKey: "keyData3")
        dataTimerDefaults.setValue(dataTimer, forKey: "keyDataTimer3")
        print("Nouvelle cell")
        
    }
    
    var data = [""]
    var dataTimer = [""]
    var dataDefaults = NSUserDefaults.standardUserDefaults()
    var dataTimerDefaults = NSUserDefaults.standardUserDefaults()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = dataDefaults.stringArrayForKey("keyData3")!
        dataTimer = dataTimerDefaults.stringArrayForKey("keyDataTimer3")!
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
