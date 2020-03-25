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

class BarCodeDetectorViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    let alert = UIAlertController(title: "No Camera Found", message: "A valid camera for scanning barcodes was not found", preferredStyle: .alert)
    
    @IBOutlet weak var imageView: UIImageView!
    
    let session = AVCaptureSession()
    lazy var vision = Vision.vision()
    var barcodeDetector: VisionBarcodeDetector?
    
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
            openCamera()
            self.barcodeDetector = vision.barcodeDetector()
        }
    }
    
    private func openCamera() {
                
        let session = AVCaptureSession()
        
        session.sessionPreset = AVCaptureSession.Preset.photo
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)

        let cameraPosition = AVCaptureDevice.Position.back  // Set to the capture device you used.
        let metadata = VisionImageMetadata()

        let defaultOrientation = VisionDetectorImageOrientation(rawValue: 0)!

        metadata.orientation = imageOrientation(
            deviceOrientation: UIDevice.current.orientation,
            cameraPosition: cameraPosition
            ) ?? defaultOrientation

        let deviceInput = try! AVCaptureDeviceInput(device: captureDevice!)
        let deviceOutput = AVCaptureVideoDataOutput()
        deviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
        session.addInput(deviceInput)
        session.addOutput(deviceOutput)

        let imageLayer = AVCaptureVideoPreviewLayer(session: session)
        imageLayer.frame = CGRect(x: 0, y: 0, width: self.imageView.frame.size.width + 100, height: self.imageView.frame.size.height)
        imageLayer.videoGravity = .resizeAspectFill
        imageView.layer.addSublayer(imageLayer)

        session.startRunning()
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        //set barcode detector formats
        let format = VisionBarcodeFormat.all
        let barcodeOptions = VisionBarcodeDetectorOptions(formats: format)
        
        let barcodeDetector = vision.barcodeDetector(options: barcodeOptions)
            
            let visionImage = VisionImage(buffer: sampleBuffer)
            
            barcodeDetector.detect(in: visionImage) { (barcodes, error) in

                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                for barcode in barcodes! {
                    print(barcode.rawValue!)
                }
            }
    }
    
    func imageOrientation(
        deviceOrientation: UIDeviceOrientation,
        cameraPosition: AVCaptureDevice.Position
        ) -> VisionDetectorImageOrientation? {
        switch deviceOrientation {
        case .portrait:
            return cameraPosition == .front ? .leftTop : .rightTop
        case .landscapeLeft:
            return cameraPosition == .front ? .bottomLeft : .topLeft
        case .portraitUpsideDown:
            return cameraPosition == .front ? .rightBottom : .leftBottom
        case .landscapeRight:
            return cameraPosition == .front ? .topRight : .bottomRight
        case .faceDown, .faceUp, .unknown:
            return .leftTop
        default:
            print("Could not get rotation value")
            return nil
        }
    }

}

