//
//  FoodData.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 3/25/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//

import Foundation


struct FoodData: Codable {
    let totalHits: Int
    let currentPage: Int
    let totalPages: Int
    let foods: [Foods]
}

struct Foods: Codable {
    let fdcId: Int
    let description: String
    let dataType: String
    let publishedDate: String
    let gtinUpc: String?
    let brandOwner: String?
    let additionalDescriptions: String?
    
}
