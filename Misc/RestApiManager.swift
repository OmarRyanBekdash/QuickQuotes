////
////  RestApiManager.swift
////  quote_project
////
////  Created by Omar Beckdash on 1/28/19.
////  Copyright © 2019 Omar Bekdash. All rights reserved.
////
//
//import Foundation
//import SwiftyJSON
//
//typealias ServiceResponse = (JSON, NSError?) -> Void
//
//class RestApiManager: NSObject {
//    static let sharedInstance = RestApiManager()
//    
//    let baseURL = "https://www.googleapis.com/customsearch/v1?key=AIzaSyDUbNvrriOwQP8HkVRNNLK4K06tWAHGX1I&cx=006599334025039600654:dlr0gznrbas:omuauf_lfve&q=EugeneDelacroix"
//    
//    func getPicture(/*baseURL: String,*/ onCompletion: @escaping (JSON) -> Void) {
//        let route = baseURL
//        makeHTTPGetRequest(path: route, onCompletion: { json, err in
//            onCompletion(json as JSON)
//        })
//    }
//    
//    func makeHTTPGetRequest(path: String, onCompletion: @escaping ServiceResponse) {
//        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
//        //let url = URL(string: path)!
//        let session = URLSession.shared
//        
////        let task = try session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
////            let json:JSON = try JSON(data: data!)
////            onCompletion(json, error as! NSError)
////        })
////        task.resume()
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
//            let json:JSON = try JSON(data: data!)
//            onCompletion(json, error as! NSError)
//            } as! (Data?, URLResponse?, Error?) -> Void)
//        task.resume()
//    }
//}
