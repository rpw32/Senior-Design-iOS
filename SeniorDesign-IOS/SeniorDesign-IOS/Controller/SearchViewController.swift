//
//  SearchViewController.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 3/19/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    let alert = UIAlertController(title: "No Results Found", message: "Please try searching with different keywords", preferredStyle: .alert)
    var labels = [UILabel]()
    var foodInput = ""
    var detailId = 0
    var requestedPage = 1
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var contentView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var foodManager = FoodManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default,  handler: { _ in NSLog("The \"OK\" alert occured.")
            }))
        
        scrollView.delegate = self
        foodManager.delegate = self
        searchField.delegate = self
    }
    
    func resetStack() {
        for view in contentView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
    }
    
}

//MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter a food to search"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            self.resetStack()
        }
        if let foodInput = searchField.text {
            self.foodInput = foodInput
            foodManager.fetchFoodList(generalSearchInput: foodInput, requireAllWords: "true", pageNumber: String(requestedPage), sortField: "", sortDirection: "")
        }
    }
}

//MARK: - FoodManagerDelegate

extension SearchViewController: FoodManagerDelegate, UIScrollViewDelegate {
    func didCreateDetail(_ foodManager: FoodManager, detail: DetailModel) {
    }
    
    
    func didUpdateFoods(_ foodManager: FoodManager, foods: FoodModel) {
        DispatchQueue.main.async {
            
            self.labels.removeAll()
            let topLabel = UILabel()
            topLabel.numberOfLines = 3
            topLabel.text = "Total Hits: \(foods.totalHits)\nCurrent Page: \(foods.currentPage)\nTotal Pages: \(foods.totalPages)"
            self.contentView.addArrangedSubview(topLabel)
            
            if foods.currentPage < foods.totalPages {
                if foods.totalHits >= 50 {
                    for l in 0...49 {
                        self.addFoodToList(l: l, foods: foods)
                    }
                } else if foods.totalHits > 0 {
                    for l in 0...foods.totalHits-1 {
                        self.addFoodToList(l: l, foods: foods)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default,  handler: { _ in NSLog("The \"OK\" alert occured.")
                            }))
                        self.present(self.alert, animated: true)
                    }
                }
            }
            else {
                if foods.totalHits > 0 {
                    for l in 0...(foods.totalHits-((foods.totalPages-1)*50)-1) {
                        self.addFoodToList(l: l, foods: foods)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.present(self.alert, animated: true)
                    }
                }
            }
            
            if foods.totalPages > 1 {
                if foods.currentPage < foods.totalPages {
                    let nextButton = SurveyButton()
                    nextButton.setTitle("Next Page", for: .normal)
                    nextButton.addTarget(self, action: #selector(self.pressButton), for: .touchUpInside)
                    self.contentView.addArrangedSubview(nextButton)
                }
                if ((foods.currentPage > 1) && (foods.currentPage <= foods.totalPages)) {
                    let previousButton = SurveyButton()
                    previousButton.setTitle("Previous Page", for: .normal)
                    previousButton.addTarget(self, action: #selector(self.pressButton), for: .touchUpInside)
                    self.contentView.addArrangedSubview(previousButton)
                }
            }
            
        }
    }
    
    @objc func pressButton(button: UIButton) {
        if button.titleLabel?.text == "Next Page" {
            self.requestedPage += 1
        }
        else {
            self.requestedPage -= 1
        }
        resetStack()
        self.foodManager.fetchFoodList(generalSearchInput: self.foodInput, requireAllWords: "true", pageNumber: String(self.requestedPage), sortField: "publishedDate", sortDirection: "asc")
    }
    
    func addFoodToList(l: Int, foods: FoodModel) {
        let label = UILabel()
        var numLines = 3
        let description = foods.foodsArray[l].description
        let additionalDescription = foods.foodsArray[l].additionalDescriptions ?? nil
        let type = foods.foodsArray[l].dataType
        let upc = foods.foodsArray[l].gtinUpc ?? nil
        let brandOwner = foods.foodsArray[l].brandOwner ?? nil
        
        var labelString = "Result: \(((requestedPage-1)*50)+l+1)\nDescription: \(description)\n"
        if additionalDescription != nil{
            numLines+=1
            labelString += "Additional Description: \(additionalDescription!)\n"
        }
        labelString += "Type: \(type)\n"
        if upc != nil{
            numLines+=1
            labelString += "UPC: \(upc!)\n"
        }
        if brandOwner != nil {
            numLines+=1
            labelString += "Brand Owner: \(brandOwner!)"
        }
        label.numberOfLines = numLines
        label.text = labelString
        
        label.isUserInteractionEnabled = true
        let tapGesture = MyTapGesture.init(target: self, action: #selector(clickLabel))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.resultNum = foods.foodsArray[l].fdcId
        label.addGestureRecognizer(tapGesture)
        
        
        self.labels.append(label)
        self.contentView.addArrangedSubview(self.labels[l])
    }
    
    @objc func clickLabel(sender: MyTapGesture) {
        print(sender.resultNum)
        detailId = sender.resultNum
        foodManager.delegate = DetailViewController()
        self.performSegue(withIdentifier: "goToDetailFromSearch", sender: self)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailViewController {
            print("preparing")
            let vc = segue.destination as? DetailViewController
            vc?.fdcId = detailId
            vc?.vc = self
        }
    }
    
}

class MyTapGesture: UITapGestureRecognizer {
    var resultNum = 0
}
