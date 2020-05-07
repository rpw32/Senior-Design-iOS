//
//  FoodManager.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 3/25/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//

import Foundation

protocol FoodManagerDelegate {
    func didUpdateFoods(_ foodManager: FoodManager, foods: FoodModel)
    func didCreateDetail(_ foodManager: FoodManager, detail: DetailModel)
    func didFailWithError(error: Error)
}

struct FoodManager {
    var requestType = 0 //Type is 0 for food list request, and 1 for detail request
    let foodURL = "https://api.nal.usda.gov/fdc/v1/search?api_key=BL2Ukd4QaZD2OXHr2ZCFZyqEph957r1NoQTWxV6x"
    let detailURL = "https://api.nal.usda.gov/fdc/v1/"
    let apikey = "?api_key=BL2Ukd4QaZD2OXHr2ZCFZyqEph957r1NoQTWxV6x"
    
    var delegate: FoodManagerDelegate?
    
    mutating func fetchFoodList(generalSearchInput: String, requireAllWords: String, pageNumber: String, sortField: String, sortDirection: String) {
        requestType = 0
        let searchSplit = generalSearchInput.split(separator: " ")
        var searchString = ""
        for i in searchSplit{
            searchString.append("+\(i)%20")
        }
        print(searchString)
        let urlString = "\(foodURL)&generalSearchInput=\(searchString)&requireAllWords=\(requireAllWords)&pageNumber=\(pageNumber)&sortField=\(sortField)&sortDirection=\(sortDirection)"
        performRequest(request: requestType, with: urlString)
    }
    
    mutating func fetchFoodDetail(fdcId: Int) {
        requestType = 1
        let urlString = "\(detailURL)\(fdcId)\(apikey)"
        performRequest(request: requestType, with: urlString)
    }
    
    func performRequest(request: Int, with urlString: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if self.requestType == 0 {
                    if let safeData = data {
                        if let foods = self.parseJSON(safeData) {
                            self.delegate?.didUpdateFoods(self, foods: foods)
                        }
                    }
                } else {
                    if let safeData = data {
                        if let detail = self.parseJSONDetail(safeData) {
                            self.delegate?.didCreateDetail(self, detail: detail)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ requestData: Data) -> FoodModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(FoodData.self, from: requestData)
            let totalHits = decodedData.totalHits
            let currentPage = decodedData.currentPage
            let totalPages = decodedData.totalPages
            let foodsArray = decodedData.foods
            let foods = FoodModel(totalHits: totalHits, currentPage: currentPage, totalPages: totalPages, foodsArray: foodsArray)
            return foods
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseJSONDetail(_ requestData: Data) -> DetailModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DetailData.self, from: requestData)
            let foodClass = decodedData.foodClass
            let description = decodedData.description
            let foodNutrients = decodedData.foodNutrients
            let brandOwner = decodedData.brandOwner
            let ingredients = decodedData.ingredients
            let servingSize = decodedData.servingSize
            let servingSizeUnit = decodedData.servingSizeUnit
            let foodPortions = decodedData.foodPortions
            let foodCategory = decodedData.brandedFoodCategory
            let detail = DetailModel(foodClass, description, foodNutrients, brandOwner, ingredients, servingSize, servingSizeUnit, foodPortions, foodCategory)
            return detail
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
