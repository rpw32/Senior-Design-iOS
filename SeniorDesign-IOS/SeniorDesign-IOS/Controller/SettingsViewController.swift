//
//  SettingsViewController.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 4/20/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    let step = 1
    var calorieDensityResult: Double = 0.0
    var totalFatResult: Double = 0.0
    var saturatedFatResult: Double = 0.0
//    var transFatResult: Double = 0.0
    var cholesterolCountResult: Double = 0.0
    var sodiumContentResult: Double = 0.0
    var condSodiumContentResult: Double = 0.0
    var fiberContentResult: Double = 0.0
//    var floursResult: Double = 0.0
//    var sugarsResult: Double = 0.0
    
    @IBOutlet weak var calorieVal: UILabel!
    @IBOutlet weak var totalFatVal: UILabel!
    @IBOutlet weak var satFatVal: UILabel!
    @IBOutlet weak var cholVal: UILabel!
    @IBOutlet weak var sodiumVal: UILabel!
    @IBOutlet weak var condSodiumVal: UILabel!
    @IBOutlet weak var fiberVal: UILabel!

    
    @IBOutlet weak var calorieSlider: UISlider!
    @IBOutlet weak var totalFatSlider: UISlider!
    @IBOutlet weak var satFatSlider: UISlider!
    @IBOutlet weak var cholSlider: UISlider!
    @IBOutlet weak var sodiumSlider: UISlider!
    @IBOutlet weak var condSodiumSlider: UISlider!
    @IBOutlet weak var fiberSlider: UISlider!

    
    
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        
        /* All values restored to their UserDefault setting from last time it was set. Sliders are moved back into place as well */
        calorieDensityResult = UserDefaults.standard.double(forKey:"calorieDensity")
        totalFatResult = UserDefaults.standard.double(forKey:"totalFat")
        saturatedFatResult = UserDefaults.standard.double(forKey:"saturatedFat")
//        transFatResult = UserDefaults.standard.double(forKey:"transFat")
        cholesterolCountResult = UserDefaults.standard.double(forKey:"cholesterolContent")
        sodiumContentResult = UserDefaults.standard.double(forKey:"sodiumContent")
        condSodiumContentResult = UserDefaults.standard.double(forKey:"condSodiumContent")
        fiberContentResult = UserDefaults.standard.double(forKey:"fiberContent")
