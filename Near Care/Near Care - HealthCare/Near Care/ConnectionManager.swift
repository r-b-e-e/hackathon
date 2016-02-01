//
//  ConnectionManager.swift
//  Near Care
//
//  Created by Niranjan Ravichandran on 30/01/16.
//  Copyright © 2016 adavers. All rights reserved.
//

import Foundation
import Alamofire

class ConnectionManager {
    
    static let sharedManager = ConnectionManager()
    
    func getHospitals(city: String, state: String, type: String, completion: (success: Bool, hospitals: [Hospital]) -> Void) {
        print(type)
        
        var hospitals = [Hospital]()
        
        Alamofire.request(.POST, "http://54.152.22.240/API/index.php", parameters: ["city": city, "state": state, "type": type]).responseJSON { (response) -> Void in
            
            if let jsonResponse = response.result.value as? NSDictionary {
                
                for item in jsonResponse["value"] as! [NSDictionary]{
                    hospitals.append(Hospital(jsonResponse: item))
                }
                completion(success: true, hospitals: hospitals)
            }
            
        }
        
    }
    
    func getGraphValues(city: String, state: String, type: String, completion: (avg: Averages?)-> Void) {
        
        Alamofire.request(.POST, "http://54.152.22.240/API/average.php", parameters: ["city": city, "state": state, "type": type]).responseJSON { (response) -> Void in
            
            if let jsonReponse = response.result.value as? NSDictionary {
                if let item = jsonReponse["value"] as? [NSDictionary] {
                    print(item)
                    if let average: Averages = Averages(jsonResponse: item.first!) {
                        print(average)
                        completion(avg: average)
                    }else {
                        completion(avg: nil)
                    }
                }
            
            }
        }
    }
}