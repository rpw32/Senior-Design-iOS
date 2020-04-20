//
//  TestsViewController.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 4/19/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//

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
    
        
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        let calorieLabel = UILabel()
        let calorieLabel2 = UILabel()
        let totalFatLabel = UILabel()
        let totalFatLabel2 = UILabel()
        let satFatLabel = UILabel()
        let satFatLabel2 = UILabel()
        let transFatLabel = UILabel()
        let transFatLabel2 = UILabel()
        let cholesterolLabel = UILabel()
        let cholesterolLabel2 = UILabel()
        let sodiumLabel = UILabel()
        let sodiumLabel2 = UILabel()
        let fiberLabel = UILabel()
        let fiberLabel2 = UILabel()
        let floursLabel = UILabel()
        let floursLabel2 = UILabel()
        let sugarsLabel = UILabel()
        let sugarsLabel2 = UILabel()
        
        let fontName = "HelveticaNeue"
        let fontSize: CGFloat = 15
        
        calorieLabel.text = "Calorie Density Test"
        calorieLabel2.numberOfLines = 3
        calorieLabel2.text = "\(resultsArray[0].result)\nRating: \(grades[resultsArray[0].code]!)"
        calorieLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        calorieLabel2.font = UIFont(name: fontName, size: fontSize)
        
        totalFatLabel.text = "Total Fat Test"
        totalFatLabel2.numberOfLines = 3
        totalFatLabel2.text = "\(resultsArray[1].result)\nRating: \(grades[resultsArray[1].code]!)"
        totalFatLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        totalFatLabel2.font = UIFont(name: fontName, size: fontSize)
        
        satFatLabel.text = "Saturated Fat Test"
        satFatLabel2.numberOfLines = 3
        satFatLabel2.text = "\(resultsArray[2].result)\nRating: \(grades[resultsArray[2].code]!)"
        satFatLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        satFatLabel2.font = UIFont(name: fontName, size: fontSize)
        
        transFatLabel.text = "Trans Fat Test"
        transFatLabel2.numberOfLines = 3
        transFatLabel2.text = "\(resultsArray[3].result)\nRating: \(grades[resultsArray[3].code]!)"
        transFatLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        transFatLabel2.font = UIFont(name: fontName, size: fontSize)
        
        cholesterolLabel.text = "Cholesterol Test"
        cholesterolLabel2.numberOfLines = 3
        cholesterolLabel2.text = "\(resultsArray[4].result)\nRating: \(grades[resultsArray[4].code]!)"
        cholesterolLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        cholesterolLabel2.font = UIFont(name: fontName, size: fontSize)
        
        sodiumLabel.text = "Sodium Test"
        sodiumLabel2.numberOfLines = 3
        sodiumLabel2.text = "\(resultsArray[5].result)\nRating: \(grades[resultsArray[5].code]!)"
        sodiumLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        sodiumLabel2.font = UIFont(name: fontName, size: fontSize)
        
        fiberLabel.text = "Fiber Test"
        fiberLabel2.numberOfLines = 3
        fiberLabel2.text = "\(resultsArray[6].result)\nRating: \(grades[resultsArray[6].code]!)"
        fiberLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        fiberLabel2.font = UIFont(name: fontName, size: fontSize)
        
        floursLabel.text = "Flours Test"
        floursLabel2.numberOfLines = 3
        floursLabel2.text = "\(resultsArray[7].result)\nRating: \(grades[resultsArray[7].code]!)"
        floursLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        floursLabel2.font = UIFont(name: fontName, size: fontSize)
        
        sugarsLabel.text = "Sugars Test"
        sugarsLabel2.numberOfLines = 3
        sugarsLabel2.text = "\(resultsArray[8].result)\nRating: \(grades[resultsArray[8].code]!)"
        sugarsLabel.font = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(15))
        sugarsLabel2.font = UIFont(name: fontName, size: fontSize)
        
        stackView.addArrangedSubview(calorieLabel)
        stackView.addArrangedSubview(calorieLabel2)
        stackView.addArrangedSubview(totalFatLabel)
        stackView.addArrangedSubview(totalFatLabel2)
        stackView.addArrangedSubview(satFatLabel)
        stackView.addArrangedSubview(satFatLabel2)
        stackView.addArrangedSubview(transFatLabel)
        stackView.addArrangedSubview(transFatLabel2)
        stackView.addArrangedSubview(cholesterolLabel)
        stackView.addArrangedSubview(cholesterolLabel2)
        stackView.addArrangedSubview(sodiumLabel)
        stackView.addArrangedSubview(sodiumLabel2)
        stackView.addArrangedSubview(fiberLabel)
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
