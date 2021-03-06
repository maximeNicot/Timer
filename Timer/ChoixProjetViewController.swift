//
//  ChoixProjetViewController.swift
//  Timer
//
//  Created by Antoine NICOT on 21/04/2020.
//  Copyright © 2020 maxime. All rights reserved.
//

import UIKit

class ChoixProjetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var tableView: UITableView!
    
    var dataPageBlanche = [String]()
    var dataDossier = [String]()
    
    var dataDossierDefaults = NSUserDefaults.standardUserDefaults()
    var nomProjetSend = ""
    
    var identifierCell = 0
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        super.viewDidLoad()
        
        dataPageBlanche.append("Single Tasks")
        tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        if(dataDossierDefaults.stringArrayForKey("keyDossier1") != nil){
            dataDossier = dataDossierDefaults.stringArrayForKey("keyDossier1")!
        }
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.lightGrayColor()
        return label
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return dataPageBlanche.count
        }
        if(section == 1){
            return (dataDossier.count)
        }
        return (dataDossier.count)
    }
    
    //Creation cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        if(indexPath.section == 0){
            cell.label.text = dataPageBlanche[indexPath.row]
            cell.identifier = indexPath.row + 80000
            cell.starter()
            cell.pageBlanche()
        }
        
        if(indexPath.section == 1){
            cell.label.text = dataDossier[indexPath.row]
            cell.identifier = indexPath.row + 70000
            cell.starter()
            cell.dossier()
        }
        
        return cell
    }
    
    // click sur la cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
        
        if(currentCell.isDossier){
            nomProjetSend = currentCell.label.text!
            performSegueWithIdentifier("segueEditController", sender: self)
        }
        if(currentCell.isPageBlanche){
            nomProjetSend = currentCell.label.text!
            performSegueWithIdentifier("segueEditController", sender: self)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.identifier)
        
        if(segue.identifier == "segueEditController"){
            let vc = segue.destinationViewController as! EditController
            vc.nomProjet = nomProjetSend
            vc.identifierCell = self.identifierCell
        }
        else{
        }
    }
}
