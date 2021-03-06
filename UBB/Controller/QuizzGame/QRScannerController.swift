//
//  QRScannerController.swift
//  QRCodeReader
//
//  Created by Simon Ng on 13/10/2016.
//  Copyright © 2018. All rights reserved.
//

import AVFoundation
import UIKit

class QRScannerController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var persister = highscorePersister()
    var allQuestions = QuestionBank()
    var score = 0
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var topBar: UIView!
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetPersister(_ sender: Any) {
        persister.resetQuestion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        view.bringSubview(toFront: messageLabel)
        view.bringSubview(toFront: topBar)

        
        captureSession.startRunning()
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        //captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        //dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
        if let codeInt = Int(code) {
            if codeInt < allQuestions.list.count {
                if persister.isAnswered(codeInt) == false{
                    let currentQuestion = allQuestions.list[Int(code)!]
                    
                    print(currentQuestion.title)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "questionViewController") as! QuestionViewController
                    nextViewController.questionIndex = Int(code)!
                    self.present(nextViewController, animated:true, completion:nil)
                }else{
                    let alert = UIAlertController(title: "Erreur", message: "Vous avez déja répondu à cette question", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .`default`, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                let alert = UIAlertController(title: "Erreur", message: "Ce QR code est faux", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .`default`, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }}else{
            let alert = UIAlertController(title: "Erreur", message: "Ce QR code est faux", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .`default`, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
        //            switch (metadataObj.stringValue){
        //            case "initialisation":
        //                if position == 0{
        //
        //
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
