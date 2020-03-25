//
//  ViewController.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 3/5/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func scanButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToScan", sender: self)
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSearch", sender: self)
    }
    

}

