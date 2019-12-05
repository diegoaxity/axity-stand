//
//  ScanViewController.swift
//  Kiosk
//
//  Created by admin on 02/12/19.
//  Copyright © 2019 com.kiosk. All rights reserved.
//

import UIKit
import QRCodeReader
import AVFoundation
import Lottie
import Alamofire

class ScanViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    @IBOutlet weak var btnIntentar: UIButton!
    @IBOutlet weak var lbError: UILabel!
    
    let loadingView = AnimationView(name: "loading")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setUiView()
        self.scan()
    }
    
    func setUiView(){
        self.view.backgroundColor = extensions().hexStringToUIColor(hex: "#3C0F53")
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "idViewController") as! ViewController
                self.navigationController?.pushViewController(secondViewController, animated: true)
        
    }
    
    
//    MARK: Animations
    
    func okLottie(){
        
        let starAnimationView = AnimationView(name: "ok")
        
        self.view.addSubview(starAnimationView)
        starAnimationView.center = CGPoint(x: self.view.frame.size.width  / 2,
                                           y: self.view.frame.size.height / 2)
        
        starAnimationView.play { (finished) in
            
            self.lbError.isHidden = false
            self.lbError.text = "Bienvenido Moises Lugo"
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "idViewController") as! ViewController
                             self.navigationController?.pushViewController(secondViewController, animated: true)
                print("All ok")
           

            })
        }
        
    }
    
    func badLottie(){
        
        let starAnimationView = AnimationView(name: "error")
        
        starAnimationView.frame = CGRect(x: 0,
                                         y: 0, width: starAnimationView.frame.width + 200.0, height: starAnimationView.frame.height + 200.0)

        starAnimationView.center = self.view.center
        
        self.view.addSubview(starAnimationView)

        
        starAnimationView.play { (finished) in
            
            self.btnIntentar.isHidden = false
            self.lbError.isHidden = false
            self.lbError.text = "ERROR EN EL SERVICIO"
        }
        
    }
    
    func activityLottie(){
        
        loadingView.loopMode = .loop
               
               self.view.addSubview(loadingView)
               loadingView.center = CGPoint(x: self.view.frame.size.width  / 2,
                                                  y: self.view.frame.size.height / 2)
               
               loadingView.play()
        
    }
    
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = true
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    func scan(){
        
        readerVC.delegate = self
        
        // Or by using the closure pattern
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
           
            print(result!)
           
            if result == nil{
                self.readerVC.dismiss(animated: true, completion: {
                     self.navigationController?.popToRootViewController(animated: true)
                })
               
                
            }else
            {
                
                self.activityLottie()
                self.postService(Url: result?.value ?? "no url")
            }
           

        }
        
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        
        present(readerVC, animated: true, completion: nil)
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        let cameraName = newCaptureDevice.device.localizedName
        print("Switching capture to: \(cameraName)")
        
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    func postService(Url: String){
        
//        let parameters: Parameters = [:]//, "password": "pistol"]
             let headers    = ["Content-Type":"application/json"]
        Alamofire.request(Url,method: .get, parameters: nil, encoding: JSONEncoding.default,headers: headers).validate(statusCode: 200..<300)
                 .responseJSON { response in
                    self.loadingView.stop()
                    
                     switch(response.result) {
                     case .success(_):
                         if let data = response.result.value{
                            
                            self.okLottie()
                             
                             //                        let json = data as! NSDictionary
                             //                        let color = json["color"] as! String
                             //                        let descripcion = json["descripcion"] as! String
                             //                        let estilo = json["estilo"] as! String
                             //                        let sku = json["sku"] as Any
                             //                        let talla = json["talla"] as! String
                             print(data)
                             
                         }
                         
                     case .failure(_):
                        self.badLottie()
                         print("Error message:\(String(describing: response.result.error))")
                         break
                         
                     }
             }
        
    }
         
    
}
