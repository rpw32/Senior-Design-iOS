//
//  TestsViewController.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 4/19/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//
//  General layout of the TestsViewController is found here. It includes setup and formatting of all labels. Label could be added into its own custom class derived from UILabel() that performs formatting later on.
//  This would clean up the ViewController a little bit.

import Foundation
import UIKit

class TestsViewController: UIViewController {
    
    typealias Result = (result:String, code:Int)
    
    let grades = [-1: "N/A", 0: "Bad", 1: "Acceptable", 2: "Best"]
    var resultsArray: [Result] = [("", -1)]
    var vc = UIViewController()
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let calorieDensityResult = UserDefaults.standard.double(forKey:"calorieDensity")
        let totalFatResult = UserDefaults.standard.double(forKey:"totalFat")
        let saturatedFatResult = UserDefaults.standard.double(forKey:"saturatedFat")
        let cholesterolCountResult = UserDefaults.standard.double(forKey:"cholesterolContent")
        let sodiumContentResult = UserDefaults.standard.double(forKey:"sodiumContent")
        let fiberContentResult = UserDefaults.standard.double(forKey:"fiberContent")
        
        
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        let calorieLabel = UILabel()
        let calorieAccept = UILabel()
        let calorieLabel2 = UILabel()
        
        let totalFatLabel = UILabel()
        let totalFatAccept = UILabel()
        let totalFatLabel2 = UILabel()
        
        let satFatLabel = UILabel()
        let satFatAccept = UILabel()
        let satFatLabel2 = UILabel()
        
        let transFatLabel = UILabel()
        let transFatLabel2 = UILabel()
        
        let cholesterolLabel = UILabel()
        let cholesterolAccept = UILabel()
        let cholesterolLabel2 = UILabel()
        
        let sodiumLabel = UILabel()
        let sodiumAccept = UILabel()
        let sodiumLabel2 = UILabel()
        
        let fiberLabel = UILabel()
        let fiberAccept = UILabel()
        let fiberLabel2 = UILabel()
        
        let floursLabel = UILabel()
        let floursLabel2 = UILabel()
        
        let sugarsLabel = UILabel()
        let sugarsLabel2 = UILabel()
        
        let fontName = "HelveticaNeue"
        let fontSize: CGFloat = 14
        
        calorieLabel.text = "Calorie Density Test"
        calorieAccept.text = "Accepted Value: \(String(format: "%.3f", (calorieDensityResult*0.02*1.25)-0.25)) cal/serving - \(String(format: "%.3f", (calorieDensityResult*0.02*1.25)+0.25)) cal/serving"
        calorieLabel2.numberOfLines = 2
        calorieLabel2.lineBreakMode = .byWordWrapping
        calorieLabel2.text = "\(resultsArray[0].result)\nRating: \t\t\t\t\t\(grades[resultsArray[0].code]!)"
        calorieLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        calorieAccept.font = UIFont(name: fontName, size: fontSize)
        calorieLabel2.font = UIFont(name: fontName, size: fontSize)
        
        totalFatLabel.text = "Total Fat Test"
        totalFatAccept.text = "Accepted Value: \(String(format: "%.0f", ((totalFatResult*0.02*0.175)-0.025)*100))% - \(String(format: "%.0f", ((totalFatResult*0.02*0.175)+0.025)*100))%"
        totalFatLabel2.numberOfLines = 2
        totalFatLabel2.lineBreakMode = .byWordWrapping
        totalFatLabel2.text = "\(resultsArray[1].result)\nRating: \t\t\t\t\t\(grades[resultsArray[1].code]!)"
        totalFatLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        totalFatAccept.font = UIFont(name: fontName, size: fontSize)
        totalFatLabel2.font = UIFont(name: fontName, size: fontSize)
        
        satFatLabel.text = "Saturated Fat Test"
        satFatAccept.text = "Accepted Value: \(String(format: "%.0f", ((saturatedFatResult*0.02*0.06)-0.01)*100))% - \(String(format: "%.0f", ((saturatedFatResult*0.02*0.06)+0.01)*100))%"
        satFatLabel2.numberOfLines = 2
        satFatLabel2.lineBreakMode = .byWordWrapping
        satFatLabel2.text = "\(resultsArray[2].result)\nRating: \t\t\t\t\t\(grades[resultsArray[2].code]!)"
        satFatLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        satFatAccept.font = UIFont(name: fontName, size: fontSize)
        satFatLabel2.font = UIFont(name: fontName, size: fontSize)
        
