//
//  ApiService.swift
//  ios-listdata
//
//  Created by Cristian Rivera on 1/8/20.
//  Copyright © 2020 Cristian Rivera. All rights reserved.
//

import Foundation
import Alamofire

class ApiService {
    static let shared = ApiService()
    static let manager = Alamofire.SessionManager.default
    
    
    func fetchListItem(completion: @escaping([[String: Any]]) -> Void) {
        let routeList = Constant.Server.baseUrl + Constant.Route.routeList
        print ("url: \(routeList)")
        ApiService.manager.request(routeList).responseJSON { response in
            print("response: \(response.result)")
            switch (response.result) {
                case .success:
                    guard let respuesta = response.result.value as? [[String: Any]] else {
                        return
                    }
                    completion(respuesta)
                break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        print("Error por timeout")
                    }
                    print("error:\(error)")
                    break
            }
            
        }
    }
 
}
