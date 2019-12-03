//
//  ScanViewController.swift
//  Kiosk
//
//  Created by admin on 02/12/19.
//  Copyright © 2019 com.kiosk. All rights reserved.
//

import UIKit

class ScanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUiView()
    }
    
    func setUiView(){
        self.view.backgroundColor = extensions().hexStringToUIColor(hex: "#3C0F53")

    }

    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
