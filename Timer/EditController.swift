//
//  EditController.swift
//  Timer
//
//  Created by Antoine NICOT on 26/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class EditController: UIViewController {
    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var textFieldProjet: UITextField!
    
    
    @IBAction func onProjetClick(sender: AnyObject) {
        
        performSegueWithIdentifier("segueChoix", sender: nil)
    }
}
