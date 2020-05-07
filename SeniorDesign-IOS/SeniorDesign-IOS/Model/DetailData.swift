//
//  DetailData.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 3/31/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//

import Foundation

struct DetailData: Codable {
    let foodClass: String
    let description: String
    let foodNutrients: [FoodNutrients]
    let brandOwner: String?
    let ingredients: String?
    let servingSize: Float?
    let servingSizeUnit: String?
    let foodPortions: [FoodPortions]?
    let brandedFoodCategory: String?
}

struct FoodNutrients: Codable {
    let nutrient: Nutrient
    let amount: Float
}

struct Nutrient: Codable {
    let id: Int
    let number: String
    let name: String
    let rank: Int
    let unitName: String
}

struct FoodPortions: Codable {
    let portionDescription: String
    let sequenceNumber: Int
    let gramWeight: Float
}
