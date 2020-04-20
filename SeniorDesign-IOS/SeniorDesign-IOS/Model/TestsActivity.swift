//
//  TestsActivity.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 4/18/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//

import Foundation

class TestsActivity {
    
    typealias Result = (result:String, code:Int)
    
    func calorieDensity(_ calories: Double, _ servingSize: Double?) -> Result {
        let testValue: Double = UserDefaults.standard.double(forKey: "calorieDensity") * 0.02 * 1.25

        var testResult = ""
        var testRating = -1
        var density: Double = 0.0
        if let tempServing = servingSize {
            density = calories / tempServing
        }

        if (density <= (testValue - 0.25)) {
            testResult = "Calorie Density: \(String(format: "%.2f", density)) cal/serving"
            testRating = 2
        }
        else if ((density > (testValue - 0.25)) && (density <= (testValue + 0.25))) {
            testResult = "Calorie Density: \(String(format: "%.2f", density)) cal/serving"
            testRating = 1
        }
        else {
            testResult = "Calorie Density: \(String(format: "%.2f", density)) cal/serving"
            testRating = 0
        }
        if((testRating == -1) || (testResult == "")){
            // error: no rating given
        }
        
        let pair: Result = (testResult, testRating)
        return pair
    }
    
    func totalFat(_ calories: Double, _ fat: Double) -> Result {
        let testValue = /*settingValue * */50 * 0.02 * 0.175

        var testResult = ""
        var testRating = -1
        let fatComp = (fat * 9) / calories        // There are 9 calories per gram of fat
        let fatCompPerc = fatComp * 100


        if((fatComp < 0) || (fatComp > 1)){             // Database error, negative fat composition is impossible

        }
        else if((fatComp <= (testValue - 0.025))) {
           testResult = "Total Fat Composition: \(String(format: "%.2f", fatCompPerc))%"
           testRating = 2
        }
        else if((fatComp > (testValue - 0.025)) && (fatComp <= (testValue + 0.025))){
           testResult = "Total Fat Composition: \(String(format: "%.2f", fatCompPerc))%"
           testRating = 1
        }
        else {
           testResult = "Total Fat Composition: \(String(format: "%.2f", fatCompPerc))%"
           testRating = 0
        }
        if((testRating == -1) || (testResult == "")){
           // check to see if a rating has been given
        }
        
        let pair: Result = (testResult, testRating)
        return pair
    }
    
    func saturatedFat(_ calories: Double, _ satFat: Double) -> Result {
        let testValue = /*settingValue * */ 50 * 0.02 * 0.06

        var testResult = ""
        let satFatComp = (satFat * 9) / calories               //fat is 9 cals/g. This calculates Saturated Fat composition
        let satFatCompPerc = satFatComp*100
        var testRating = -1

        if((satFatComp < 0) || (satFatComp > 1)){                    // Database error, negative fat composition is impossible

        }
        else if((satFatComp <= (testValue - 0.01))) {
            testResult = "Saturated Fat Composition: \(String(format: "%.2f", satFatCompPerc))%"
            testRating = 2
        }
        else if((satFatComp > (testValue - 0.01)) && (satFatComp <= (testValue + 0.01))){
            testResult = "Saturated Fat Composition: \(String(format: "%.2f", satFatCompPerc))%"
            testRating = 1
        }
        else {
            testResult = "Saturated Fat Composition: \(String(format: "%.2f", satFatCompPerc))%"
            testRating = 0
        }
        if((testRating == -1) || (testResult == "")){
            // check to see if a rating has been given
        }
        
        let pair: Result = (testResult, testRating)
        return pair
    }
    
    func transFat(_ transFats: Double, _ ingredients: String?) -> Result {

        var testResult = ""
        var testRating = -1

        if let myIngredients = ingredients {
            if ((myIngredients.contains("hydrogenated")) || (transFats > 0.0)){
                    testResult = "This food may have hydrogenated oils which contain trans fats."
                    testRating = 0
                }
            else {
                    testResult = "This food does not contain any trans fats."
                    testRating = 2
                }
        }

        if((testRating == -1) || (testResult == "")){
            //error: no rating given
        }
        
        let pair: Result = (testResult, testRating)
        return pair
    }
    
    func cholesterolContent(_ cholesterol: Double) -> Result {
        let testValue = /*settingValue * */50 * 0.02 * 12.5;

        var testResult = ""
        var testRating = -1

        if(cholesterol > (testValue + 12.5)){
            testResult = "Cholesterol: \(String(format: "%.2f", cholesterol)) mg"
            testRating = 0
        }
        else if(cholesterol <= (testValue + 12.5) && (cholesterol > (testValue - 12.5))){
            testResult = "Cholesterol: \(String(format: "%.2f", cholesterol)) mg"
            testRating = 1
        }
        else if(cholesterol <= (testValue - 12.5)){
            testResult = "Cholesterol: \(String(format: "%.2f", cholesterol)) mg"
            testRating = 2
        }
        
        if((testRating == -1) || (testResult == "")){
            //error: no rating given
        }
        
        let pair: Result = (testResult, testRating)
        return pair
    }
    
