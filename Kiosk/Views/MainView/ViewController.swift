//
//  ViewController.swift
//  Kiosk
//
//  Created by admin on 02/12/19.
//  Copyright © 2019 com.kiosk. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var lbLugar: UILabel!
    @IBOutlet weak var lbConect: UILabel!
    @IBOutlet weak var lbScanQr: UILabel!
    @IBOutlet weak var lbVersion: UILabel!
    @IBOutlet weak var lbClock: UILabel!
    var clockFomatter = ""

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.setUiView()
    }
    
    
    
    @objc func UpdateDate(){
        lbClock.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        
    }
    
    func setUiView(){
        self.view.backgroundColor = extensions().hexStringToUIColor(hex: "#3C0F53")
        lbClock.textColor = UIColor.white
        lbConect.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .full)
        Timer.scheduledTimer(timeInterval: 0,
                                     target: self,
                                     selector: #selector(self.UpdateDate),
                                     userInfo: nil,
                                     repeats: true)

    }
    
  
         
    
}


