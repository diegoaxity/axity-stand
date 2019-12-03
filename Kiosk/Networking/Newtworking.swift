//
//  Newtworking.swift
//  Kiosk
//
//  Created by admin on 03/12/19.
//  Copyright © 2019 com.kiosk. All rights reserved.
//

import Foundation
import Alamofire



protocol NewtworkingProtocol {
    func post(code: String)
    
}

class Networking: NewtworkingProtocol {
    func post(code: String) {
        
        
        let parameters: Parameters = ["parameter-name": [:]]
        let headers    = ["Content-Type":"application/json"]
        Alamofire.request("http://187.176.10.182:8181/article?sku=\(code)",method: .post, parameters: parameters, encoding: JSONEncoding.default,headers: headers)
            .responseJSON { response in
                print("JSON:\(String(describing: response.result.value))")
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        
                        //                        let json = data as! NSDictionary
                        //                        let color = json["color"] as! String
                        //                        let descripcion = json["descripcion"] as! String
                        //                        let estilo = json["estilo"] as! String
                        //                        let sku = json["sku"] as Any
                        //                        let talla = json["talla"] as! String
                        print(data)
                        
                    }
                    
                case .failure(_):
                    
                    print("Error message:\(String(describing: response.result.error))")
                    break
                    
                }
        }
        .responseString { response in
            print("String:\(response.result.value ?? "")")
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    print(data)
                }
                
            case .failure(_):
                print("Error message:\(String(describing: response.result.error))")
                break
            }
        }
    }
    
    
    
    
}