    func sodiumContent(_ calories: Double, _ sodium: Double, _ category: String?) -> Result {
        let testValue = /* settingValue * */50 * 0.02 * 1
        let condTestValue = /* condSettingValue * */50 * 0.02 * 2

        var testResult = ""
        var testRating = -1
        let sodiumToCaloriesRatio = sodium/calories

        if let myCategory = category{
            if (myCategory.contains("Ketchup, Mustard, BBQ & Cheese Sauce") || myCategory.contains("Salad Dressing & Mayonnaise") || myCategory.contains("Gravy Mix")) {
                if (sodiumToCaloriesRatio <= (condTestValue - 2)) {
                    testResult = "Condiment Sodium to Calorie Ratio: \(String(format: "%.2f", sodiumToCaloriesRatio)) mg/cal"
                    testRating = 2
                }
                else if (sodiumToCaloriesRatio >= (condTestValue - 2) && sodiumToCaloriesRatio <= (condTestValue + 2)) {
                    testResult = "Condiment Sodium to Calorie Ratio: \(String(format: "%.2f", sodiumToCaloriesRatio)) mg/cal"
                    testRating = 1
                }
                else if (sodiumToCaloriesRatio > (condTestValue + 2)) {
                    testResult = "Condiment Sodium to Calorie Ratio: \(String(format: "%.2f", sodiumToCaloriesRatio)) mg/cal"
                    testRating = 0
                }
            }}
            else {
                if (sodiumToCaloriesRatio <= (testValue - 1)) {
                    testResult = "Sodium to Calorie Ratio: \(String(format: "%.2f", sodiumToCaloriesRatio)) mg/cal"
                    testRating = 2
                }
                else if (sodiumToCaloriesRatio >= (testValue - 1) && sodiumToCaloriesRatio <= (testValue + 1)) {
                    testResult = "Sodium to Calorie Ratio: \(String(format: "%.2f", sodiumToCaloriesRatio)) mg/cal"
                    testRating = 1
                }
                else if (sodiumToCaloriesRatio > (testValue + 1)) {
                    testResult = "Sodium to Calorie Ratio: \(String(format: "%.2f", sodiumToCaloriesRatio)) mg/cal"
                    testRating = 0
                }
            }
        

        if((testRating == -1) || (testResult == "")){
            // error: no rating given
        }
        
        let pair: Result = (testResult, testRating)
        return pair
    }
    
    func fiberContent(_ calories: Double, _ fiber: Double) -> Result {
        let testValue = /* settingValue * */50 * 0.02 * 2

        let fiberToCalorieRatio = (fiber/calories) * 100
        var testResult = ""
        var testRating = -1

        if(fiberToCalorieRatio >= (testValue + 1)){
            testResult = "Fiber to Calorie Ratio: \(String(format: "%.2f", fiberToCalorieRatio))g per 100 cal"
            testRating = 2
        }
        else if(fiberToCalorieRatio >= (testValue - 1) && (fiberToCalorieRatio <= (testValue + 1))) {
            testResult = "Fiber to Calorie Ratio: \(String(format: "%.2f", fiberToCalorieRatio))g per 100 cal"
            testRating = 1
        }
        else if(fiberToCalorieRatio < (testValue - 1)){
            testResult = "Fiber to Calorie Ratio: \(String(format: "%.2f", fiberToCalorieRatio))g per 100 cal"
            testRating = 0
        }
        if((testRating == -1) || (testResult == "")){
            // error: no rating given
        }
        
        let pair: Result = (testResult, testRating)
        return pair
    }
    
    func flours(_ ingredients: String?) -> Result {
        let badflours = ["white","wheat","durum", "semolina","bleached", "unbleached"]
        let goodflours = ["whole","rolled","cracked","sprouted","stone ground"]
        var testResult = ""
        var testRating = -1
        var bad = false
        var goodf = false

        if let myIngredients = ingredients {
            for i in badflours{
                if((myIngredients.range(of: i, options: .caseInsensitive)) != nil){
                    bad = true
                }
            }
            for i in goodflours{
                if((myIngredients.range(of: i, options: .caseInsensitive)) != nil){
                    goodf = true
                }
            }
        }

        if(goodf && bad){
            testRating = 1
            testResult = "This food contains good and bad flours."
        }
        else if(goodf && !bad) {
            testRating = 2
            testResult = "This food contains good flours or grains."
        }
        else if(bad){
            testRating = 0
            testResult = "This food contains bad flours or grains."
        }
        else{
            testRating = 2
            testResult = "This food does not contain flours or grains."

        }
        let pair: Result = (testResult, testRating)
        return pair
    }
    
    func sugars(_ ingredients: String?) -> Result {
        let badsug = ["sugar","brown sugar","raw sugar","honey","agave syrup"]
        var testResult = ""
        var testRating = -1
        var bad = false


        if let myIngredients = ingredients {
            for i in badsug{
                if((myIngredients.range(of: i, options: .caseInsensitive)) != nil){
                    bad = true
                }
            }
            let temp_ingr = myIngredients.components(separatedBy: " ")
            for i in temp_ingr{
                if(i.hasSuffix("ose") || i.hasSuffix("ol")){
                    bad = true
                }
            }
        }

        if(bad){
            testRating = 0
            testResult = "This food contains added sugars."
        }
        else{
            testRating = 2
            testResult = "This food does not contain added sugars."
        }
        let pair: Result = (testResult, testRating)
        return pair
    }
    
    
    
    
}
