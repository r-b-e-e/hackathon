//
//  NearByViewController.swift
//  Near Care
//
//  Created by Niranjan Ravichandran on 29/01/16.
//  Copyright © 2016 adavers. All rights reserved.
//

import UIKit
import MapKit

class NearByViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    
    let locManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Near Care"
        
      self.tabBarController?.tabBar.tintColor = APP_BASE_COLOR
        
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
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    override func viewDidDisappear(animated: Bool) {
        locManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.first != nil {
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.6)
            let center = CLLocationCoordinate2D(latitude: locations.last!.coordinate.latitude, longitude: locations.last!.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: span)
            self.mapView.setRegion(region, animated: true)
            self.plotHospitals()
            
        }
    }
    
    func plotHospitals() {
        if let hospitalList = hospitals {
            for item in hospitalList {
                let address = "\(item.address),\(item.city),\(item.state), USA"
                let geocoder = CLGeocoder()
                geocoder.geocodeAddressString(address) { (placemarks, locationError) -> Void in
                    if let placemark = placemarks?.first {
                        self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
                    }
                }
            }
        }
    }

}
