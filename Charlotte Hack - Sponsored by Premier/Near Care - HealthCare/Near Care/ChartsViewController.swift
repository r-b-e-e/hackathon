//
//  ChartsViewController.swift
//  Near Care
//
//  Created by Niranjan Ravichandran on 30/01/16.
//  Copyright © 2016 adavers. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: UIViewController {

    @IBOutlet var barChartView: BarChartView!
    var thisAverage = [Double]()
    var currentHospital: Hospital?
    
    var factors = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let city = currentCity, state = currentState {
            ConnectionManager.sharedManager.getGraphValues(city, state: state, type: currentType) { (avg) -> Void in
                if let newAverage = avg {
                    self.thisAverage.append(Double(newAverage.avgRateOfMortality!)!)
                    self.thisAverage.append(Double(newAverage.avgRateOfComplications!)!)
                    self.thisAverage.append(Double(newAverage.avgPatientExp!)!)
                    self.thisAverage.append(Double(newAverage.avgMedicareCoverage!)!)
                }
                if let values = self.currentHospital {
                    self.factors = ["Mort", "Comp", "Exp", "Cov"]
                    let hospitalValues = [Double(values.rateOfMortality!)!, Double(values.rateOfComplication!)!, Double(values.patientExperience!)!, Double(values.mdeicareCoverage!)!]
                    self.setChart(self.factors, values: hospitalValues)
                }

            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [BarChartDataEntry] = []
        var avgData: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
            let nextEntry = BarChartDataEntry(value: self.thisAverage[i], xIndex: i)
            avgData.append(nextEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: currentHospital?.name)
        chartDataSet.colors = [UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1)]
        let chartSecondDataSet = BarChartDataSet(yVals: avgData, label: "Average")
        let chartData = BarChartData(xVals: self.factors, dataSets: [chartDataSet, chartSecondDataSet])
        barChartView.data = chartData
    }


}
