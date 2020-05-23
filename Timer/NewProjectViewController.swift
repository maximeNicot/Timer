//
//  NewProjectViewController.swift
//  Timer
//
//  Created by Antoine NICOT on 01/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class NewProjectViewController: UIViewController {

    var dataDossier = [String]()
    var dataDossierDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func Save(sender: AnyObject) {
        if(dataDossierDefaults.stringArrayForKey("keyDossier1") != nil){
            dataDossier = dataDossierDefaults.stringArrayForKey("keyDossier1")!
        }
        if (textField != nil){
            dataDossier.append(textField.text!)
            dataDossierDefaults.setValue(dataDossier, forKey: "keyDossier1")
            print("projet créé")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
