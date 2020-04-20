//
//  BarCodeDetectorViewController.swift
//  SeniorDesign-IOS
//
//  Created by Senior Design  on 3/6/20.
//  Copyright © 2020 Riley Wagner. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Firebase

class BarCodeDetectorViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    let captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var barCodeFrameView: UIView? // for Extra credit section 3
    var initialized = false
    var retry = 0
    var foodManager = FoodManager()
    var itemUpc = ""
    var fdcId = 0
    
    let barCodeTypes = [AVMetadataObject.ObjectType.upce,
                        AVMetadataObject.ObjectType.code39,
                        AVMetadataObject.ObjectType.code39Mod43,
                        AVMetadataObject.ObjectType.code93,
                        AVMetadataObject.ObjectType.code128,
                        AVMetadataObject.ObjectType.ean8,
                        AVMetadataObject.ObjectType.ean13,
                        AVMetadataObject.ObjectType.aztec,
                        AVMetadataObject.ObjectType.pdf417,
                        AVMetadataObject.ObjectType.itf14,
                        AVMetadataObject.ObjectType.dataMatrix,
                        AVMetadataObject.ObjectType.interleaved2of5,
                        AVMetadataObject.ObjectType.qr]
    
    let alert = UIAlertController(title: "No Camera Found", message: "A valid camera for scanning barcodes was not found", preferredStyle: .alert)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        if AVCaptureDevice.default(for: AVMediaType.video) == nil {
            
            DispatchQueue.main.async {
                self.alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default,  handler: { _ in NSLog("The \"OK\" alert occured.")
                    }))
                self.present(self.alert, animated: true)
            }
        }
        else {
            foodManager.delegate = self
            openCamera()
        }
    }
    
    func openCamera() {
        
        var success = false
        //var accessDenied = false
        //var accessRequested = false
        if let barcodeFrameView = barCodeFrameView {
            barcodeFrameView.removeFromSuperview()
            self.barCodeFrameView = nil
        }
        
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authorizationStatus == .notDetermined {
           // accessRequested = true
            AVCaptureDevice.requestAccess(for: .video,
                                          completionHandler: { (granted:Bool) -> Void in
                                          self.openCamera();
            })
            return
        }
        if authorizationStatus == .restricted || authorizationStatus == .denied {
         //   accessDenied = true
        }
        
        if initialized {
            success = true
        }
        else {
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInTelephotoCamera, .builtInDualCamera], mediaType: AVMediaType.video, position: .unspecified)
            
            if let captureDevice = deviceDiscoverySession.devices.first {
                do {
                    let videoInput = try AVCaptureDeviceInput(device: captureDevice)
                    captureSession.addInput(videoInput)
                    success = true
                } catch{
                    NSLog("Can not find capture device input")
                }
            }
            else {
                NSLog("Cannot find a capture device")
            }
            
            if success {
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                let newSerialQueue = DispatchQueue(label: "barCodeScannerQueue")
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: newSerialQueue)
                captureMetadataOutput.metadataObjectTypes = barCodeTypes
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = imageView.layer.bounds
                imageView.layer.addSublayer(videoPreviewLayer!)
                initialized = true
            }
        }
        
        captureSession.startRunning()


    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject],
                 from connection: AVCaptureConnection) {
        processBarCodeData(metadataObjects: metadataObjects)
    }
    
    func processBarCodeData(metadataObjects: [AVMetadataObject]) {

        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if barCodeTypes.contains(metadataObject.type) {
                // If the found metadata is equal to the QR code metadata (or barcode) then update the status label's text and set the bounds
                
                if metadataObject.stringValue != nil {
                    DispatchQueue.main.async {
                        self.captureSession.stopRunning()
                        print(metadataObject.stringValue!)
                        self.itemUpc = metadataObject.stringValue!
                        self.itemUpc.remove(at: self.itemUpc.startIndex)
                        print(self.itemUpc)
                        self.foodManager.fetchFoodList(generalSearchInput: self.itemUpc, requireAllWords: "true", pageNumber: "", sortField: "", sortDirection: "")
                    }
                    // because there might be more bar codes detected, we return from the loop early
                    // here so we do not process more than one
                    return
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailViewController {
            if fdcId != 0 {
                let vc = segue.destination as? DetailViewController
                print(self.fdcId)
                vc?.fdcId = self.fdcId
                vc?.vc = self
            }
            else{
                print("No food found")
            }
        }
    }
    
}

extension BarCodeDetectorViewController: FoodManagerDelegate {
    
    func didFailWithError(error: Error) {
        print(error)
    }
    func didUpdateFoods(_ foodManager: FoodManager, foods: FoodModel) {
        if foods.foodsArray.isEmpty && retry != 1 {
            print("Food not found, trying again with altered UPC")
            retry = 1
            let revisedUpc = "00\(self.itemUpc)"
            self.foodManager.fetchFoodList(generalSearchInput: revisedUpc, requireAllWords: "true", pageNumber: "", sortField: "", sortDirection: "")
        }
        else if !foods.foodsArray.isEmpty {
            print(foods.foodsArray[0])
            self.fdcId = foods.foodsArray[0].fdcId
            DispatchQueue.main.async{
                self.performSegue(withIdentifier: "goToDetailFromScanner", sender: self)
            }
        }
        else{
            print("Food Not in Database")
            let foodAlert = UIAlertController(title: "No Camera Found", message: "The food was not found in the database", preferredStyle: .alert)
            DispatchQueue.main.async {
                foodAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default,  handler: { _ in self.dismiss(animated: true, completion: nil)
                    }))
                self.present(foodAlert, animated: true)
                //self.dismiss(animated: true, completion: nil)
            }
        }
    }
    func didCreateDetail(_ foodManager: FoodManager, detail: DetailModel) {
    }

}

