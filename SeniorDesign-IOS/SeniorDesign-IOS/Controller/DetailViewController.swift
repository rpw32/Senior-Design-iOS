//
//  DetailViewController.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 3/31/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//

import Foundation
import UIKit


class DetailViewController: UIViewController {
    

    @IBOutlet weak var portionField: UITextField!
    @IBOutlet weak var servingsField: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIStackView!
    
    typealias Result = (String,Int)
    
    var calorieDensityResult: Result = ("", -1)
    var totalFatResult: Result = ("", -1)
    var saturatedFatResult: Result = ("", -1)
    var transFatResult: Result = ("", -1)
    var cholesterolCountResult: Result = ("", -1)
    var sodiumContentResult: Result = ("", -1)
    var fiberContentResult: Result = ("", -1)
    var floursResult: Result = ("", -1)
    var sugarsResult: Result = ("", -1)
    
    
    
    var foodManager = FoodManager()
    var fdcId = 0
    var update = 0
    var tests = TestsActivity()
    var nutrientData = NutrientData()
    var detail = DetailModel()
    var vc = UIViewController()
    var servingsSelection = 0.0
    var servingSize: Float = 0.0
    var pickerRow = 0
    var portions = [""]
    var pickerView = UIPickerView()
    var ingredients = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        foodManager.delegate = self
        
        foodManager.fetchFoodDetail(fdcId: fdcId)
    }
    
    func resetStack() {
        for view in contentView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
    }
    @IBAction func stepperChange(_ sender: UIStepper) {
        servingsField.text = String(format: "%.0f", sender.value)
        servingsSelection = sender.value
        update = 1
        foodManager.fetchFoodDetail(fdcId: fdcId)
        
    }
    @IBAction func ingredientsPressed(_ sender: UIButton) {
        let ingredientAlert = UIAlertController(title: "Ingredients", message: "\(ingredients)", preferredStyle: .alert)
        DispatchQueue.main.async {
            ingredientAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default,  handler: nil))
            self.present(ingredientAlert, animated: true)
            //self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func nutritionPressed(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "nutritionPopup", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TestsViewController {
            let resultsArray = [calorieDensityResult, totalFatResult, saturatedFatResult, transFatResult, cholesterolCountResult, sodiumContentResult, fiberContentResult, floursResult, sugarsResult]
            let vc = segue.destination as? TestsViewController
            vc?.resultsArray = resultsArray
            vc?.vc = self
        }
    }
    
    
}

