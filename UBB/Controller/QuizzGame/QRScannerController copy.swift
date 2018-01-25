//
//  QRScannerController.swift
//  QRCodeReader
//
//  Created by Simon Ng on 13/10/2016.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import AVFoundation


class QRScannerController01: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var allQuestions = QuestionBank()
    var score = 0
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var position = 0

    @IBOutlet var messageLabel:UILabel!
    @IBOutlet var topbar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
           // videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Move the message label and top bar to the front
            view.bringSubview(toFront: messageLabel)
            view.bringSubview(toFront: topbar)
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            messageLabel.text = "Aucun QR Code détecté"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue == "Question1" {
                messageLabel.text = "Bravo"
            }
            
            // metadataObj.stringValue
            if Int(metadataObj.stringValue!) != nil{
            if Int(metadataObj.stringValue!)! < allQuestions.list.count {
            var currentQuestion = allQuestions.list[Int(metadataObj.stringValue!)!]
            
            print(currentQuestion.title)
            }else{
                let alert = UIAlertController(title: "Erreur", message: "Ce QR code est faux", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .`default`, handler:{ _ in print("fghjkl")}))
                self.present(alert, animated: true, completion: nil)
                
                }}else{
                let alert = UIAlertController(title: "Erreur", message: "Ce QR code est faux", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .`default`, handler:{ _ in print("fghjkl")}))
                self.present(alert, animated: true, completion: nil)
            }
            
            
            
//            switch (metadataObj.stringValue){
//            case "initialisation":
//                if position == 0{
//
//
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "questionViewController") as! QuestionViewController
            nextViewController.questionIndex = Int(metadataObj.stringValue!)!
                    self.present(nextViewController, animated:true, completion:nil)
//
//                    print("Affichage question 1")
//                    position = 1
//                }else{
//                    print("dommage t'es pas au bon endroit frère")
//                }
//            break
//            case "Question1":
//                if position == 1{
//                    print("bravo ! vous passez à la deuxième question ")
//                    position = 2
//                }else{
//                    print("Vous n'êtes pas au bon endroit !")
//                }
//            break
//            case "Question2":
//                if position == 2{
//                    print("bravo ! vous passez à la troisième question ")
//                    position = 3
//                }else{
//                    print("Vous n'êtes pas au bon endroit !")
//                }
//            break
//            case "Question3":
//                if position == 3{
//                    print("bravo ! Vous avez gagné ")
//                }else{
//                    print("Vous n'êtes pas au bon endroit !")
//                }
//            break
//            default:
//                print("C'est pas normal")
//
//            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
