//
//  SurveyButton.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 4/20/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//

import Foundation
import UIKit

class SurveyButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .systemBlue
        titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15)
        layer.cornerRadius = 5
        
    }
    
    
    
    
}