//MARK: - FoodManagerDelegate
extension DetailViewController: FoodManagerDelegate, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return portions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return portions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        portionField.text = portions[row]
        update = 1
        pickerRow = row
        foodManager.fetchFoodDetail(fdcId: fdcId)
    }
    
    func didUpdateFoods(_ foodManager: FoodManager, foods: FoodModel) {
    }
    
    func didCreateDetail(_ foodManager: FoodManager, detail: DetailModel) {
        self.detail = detail
        DispatchQueue.main.async {
            self.resetStack()
            
            if self.update == 0 {
                if !(detail.foodPortions?.isEmpty ?? false) {
                    self.portionField.placeholder = detail.foodPortions?[0].portionDescription
                    for p in detail.foodPortions! {
                        self.portions.append("\(p.portionDescription) (\(p.gramWeight)g)")
                    }
                    self.portions.removeFirst()
                    self.portions.removeLast()
                    self.servingSize = detail.foodPortions![0].gramWeight
                } else {
                    let servingSize = String(format: "%.2f", detail.servingSize ?? "None")
                    self.portionField.text = "\(servingSize)\(detail.servingSizeUnit ?? "units")"
                    self.portionField.isEnabled = false
                    self.servingSize = detail.servingSize!
                }
                
                self.ingredients = detail.ingredients ?? "No Ingredients Found"

                self.pickerView.delegate = self
                self.pickerView.dataSource = self
                self.portionField.textAlignment = .center
                self.portionField.inputView = self.pickerView
                self.servingsSelection = 1
                
                self.foodName.text = detail.description
            }
            
            if !(detail.foodPortions?.isEmpty ?? false) {
                self.servingSize = detail.foodPortions![self.pickerRow].gramWeight
            }
            
            
            self.addNutrients(self.detail)
            self.printNutrients(self.nutrientData, self.detail)
            
            self.calorieDensityResult = self.tests.calorieDensity(Double((self.nutrientData.calories/100)*self.servingSize), Double(self.servingSize))
            self.totalFatResult = self.tests.totalFat(Double((self.nutrientData.calories/100)*self.servingSize), Double((self.nutrientData.fat/100)*self.servingSize))
            self.saturatedFatResult = self.tests.saturatedFat(Double((self.nutrientData.calories/100)*self.servingSize), Double((self.nutrientData.saturatedFat/100)*self.servingSize))
            self.transFatResult = self.tests.transFat(Double((self.nutrientData.transFat/100)*self.servingSize), self.detail.ingredients)
            self.cholesterolCountResult = self.tests.cholesterolContent(Double((self.nutrientData.cholesterol/100)*self.servingSize))
            self.sodiumContentResult = self.tests.sodiumContent(Double((self.nutrientData.calories/100)*self.servingSize), Double((self.nutrientData.sodium/100)*self.servingSize), self.detail.foodCategory?.wweiaFoodCategoryDescription)
            self.fiberContentResult = self.tests.fiberContent(Double((self.nutrientData.calories/100)*self.servingSize), Double((self.nutrientData.fiber/100)*self.servingSize))
            self.floursResult = self.tests.flours(self.detail.ingredients)
            self.sugarsResult = self.tests.sugars(self.detail.ingredients)
            
            print(self.calorieDensityResult)
            print(self.totalFatResult)
            print(self.saturatedFatResult)
            print(self.transFatResult)
            print(self.cholesterolCountResult)
            print(self.sodiumContentResult)
            print(self.fiberContentResult)
            print(self.floursResult)
            print(self.sugarsResult)


        }

    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

    func addNutrients(_ detail: DetailModel){
        
        var calories: Float = 0.0
        var fat: Float = 0.0
        var saturatedFat: Float = 0.0
        var transFat: Float = 0.0
        var cholesterol: Float = 0.0
        var sodium: Float = 0.0
        var carbohydrates: Float = 0.0
        var fiber: Float = 0.0
        var sugars:Float = 0.0
        var protein: Float = 0.0
        var vitaminD: Float = 0.0
        var calcium: Float = 0.0
        var iron: Float = 0.0
        var potassium: Float = 0.0
        var vitaminA: Float = 0.0
        var vitaminC: Float = 0.0
        
        
        for i in detail.foodNutrients {
            switch (i.nutrient.id) {
            case 1087: calcium = i.amount
            case 1089: iron = i.amount
            case 1104: vitaminA = i.amount
            case 1162: vitaminC = i.amount
            case 1110: vitaminD = i.amount
            case 1092: potassium = i.amount
            case 1003: protein = i.amount
            case 1004: fat = i.amount
            case 1005: carbohydrates = i.amount
            case 1008: calories = i.amount
            case 2000: sugars = i.amount
            case 1079: fiber = i.amount
            case 1093: sodium = i.amount
            case 1253: cholesterol = i.amount
            case 1257: transFat = i.amount
            case 1258: saturatedFat = i.amount
            default:
                continue
            }
        }
        
        let data = NutrientData(calories, fat, saturatedFat, transFat, cholesterol, sodium, carbohydrates, fiber, sugars, protein, vitaminD, calcium, iron, potassium, vitaminA, vitaminC)
        self.nutrientData = data
        
    }
    
    func printNutrients(_ data: NutrientData, _ detail: DetailModel) {
        for i in 0...15 {
            let label = UILabel()
            switch (i) {
            case 0: label.text = "Calories: \(String(format: "%.2f", (data.calories/100)*Float(servingSize)*Float(servingsSelection))) kcal"
            case 1: label.text = "Fat: \(String(format: "%.2f", (data.fat/100)*Float(servingSize)*Float(servingsSelection))) g"
            case 2: label.text = "Saturated Fat: \(String(format: "%.2f", (data.saturatedFat/100)*Float(servingSize)*Float(servingsSelection))) g"
            case 3: label.text = "Trans Fat: \(String(format: "%.2f", (data.transFat/100)*Float(servingSize)*Float(servingsSelection))) g"
            case 4: label.text = "Cholesterol \(String(format: "%.2f", (data.cholesterol/100)*Float(servingSize)*Float(servingsSelection))) mg"
            case 5: label.text = "Sodium: \(String(format: "%.2f", (data.sodium/100)*Float(servingSize)*Float(servingsSelection))) mg"
            case 6: label.text = "Carbohydrates: \(String(format: "%.2f", (data.carbohydrates/100)*Float(servingSize)*Float(servingsSelection))) g"
            case 7: label.text = "Fiber: \(String(format: "%.2f", (data.fiber/100)*Float(servingSize)*Float(servingsSelection))) g"
            case 8: label.text = "Sugars: \(String(format: "%.2f", (data.sugars/100)*Float(servingSize)*Float(servingsSelection))) g"
            case 9: label.text = "Protein: \(String(format: "%.2f", (data.protein/100)*Float(servingSize)*Float(servingsSelection))) g"
            case 10: label.text = "Vitamin D: \(String(format: "%.2f", (data.vitaminD/100)*Float(servingSize)*Float(servingsSelection))) IU"
            case 11: label.text = "Calcium: \(String(format: "%.2f", (data.calcium/100)*Float(servingSize)*Float(servingsSelection))) mg"
            case 12: label.text = "Iron: \(String(format: "%.2f", (data.iron/100)*Float(servingSize)*Float(servingsSelection))) mg"
            case 13: label.text = "Potassium: \(String(format: "%.2f", (data.potassium/100)*Float(servingSize)*Float(servingsSelection))) mg"
            case 14: label.text = "Vitamin A: \(String(format: "%.2f", (data.vitaminA/100)*Float(servingSize)*Float(servingsSelection))) IU"
            case 15: label.text = "Vitamin C: \(String(format: "%.2f", (data.vitaminC/100)*Float(servingSize)*Float(servingsSelection))) IU"
            default:
                continue
            }
            
            self.contentView.addArrangedSubview(label)
        }
    }
}
