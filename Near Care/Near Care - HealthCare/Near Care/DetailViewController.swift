//
//  DetailViewController.swift
//  Near Care
//
//  Created by Niranjan Ravichandran on 30/01/16.
//  Copyright © 2016 adavers. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView(frame: UIScreen.mainScreen().bounds)
    var hospitalObject: Hospital?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        
        self.tableView.registerNib(UINib(nibName: "DetailedNameCell", bundle: nil), forCellReuseIdentifier: "NameCell")
        self.tableView.registerNib(UINib(nibName: "AddressViewCell", bundle: nil), forCellReuseIdentifier: "AddressViewCell")
        self.view.addSubview(tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NameCell", forIndexPath: indexPath) as! DetailedNameCell
            cell.name.text = hospitalObject?.name
            if hospitalObject?.type == "Acute Care - Veterans Administration" {
                cell.icon.image = UIImage(named: "vet.png")
            }else if hospitalObject?.type == "Acute Care Hospitals"{
                cell.icon.image = UIImage(named: "acute.png")
            }else if hospitalObject?.type == "Childrens" {
                cell.icon.image = UIImage(named: "child.png")
            }else {
                cell.icon.image = UIImage(named: "critical.png")
            }

            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("AddressViewCell", forIndexPath: indexPath) as! AddressViewCell
            cell.address.text = "\(hospitalObject!.address!), \(hospitalObject!.city!), \(hospitalObject!.state!)"
            cell.phone.text = hospitalObject?.phone
            return cell
        }else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "View stats"
            cell.textLabel?.textColor = UIColor.darkGrayColor()
            cell.accessoryType = .DisclosureIndicator
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        }else if indexPath.row == 1 {
            return 110
        }else {
            return 55
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            let charVC = ChartsViewController()
            charVC.currentHospital = hospitalObject
            self.navigationController?.pushViewController(charVC, animated: true)
        }
    }


}