        transFatLabel.text = "Trans Fat Test"
        transFatLabel2.numberOfLines = 2
        transFatLabel2.lineBreakMode = .byWordWrapping
        transFatLabel2.text = "\(resultsArray[3].result)\nRating: \t\t\t\t\t\(grades[resultsArray[3].code]!)"
        transFatLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        transFatLabel2.font = UIFont(name: fontName, size: fontSize)
        
        cholesterolLabel.text = "Cholesterol Test"
        cholesterolAccept.text = "Accepted Value: \(String(format: "%.0f", (cholesterolCountResult*0.02*12.5)-12.5))mg - \(String(format: "%.0f", (cholesterolCountResult*0.02*12.5)+12.5))mg"
        cholesterolLabel2.numberOfLines = 2
        cholesterolLabel2.lineBreakMode = .byWordWrapping
        cholesterolLabel2.text = "\(resultsArray[4].result)\nRating: \t\t\t\t\t\(grades[resultsArray[4].code]!)"
        cholesterolLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        cholesterolAccept.font = UIFont(name: fontName, size: fontSize)
        cholesterolLabel2.font = UIFont(name: fontName, size: fontSize)
        
        sodiumLabel.text = "Sodium Test"
        sodiumAccept.text = "Accepted Value: \(String(format: "%.0f", (sodiumContentResult*0.02*1)-1)) mg/cal - \(String(format: "%.0f", (sodiumContentResult*0.02*1)+1)) mg/cal"
        sodiumLabel2.numberOfLines = 2
        sodiumLabel2.lineBreakMode = .byWordWrapping
        sodiumLabel2.text = "\(resultsArray[5].result)\nRating: \t\t\t\t\t\(grades[resultsArray[5].code]!)"
        sodiumLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        sodiumAccept.font = UIFont(name: fontName, size: fontSize)
        sodiumLabel2.font = UIFont(name: fontName, size: fontSize)
        
        fiberLabel.text = "Fiber Test"
        fiberAccept.text = "Accepted Value: \(String(format: "%.0f", (fiberContentResult*0.02*2)-1)) g - \(String(format: "%.0f", (fiberContentResult*0.02*2)+1)) g per 100 cal"
        fiberLabel2.numberOfLines = 2
        fiberLabel2.lineBreakMode = .byWordWrapping
        fiberLabel2.text = "\(resultsArray[6].result)\nRating: \t\t\t\t\t\(grades[resultsArray[6].code]!)"
        fiberLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        fiberAccept.font = UIFont(name: fontName, size: fontSize)
        fiberLabel2.font = UIFont(name: fontName, size: fontSize)
        
        floursLabel.text = "Flours Test"
        floursLabel2.numberOfLines = 2
        floursLabel2.lineBreakMode = .byWordWrapping
        floursLabel2.text = "\(resultsArray[7].result)\nRating: \t\t\t\t\t\(grades[resultsArray[7].code]!)"
        floursLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        floursLabel2.font = UIFont(name: fontName, size: fontSize)
        
        sugarsLabel.text = "Sugars Test"
        sugarsLabel2.numberOfLines = 2
        sugarsLabel2.lineBreakMode = .byWordWrapping
        sugarsLabel2.text = "\(resultsArray[8].result)\nRating: \t\t\t\t\t\(grades[resultsArray[8].code]!)"
        sugarsLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        sugarsLabel2.font = UIFont(name: fontName, size: fontSize)
        
        stackView.addArrangedSubview(calorieLabel)
        stackView.addArrangedSubview(calorieAccept)
        stackView.addArrangedSubview(calorieLabel2)
        
        stackView.addArrangedSubview(totalFatLabel)
        stackView.addArrangedSubview(totalFatAccept)
        stackView.addArrangedSubview(totalFatLabel2)
        
        stackView.addArrangedSubview(satFatLabel)
        stackView.addArrangedSubview(satFatAccept)
        stackView.addArrangedSubview(satFatLabel2)
        
        stackView.addArrangedSubview(transFatLabel)
        stackView.addArrangedSubview(transFatLabel2)
        
        stackView.addArrangedSubview(cholesterolLabel)
        stackView.addArrangedSubview(cholesterolAccept)
        stackView.addArrangedSubview(cholesterolLabel2)
        
        stackView.addArrangedSubview(sodiumLabel)
        stackView.addArrangedSubview(sodiumAccept)
        stackView.addArrangedSubview(sodiumLabel2)
        
        stackView.addArrangedSubview(fiberLabel)
        stackView.addArrangedSubview(fiberAccept)
        stackView.addArrangedSubview(fiberLabel2)
        
        stackView.addArrangedSubview(floursLabel)
        stackView.addArrangedSubview(floursLabel2)
        
        stackView.addArrangedSubview(sugarsLabel)
        stackView.addArrangedSubview(sugarsLabel2)

    }
    
    @IBAction func closePopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
}
