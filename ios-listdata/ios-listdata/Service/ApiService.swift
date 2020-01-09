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
    
    func fetchListItem(parameters:[String : Any]? = nil,success:@escaping (_ response : Data)->(), failure : @escaping (_ error : Error)->()){
    
        let routeList = Constant.Server.baseUrl + Constant.Route.routeList
        print ("url: \(routeList)")
        
        Alamofire.request(routeList, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
               switch response.result {
                   case .success:
                   if let data = response.data {
                       success(data)
                   }
                   case .failure(let error):
                       failure(error)
               }
        }
    }
}
