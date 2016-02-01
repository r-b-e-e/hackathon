//
//  ViewController.swift
//  Near Care
//
//  Created by Niranjan Ravichandran on 29/01/16.
//  Copyright © 2016 adavers. All rights reserved.
//

import UIKit
import CoreLocation
import UNAlertView

var hospitals: [Hospital]?
var currentType: String = "All"
var currentCity: String?
var currentState: String?

class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var nextButton: UIButton!
    @IBOutlet var hospitalType: UITextField!
    @IBOutlet var zipcode: CustomField!

    @IBOutlet var typeTableView: UITableView!
    
    let locManager = CLLocationManager()
    let types = ["Veteran Care", "Acute Care", "Children Care", "Critical Access", "All"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nextButton.layer.cornerRadius = 4
        self.hospitalType.layer.cornerRadius = 3
        self.zipcode.layer.cornerRadius = 3
        
        self.hospitalType.tag = 101
        self.zipcode.tag = 100
        self.hospitalType.delegate = self
        self.zipcode.delegate = self
        
        locManager.delegate = self
        
        self.typeTableView.delegate = self
        self.typeTableView.dataSource = self
        self.typeTableView.alpha = 0
        self.typeTableView.layer.cornerRadius = 4
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        hideTypesTableview()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.tag == 101 {
            self.zipcode.resignFirstResponder()
            textField.resignFirstResponder()
            
            let height = self.typeTableView.frame.height
            self.typeTableView.frame.size.height = 0
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.typeTableView.alpha = 1
                self.typeTableView.frame.size.height = height
            })
            return false
        }
        return true
    }

    @IBAction func nextAction(sender: AnyObject) {
        if self.zipcode.text?.characters.count > 0 {
            if let city = currentCity, state = currentState {
                ConnectionManager.sharedManager.getHospitals(city, state: state, type: currentType) { (success, hospitalList) -> Void in
                    if hospitalList.count > 0 {
                        hospitals = hospitalList
                        
                        self.performSegueWithIdentifier("moveToTabView", sender: self)
                    }
                }
            }
        }else {
            let alertView = UNAlertView(title: "Oops!", message: "Please enter zipcode and hospital to proceed.")
            alertView.addButton("Ok",
                backgroundColor: UIColor(red: 255/255, green: 84/255, blue: 81/255, alpha: 1.0),
                fontColor: UIColor.whiteColor(),
                action: {
                    
                    //Handle action
            })
            alertView.show()
        }
    }

    @IBAction func getCurrentLocation(sender: AnyObject) {
        locManager.requestWhenInUseAuthorization()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, locationError) -> Void in
            if locationError != nil {
                print("Reverse Geo-Code failed with error" + locationError!.localizedDescription)
            }else {
                if placemarks?.count > 0 {
                    if let postalCode = placemarks?.first?.postalCode{
                        self.zipcode.text = postalCode
                        currentCity = placemarks?.first?.locality
                        currentState = placemarks?.first?.administrativeArea
                    }else {
                        
                    }
                }
                self.locManager.stopUpdatingLocation()
            }
        }
    }
    
    
    //MARK: Tableview
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = types[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        self.hospitalType.text = selectedCell?.textLabel?.text
        if indexPath.row == 0 {
            currentType = "Acute Care - Veterans Administration"
        }else if indexPath.row == 1 {
            currentType = "Acute Care Hospitals"
        }else if indexPath.row == 2 {
            currentType = "Childrens"
        }else if indexPath.row == 3{
            currentType = "Critical Access Hospitals"
        }else {
            currentType = "All"
        }
        self.hideTypesTableview()
    }
    
    func hideTypesTableview() {
        UIView.animateWithDuration(0.3) { () -> Void in
            self.typeTableView.frame.size.height = 0
            self.typeTableView.alpha = 0
            self.hospitalType.resignFirstResponder()
        }

    }
}

