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
    var isQuickStart = false
    
    
    @IBOutlet weak var effacerButton: UIButton!
    
    @IBAction func effacerButtonClick(sender: AnyObject) {
    }
    
    @IBOutlet weak var boutonDroite: UIButton!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        effacerButton.hidden = true
        effacerButton.enabled = false
        labelTimer.text = String(chrono)
    }
    
    
    //click sur le bouton bleu a droite des cells
    @IBAction func OnClick(sender: AnyObject) {
        self.delegate.SegueFromCell(mydata: identifier)
        myDefaults.setValue(label.text, forKey: "labelTextCell")
        myDefaults.setValue(chrono, forKey: "timerQuickTaskUnique")
    }
    
    
    func starter(){
        chrono = myDefaults.integerForKey("keyChrono" + String(identifier))
        afficherChronoFormat()
    }
    
    
    func activerEffacerButton(){
        effacerButton.hidden = !effacerButton.hidden
        effacerButton.enabled = !effacerButton.enabled
    }
    
    
    func majChrono(){
        myDefaults.setValue(chrono, forKey: "keyChrono" + String(identifier))
        afficherChronoFormat()
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
    
    
    func quickStart(){
        imagePausePlay.image = UIImage(named: "ImageTriangle")
        isQuickStart = true
        isPageBlanche = false
        boutonDroite.hidden = false
        boutonDroite.enabled = true
    }
    
    
    func editSensInterdit(){
        imagePausePlay.image = UIImage(named: "SensInterdit")
    }
    
    
    func editTriangle(){
        imagePausePlay.image = UIImage(named: "ImageTriangle")
    }
    
    
    func actualiserChronoDossier(){
        var allChronoDuDossier = ""
        let dataDossier = myDefaults.stringArrayForKey("keyDossier1")!
        let nombreDossier = dataDossier.count
        
        for i in 0...nombreDossier-1{
            if (myDefaults.stringForKey("totalChrono" + String(2 + (100 * i))) != nil){
                allChronoDuDossier = myDefaults.stringForKey("totalChrono" + String(2 + (100 * i)))!
                myDefaults.setValue(allChronoDuDossier, forKey: "keyChrono" + String(7000 + i))
            }
        }
    }
    
    
    func actualiserChronoPageBlanche(){
        var allChronoPageBlanche = ""
        
        for i in 0...1{
            if (myDefaults.stringForKey("totalChrono" + String(1 + (100 * i))) != nil){
                allChronoPageBlanche = myDefaults.stringForKey("totalChrono" + String(1 + (100 * i)))!
                myDefaults.setValue(allChronoPageBlanche, forKey: "keyChrono" + String(8000 + i))                
            }
        }
    }
    
    
    func setChrono(){
        myDefaults.setValue(chrono, forKey: "keyChrono" + String(identifier))
    }
    
    
    internal func incrementer(){
        chrono = myDefaults.integerForKey("keyChrono" + String(identifier))
        chrono += 1
        myDefaults.setValue(chrono, forKey: "keyChrono" + String(identifier))
        afficherChronoFormat()
    }
    
    
    func effacerChronoSauvegarder(){
        myDefaults.setValue(0, forKey: "keyChrono" + String(identifier))
    }
    
    
    func afficherChronoFormat(){
        var monString = ""
        
        if(chrono < 60){
            labelTimer.text = String(chrono)
        }
        else if(chrono < 3600){
            monString = String(chrono/60) + ":"
            
            if(chrono%60 < 10){
                labelTimer.text = monString + "0" + String(chrono%60)
            }
            else{
                labelTimer.text = monString + String(chrono%60)
            }
        }
        else{ // chrono > 3600
            var myString = String((chrono/60)/60) + ":"
            
            if((chrono/60)%60 < 10){
                myString = String(chrono/60) + ":" + "0"
            }
            else{
                myString = String(chrono/60) + ":"
            }
            
            monString = String(chrono/60) + ":"
            if(chrono%60 < 10){
                labelTimer.text = myString + monString + "0" + String(chrono%60)
            }
            else{
                labelTimer.text = myString + monString + String(chrono%60)
            }
        }
    }
}