//        floursResult = UserDefaults.standard.double(forKey:"flours")
//        sugarsResult = UserDefaults.standard.double(forKey:"sugars")
        
        calorieSlider.value = Float(calorieDensityResult/100)
        totalFatSlider.value = Float(totalFatResult/100)
        satFatSlider.value = Float(saturatedFatResult/100)
        cholSlider.value = Float(cholesterolCountResult/100)
        sodiumSlider.value = Float(sodiumContentResult/100)
        condSodiumSlider.value = Float(condSodiumContentResult/100)
        fiberSlider.value = Float(fiberContentResult/100)
        
        
        
        /* Checking to make sure the values are not negative. Those that are are replaced with zeros */
        if (calorieDensityResult*0.02*1.25)-0.25 < 0 {
            calorieVal.text = "0 cal/serving - \(String(format: "%.3f", (calorieDensityResult*0.02*1.25)+0.25)) cal/serving"
        }
        else {
            calorieVal.text = "\(String(format: "%.3f", (calorieDensityResult*0.02*1.25)-0.25)) cal/serving - \(String(format: "%.3f", (calorieDensityResult*0.02*1.25)+0.25)) cal/serving"
        }
        
        if (((totalFatResult*0.02*0.175)-0.025)*100) < 0 {
            totalFatVal.text = "0% - \(String(format: "%.0f", ((totalFatResult*0.02*0.175)+0.025)*100))%"
        }
        else {
            totalFatVal.text = "\(String(format: "%.0f", ((totalFatResult*0.02*0.175)-0.025)*100))% - \(String(format: "%.0f", ((totalFatResult*0.02*0.175)+0.025)*100))%"
        }
        
        if (((saturatedFatResult*0.02*0.06)-0.01)*100) < 0 {
            satFatVal.text = "0% - \(String(format: "%.0f", ((saturatedFatResult*0.02*0.06)+0.01)*100))%"
        }
        else {
            satFatVal.text = "\(String(format: "%.0f", ((saturatedFatResult*0.02*0.06)-0.01)*100))% - \(String(format: "%.0f", ((saturatedFatResult*0.02*0.06)+0.01)*100))%"
        }
        
        //cholesterol
        if ((cholesterolCountResult*0.02*12.5)-12.5) < 0 {
            cholVal.text = "0 mg - \(String(format: "%.0f", (cholesterolCountResult*0.02*12.5)+12.5))mg"
        }
        else {
            cholVal.text = "\(String(format: "%.0f", (cholesterolCountResult*0.02*12.5)-12.5))mg - \(String(format: "%.0f", (cholesterolCountResult*0.02*12.5)+12.5))mg"
        }
        
        if ((sodiumContentResult*0.02*1)-1) < 0 {
            sodiumVal.text = "0 mg/cal - \(String(format: "%.0f", (sodiumContentResult*0.02*1)+1)) mg/cal"
        }
        else {
            sodiumVal.text = "\(String(format: "%.0f", (sodiumContentResult*0.02*1)-1)) mg/cal - \(String(format: "%.0f", (sodiumContentResult*0.02*1)+1)) mg/cal"
        }
        
        if ((condSodiumContentResult*0.02*2)-2) < 0 {
            condSodiumVal.text = "0 mg/cal - \(String(format: "%.0f", (condSodiumContentResult*0.02*2)+2)) mg/cal"
        }
        else {
            condSodiumVal.text = "\(String(format: "%.0f", (condSodiumContentResult*0.02*2)-2)) mg/cal - \(String(format: "%.0f", (condSodiumContentResult*0.02*2)+2)) mg/cal"
        }
        
        if ((fiberContentResult*0.02*2)-1) < 0 {
            fiberVal.text = "0 g - \(String(format: "%.0f", (fiberContentResult*0.02*2)+1)) g per 100 cal"
        }
        else {
            fiberVal.text = "\(String(format: "%.0f", (fiberContentResult*0.02*2)-1)) g - \(String(format: "%.0f", (fiberContentResult*0.02*2)+1)) g per 100 cal"
        }
        

    }
    
    
    /* Called whenever sliders are moved on the settings screen. Some functions commented out as they are currently not offered as options. Could be added later.*/
    @IBAction func sliderMoved(_ sender: UISlider) {
        if sender == calorieSlider {
            calorieDensityResult = round(Double(sender.value)*100)
            if (calorieDensityResult*0.02*1.25)-0.25 < 0 {
                calorieVal.text = "0 cal/serving - \(String(format: "%.3f", (calorieDensityResult*0.02*1.25)+0.25)) cal/serving"
            }
            else {
                calorieVal.text = "\(String(format: "%.3f", (calorieDensityResult*0.02*1.25)-0.25)) cal/serving - \(String(format: "%.3f", (calorieDensityResult*0.02*1.25)+0.25)) cal/serving"
            }
        }
        else if sender == totalFatSlider {
            totalFatResult = round(Double(sender.value)*100)
            if (((totalFatResult*0.02*0.175)-0.025)*100) < 0 {
                totalFatVal.text = "0% - \(String(format: "%.0f", ((totalFatResult*0.02*0.175)+0.025)*100))%"
            }
            else {
                totalFatVal.text = "\(String(format: "%.0f", ((totalFatResult*0.02*0.175)-0.025)*100))% - \(String(format: "%.0f", ((totalFatResult*0.02*0.175)+0.025)*100))%"
            }
        }
        else if sender == satFatSlider {
            saturatedFatResult = round(Double(sender.value)*100)
            if (((saturatedFatResult*0.02*0.06)-0.01)*100) < 0 {
                satFatVal.text = "0% - \(String(format: "%.0f", ((saturatedFatResult*0.02*0.06)+0.01)*100))%"
            }
            else {
                satFatVal.text = "\(String(format: "%.0f", ((saturatedFatResult*0.02*0.06)-0.01)*100))% - \(String(format: "%.0f", ((saturatedFatResult*0.02*0.06)+0.01)*100))%"
            }
        }
//        else if sender == transFatSlider {
//            transFatResult = round(Double(sender.value)*100)
//            transFatVal.text = String(format: "%.2f", transFatResult)
//        }
        else if sender == cholSlider {
            cholesterolCountResult = round(Double(sender.value)*100)
            if ((cholesterolCountResult*0.02*12.5)-12.5) < 0 {
                cholVal.text = "0 mg - \(String(format: "%.0f", (cholesterolCountResult*0.02*12.5)+12.5))mg"
            }
            else {
                cholVal.text = "\(String(format: "%.0f", (cholesterolCountResult*0.02*12.5)-12.5))mg - \(String(format: "%.0f", (cholesterolCountResult*0.02*12.5)+12.5))mg"
            }
        }
        else if sender == sodiumSlider {
            sodiumContentResult = round(Double(sender.value)*100)
            if ((sodiumContentResult*0.02*1)-1) < 0 {
                sodiumVal.text = "0 mg/cal - \(String(format: "%.0f", (sodiumContentResult*0.02*1)+1)) mg/cal"
            }
            else {
                sodiumVal.text = "\(String(format: "%.0f", (sodiumContentResult*0.02*1)-1)) mg/cal - \(String(format: "%.0f", (sodiumContentResult*0.02*1)+1)) mg/cal"
            }
            
        }
        else if sender == condSodiumSlider {
            condSodiumContentResult = round(Double(sender.value)*100)
            if ((condSodiumContentResult*0.02*2)-2) < 0 {
                condSodiumVal.text = "0 mg/cal - \(String(format: "%.0f", (condSodiumContentResult*0.02*2)+2)) mg/cal"
            }
            else {
                condSodiumVal.text = "\(String(format: "%.0f", (condSodiumContentResult*0.02*2)-2)) mg/cal - \(String(format: "%.0f", (condSodiumContentResult*0.02*2)+2)) mg/cal"
            }
        }
        else if sender == fiberSlider {
            fiberContentResult = round(Double(sender.value)*100)
            if ((fiberContentResult*0.02*2)-1) < 0 {
                fiberVal.text = "0 g - \(String(format: "%.0f", (fiberContentResult*0.02*2)+1)) g per 100 cal"
            }
            else {
                fiberVal.text = "\(String(format: "%.0f", (fiberContentResult*0.02*2)-1)) g - \(String(format: "%.0f", (fiberContentResult*0.02*2)+1)) g per 100 cal"
            }
            
        }
//        else if sender == flourSlider {
//            floursResult = round(Double(sender.value)*100)
//            flourVal.text = String(format: "%.2f", floursResult)
//        }
//        else if sender == sugarSlider {
//            sugarsResult = round(Double(sender.value)*100)
//            sugarVal.text = String(format: "%.2f", sugarsResult)
//        }
        
        
    }
    
    /* Called whenever the reset button is pressed. Resets all global variables back to default state */
    @IBAction func resetPressed(_ sender: UIButton) {
        calorieDensityResult = 50
        totalFatResult = 50
        saturatedFatResult = 50
        cholesterolCountResult = 50
        sodiumContentResult = 50
        condSodiumContentResult = 50
        fiberContentResult = 50
        
        calorieSlider.value = Float(calorieDensityResult/100)
        totalFatSlider.value = Float(totalFatResult/100)
        satFatSlider.value = Float(saturatedFatResult/100)
        cholSlider.value = Float(cholesterolCountResult/100)
        sodiumSlider.value = Float(sodiumContentResult/100)
        condSodiumSlider.value = Float(condSodiumContentResult/100)
        fiberSlider.value = Float(fiberContentResult/100)
        
        
        /* Values are translate from 0-100 scale to whatever the specific test calls for. The selected value chooses the middle point of the range. */
        calorieVal.text = "\(String(format: "%.3f", (calorieDensityResult*0.02*1.25)-0.25)) cal/serving - \(String(format: "%.3f", (calorieDensityResult*0.02*1.25)+0.25)) cal/serving"
        totalFatVal.text = "\(String(format: "%.0f", ((totalFatResult*0.02*0.175)-0.025)*100))% - \(String(format: "%.0f", ((totalFatResult*0.02*0.175)+0.025)*100))%"
        satFatVal.text = "\(String(format: "%.0f", ((saturatedFatResult*0.02*0.06)-0.01)*100))% - \(String(format: "%.0f", ((saturatedFatResult*0.02*0.06)+0.01)*100))%"
        cholVal.text = "\(String(format: "%.0f", (cholesterolCountResult*0.02*12.5)-12.5))mg - \(String(format: "%.0f", (cholesterolCountResult*0.02*12.5)+12.5))mg"
        sodiumVal.text = "\(String(format: "%.0f", (sodiumContentResult*0.02*1)-1)) mg/cal - \(String(format: "%.0f", (sodiumContentResult*0.02*1)+1)) mg/cal"
        condSodiumVal.text = "\(String(format: "%.0f", (condSodiumContentResult*0.02*2)-2)) mg/cal - \(String(format: "%.0f", (condSodiumContentResult*0.02*2)+2)) mg/cal"
        fiberVal.text = "\(String(format: "%.0f", (fiberContentResult*0.02*2)-1)) g - \(String(format: "%.0f", (fiberContentResult*0.02*2)+1)) g per 100 cal"
    }
    
    /* Called when the settings are dismissed. Stores the global variables to their place in UserDefaults to be saved across sessions */
    @IBAction func buttonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(calorieDensityResult, forKey:"calorieDensity")
        UserDefaults.standard.set(totalFatResult, forKey:"totalFat")
        UserDefaults.standard.set(saturatedFatResult, forKey:"saturatedFat")
        UserDefaults.standard.set(cholesterolCountResult, forKey:"cholesterolContent")
        UserDefaults.standard.set(sodiumContentResult, forKey:"sodiumContent")
        UserDefaults.standard.set(condSodiumContentResult, forKey:"condSodiumContent")
        UserDefaults.standard.set(fiberContentResult, forKey:"fiberContent")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}
