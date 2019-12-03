//
//  ViewController.swift
//  Kiosk
//
//  Created by admin on 02/12/19.
//  Copyright © 2019 com.kiosk. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var lbClock: UILabel!
    var clockFomatter = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1,
                             target: self,
                             selector: #selector(self.UpdateDate),
                             userInfo: nil,
                             repeats: true)
       
        self.setUiView()
    }
    
    @objc func UpdateDate(){
        lbClock.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        
    }
    
    func setUiView(){
        self.view.backgroundColor = extensions().hexStringToUIColor(hex: "#3C0F53")

    }
}


