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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        
        dataPageBlanche.append("Single Tasks")
        
        
        tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        if(dataDossierDefaults.stringArrayForKey("keyDossier1") != nil){
            dataDossier = dataDossierDefaults.stringArrayForKey("keyDossier1")!
        }
        
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //blank space
        let label = UILabel()
        label.backgroundColor = UIColor.lightGrayColor()
        return label
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
            
            //cell.delegate = self
        }
        
        if(indexPath.section == 1){
            
            cell.label.text = dataDossier[indexPath.row]
            
            cell.identifier = indexPath.row + 70000
            cell.starter()
            cell.dossier()
            //cell.actualiserChronoDossier()
            
            //cell.delegate = self
        }
        
        return cell
        
    }
    
    // click sur la cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
        
        if(currentCell.isDossier){
            
            performSegueWithIdentifier("segueEditController", sender: self)
        }
        if(currentCell.isPageBlanche){
            
            performSegueWithIdentifier("segueEditController", sender: self)
        }
        else{
            currentCell.activerTimer()
        }
    }
}
