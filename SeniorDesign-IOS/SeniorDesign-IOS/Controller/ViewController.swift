//
//  ViewController.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 3/5/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* If it is the first time opening, UserDefault values are set to 50 (middle value and default) */
        if UserDefaults.standard.string(forKey: "firstOpen") == nil {
            UserDefaults.standard.set("", forKey: "firstOpen")
            UserDefaults.standard.set(50, forKey: "calorieDensity")
            UserDefaults.standard.set(50, forKey: "totalFat")
            UserDefaults.standard.set(50, forKey: "saturatedFat")
//            UserDefaults.standard.set(50, forKey: "transFat")
            UserDefaults.standard.set(50, forKey: "cholesterolContent")
            UserDefaults.standard.set(50, forKey: "sodiumContent")
            UserDefaults.standard.set(50, forKey: "condSodiumContent")
            UserDefaults.standard.set(50, forKey: "fiberContent")
//            UserDefaults.standard.set(50, forKey: "flours")
//            UserDefaults.standard.set(50, forKey: "sugars")
        }

    
    }
    
    /* These actions determine which ViewController to move to based on the button pressed */
    @IBAction func scanButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToScan", sender: self)
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSearch", sender: self)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSettings", sender: self)
    }
    
}

