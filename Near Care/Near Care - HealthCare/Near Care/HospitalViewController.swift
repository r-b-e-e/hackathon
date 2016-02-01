//
//  HospitalViewController.swift
//  Near Care
//
//  Created by Niranjan Ravichandran on 29/01/16.
//  Copyright © 2016 adavers. All rights reserved.
//

import UIKit

class HospitalViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView = UITableView(frame: UIScreen.mainScreen().bounds)
    var hospitalList = hospitals

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Near Care"

        self.tabBarController?.tabBar.tintColor = APP_BASE_COLOR
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: "HospitalTableCell", bundle: nil), forCellReuseIdentifier: "HospitalCell")
        tableView.separatorStyle = .None
        
        self.view.addSubview(tableView)
        //Removing tabbar shadow
        self.tabBarController?.tabBar.clipsToBounds = true
        
        //Removing navbar shadow
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if childView.frame.height == 0.5 {
                    childView.removeFromSuperview()
                }
            }
        }
        
        let backButton = UIBarButtonItem(image: UIImage(named: "left.png"), style: .Done, target: self, action: "backAction")
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        performSegueWithIdentifier("moveToTabView", sender: self)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let count = hospitals?.count {
            return count
        }else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HospitalCell", forIndexPath: indexPath) as? HospitalTableCell
        cell?.name.text = hospitals![indexPath.section].name
        cell?.hospitalObject = hospitals![indexPath.section]
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height = calculateHeightForString(hospitals![indexPath.section].name!)
        return height + 60
    }
    
    func calculateHeightForString(inString:String) -> CGFloat
    {
        let messageString = inString
        let attrString:NSAttributedString? = NSAttributedString(string: messageString, attributes: [NSFontAttributeName: UIFont(name: "Georgia", size: 15)!])
        let rect:CGRect = attrString!.boundingRectWithSize(CGSizeMake(300.0,CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context:nil )//hear u will get nearer height not the exact value
        let requredSize:CGRect = rect
        return requredSize.height
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailVc = DetailViewController()
        detailVc.hospitalObject = hospitalList![indexPath.section]
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
}
