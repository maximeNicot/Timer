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
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
