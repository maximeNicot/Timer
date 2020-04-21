//
//  CustomTableViewCell.swift
//  Timer
//
//  Created by Antoine NICOT on 14/03/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit
import Foundation


class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePausePlay: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var boutonBrochure: UIButton!
    
    
    var delegate:CellDelegate!
    var identifier = 1
    // myDefaults contient le chrono
    var myDefaults = NSUserDefaults.standardUserDefaults()
   
    var timer = NSTimer()
    var chrono : Int = 0
    var oneTimer = true
    
    var isPageBlanche = false
    var nbCellPageBlanche = 0
    var isDossier = false
    
    
    
    @IBOutlet weak var boutonDroite: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
       
        labelTimer.text = String(chrono)
        
    }
    
    //click sur le bouton bleu a droite des cells
    @IBAction func OnClick(sender: AnyObject) {
        
        self.delegate.SegueFromCell(mydata: identifier)
        myDefaults.setValue(label.text, forKey: "labelTextCell") // Plus facile de passe la valeur comme ça finalement
         
    }
    
    func starter(){
        chrono = myDefaults.integerForKey("keyChrono" + String(identifier))
        labelTimer.text = String(chrono)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    
    func activerTimer(){
        
        if(oneTimer){
            if(!isDossier && !isPageBlanche){
            self.timer =  NSTimer.scheduledTimerWithTimeInterval(1.0,target: self, selector: Selector("incrementer"), userInfo: nil, repeats: true)
            oneTimer = false
            labelTimer.textColor = UIColor.redColor()
            
            imagePausePlay.image = UIImage(named: "ImagePauseRouge")
            }
        }
        
        else if(!oneTimer){
            if(!isDossier && !isPageBlanche){
            oneTimer = true
            self.timer.invalidate()
            labelTimer.textColor = UIColor.darkTextColor()
            
            imagePausePlay.image = UIImage(named: "ImageTriangle")
            }
        }
        
    }
    
    func pageBlanche(){
        imagePausePlay.image = UIImage(named: "PageBlanche")
        isPageBlanche = true
        //boutonDroite.setImage(UIImage(named: "Dossier"), forState: UIControlState.Normal)
        boutonDroite.hidden = true
        boutonDroite.enabled = false
    }
    
    func dossier(){
        imagePausePlay.image = UIImage(named: "Dossier")
        isDossier = true
        boutonDroite.hidden = true
        boutonDroite.enabled = false
        
    }
    
    func editSensInterdit(){
        imagePausePlay.image = UIImage(named: "SensInterdit")
    }
    
    func editTriangle(){
        imagePausePlay.image = UIImage(named: "ImageTriangle")
    }
    
    func actualiserChronoDossier(){
        var allChronoDuDossier = ""
        
        // faire une boucle pour chaque dossier identifier
        if (myDefaults.stringForKey("totalChrono" + String(2)) != nil){
            allChronoDuDossier = myDefaults.stringForKey("totalChrono" + String(2))!
            myDefaults.setValue(allChronoDuDossier, forKey: "keyChrono" + String(7000))

        }
        
        if (myDefaults.stringForKey("totalChrono" + String(102)) != nil){
            allChronoDuDossier = myDefaults.stringForKey("totalChrono" + String(102))!
            myDefaults.setValue(allChronoDuDossier, forKey: "keyChrono" + String(7001))
        }
    }
    
    internal func incrementer(){
        chrono = myDefaults.integerForKey("keyChrono" + String(identifier))
        chrono += 1
        myDefaults.setValue(chrono, forKey: "keyChrono" + String(identifier))
        labelTimer.text = String(chrono)
        
    }
}
