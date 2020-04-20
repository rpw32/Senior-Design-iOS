//
//  DetailModel.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 3/31/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//

import Foundation


struct DetailModel {
    let foodClass: String
    let description: String
    let foodNutrients: [FoodNutrients]
    let brandOwner: String?
    let ingredients: String?
    let servingSize: Float?
    let servingSizeUnit: String?
    let foodPortions: [FoodPortions]?
    let foodCategory: WweiaFoodCategory?
    
    init() {
        self.foodClass = ""
        self.description = ""
        self.foodNutrients = [FoodNutrients.init(nutrient: Nutrient.init(id: 0, number: "", name: "", rank: 0, unitName: ""), amount: 0)]
        self.brandOwner = nil
        self.ingredients = nil
        self.servingSize = nil
        self.servingSizeUnit = nil
        self.foodPortions = nil
        self.foodCategory = nil
    }
    
    init(_ foodClass: String, _ description: String, _ foodNutrients: [FoodNutrients], _ brandOwner: String?, _ ingredients: String?, _ servingSize: Float?, _ servingSizeUnit: String?, _ foodPortions: [FoodPortions]?, _ foodCategory: WweiaFoodCategory?) {
        self.foodClass = foodClass
        self.description = description
        self.foodNutrients = foodNutrients
        self.brandOwner = brandOwner
        self.ingredients = ingredients
        self.servingSize = servingSize
        self.servingSizeUnit = servingSizeUnit
        self.foodPortions = foodPortions
        self.foodCategory = foodCategory
    }
}

struct NutrientData {
    var calories: Float
    var fat: Float
    var saturatedFat: Float
    var transFat: Float
    var cholesterol: Float
    var sodium: Float
    var carbohydrates: Float
    var fiber: Float
    var sugars: Float
    var protein: Float
    var vitaminD: Float
    var calcium: Float
    var iron: Float
    var potassium: Float
    var vitaminA: Float
    var vitaminC: Float
    
    init() {
        self.calories = 0.0
        self.fat = 0.0
        self.saturatedFat = 0.0
        self.transFat = 0.0
        self.cholesterol = 0.0
        self.sodium = 0.0
        self.carbohydrates = 0.0
        self.fiber = 0.0
        self.sugars = 0.0
        self.protein = 0.0
        self.vitaminD = 0.0
        self.calcium = 0.0
        self.iron = 0.0
        self.potassium = 0.0
        self.vitaminA = 0.0
        self.vitaminC = 0.0
    }
    
    init(_ calories: Float, _ fat: Float, _ saturatedFat: Float, _ transFat: Float, _ cholesterol: Float, _ sodium: Float, _ carbohydrates: Float, _ fiber: Float, _ sugars: Float, _ protein: Float, _ vitaminD: Float, _ calcium: Float, _ iron: Float, _ potassium: Float, _ vitaminA: Float, _ vitaminC: Float) {
        self.calories = calories
        self.fat = fat
        self.saturatedFat = saturatedFat
        self.transFat = transFat
        self.cholesterol = cholesterol
        self.sodium = sodium
        self.carbohydrates = carbohydrates
        self.fiber = fiber
        self.sugars = sugars
        self.protein = protein
        self.vitaminD = vitaminD
        self.calcium = calcium
        self.iron = iron
        self.potassium = potassium
        self.vitaminA = vitaminA
        self.vitaminC = vitaminC
    }
    
    
}
