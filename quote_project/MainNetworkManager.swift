////
////  MainNetworkManager.swift
////  quote_project
////
////  Created by Omar Beckdash on 1/13/19.
////  Copyright © 2019 Omar Bekdash. All rights reserved.
////
//
import Foundation
import Alamofire
import SwiftyJSON


class MainNetworkManager{
    //Request JSON Format from the wep API
    
    static func fetchJSON(fetchUrl: String, quoteViewController: QuoteViewController) {
        let urlString = fetchUrl
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to get data from url:", err)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    // link in description for video on JSONDecoder
                    let decoder = JSONDecoder()
                    // Swift 4.1
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    //self.webStruct = try decoder.decode(WebsiteObjectStruct.self, from: data)
                    //                        self?.quoteArray = quotesArray
                    //                        self?.reloadInputViews()
                    let tempStruct = try decoder.decode(WebsiteObjectStruct.self, from: data)
                    
                    //print(tempStruct.contents.quotes[0].length)
                    quoteViewController.webStruct = tempStruct
                    

                    //quoteViewController.setupLabels(array: (tempStruct.contents.quotes))
                    quoteViewController.setupLabels(obj: tempStruct)
                    
//                    let rand = Int.random(in: 0 ... 300)
//                    let stringifiedNumber = "\(rand)"
//                    MainNetworkManager.downloadImage(from: URL(string: "https://picsum.photos/200/200/?image=" + stringifiedNumber)!, quoteViewController: quoteViewController)
//                    QuoteViewController.authorImage.layer.borderWidth = 2
//                    QuoteViewController.authorImage.layer.masksToBounds = false
//                    QuoteViewController.authorImage.layer.borderColor = UIColor.black.cgColor
//                    QuoteViewController.authorImage.layer.cornerRadius = QuoteViewController.authorImage.frame.height/2
//                    QuoteViewController.authorImage.clipsToBounds = true
                    
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                }
            }
            }.resume()
    }
    
    
//    static func downloadImage(from url: URL, quoteViewController: QuoteViewController) {
//        print("Download Started")
//        MainNetworkManager.getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
//            DispatchQueue.main.async() {
//                QuoteViewController.authorImage.layer.borderWidth = 2
//                QuoteViewController.authorImage.layer.masksToBounds = false
//                QuoteViewController.authorImage.layer.borderColor = UIColor.black.cgColor
//                QuoteViewController.authorImage.layer.cornerRadius = QuoteViewController.authorImage.frame.height/2
//                QuoteViewController.authorImage.clipsToBounds = true
//                quoteViewController.view.addSubview(QuoteViewController.authorImage)
//
//            }
//        }
//    }
//
//    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
//
    static func fetchPIC(fetchUrl: String, quoteViewController: QuoteViewController) {
//        let urlString = fetchUrl
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { (data, _, err) in
//            DispatchQueue.main.async {
//                if let err = err {
//                    print("Failed to get data from url:", err)
//                    return
//                }
//
//                guard let data = data else { return }
//
//                do {
//                    // link in description for video on JSONDecoder
//                    let decoder = JSONDecoder()
//                    // Swift 4.1
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    //self.webStruct = try decoder.decode(WebsiteObjectStruct.self, from: data)
//                    //                        self?.quoteArray = quotesArray
//                    //                        self?.reloadInputViews()
//                    let tempStruct = try decoder.decode(WikiStruct.self, from: data)
//
//                    //print(self.webStruct.contents?.quotes![0])
//                    quoteViewController.picStruct = tempStruct
//                    print(tempStruct)
//
//                    quoteViewController.authorImage.contentMode = .scaleAspectFit
//
//                    MainNetworkManager.downloadImage(from: URL(string: (tempStruct.query.pages?.thumbnail?.source)!)!, quoteViewController: quoteViewController)
//
//
//
//                } catch let jsonErr {
//                    print("Failed to decode:", jsonErr)
//                }
//            }
//            }.resume()
    }
    
//    static func downloadImage(from url: URL, quoteViewController: QuoteViewController) {
//        print("Download Started")
//        MainNetworkManager.getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
//            DispatchQueue.main.async() {
//                quoteViewController.authorImage.image = UIImage(data: data)
//                quoteViewController.view.addSubview(quoteViewController.authorImage)
//            }
//        }
//    }
//
//    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
//        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
//    }
//
    
    //Display error while requesting the JSON
    fileprivate func displayAlert(_ text: String, quoteViewController: QuoteViewController) {
        DispatchQueue.main.async { [weak quoteViewController] in
            let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
            let alterAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(alterAction)
            quoteViewController?.present(alert, animated: true)
        }
    }
    
    
    
    
    
}







//
////enum SearchType {
////    case ingredients
////    case title
////}
//
//
////{
////    "success": {
////        "total": 1
////    },
////    "contents": {
////        "quotes": [
////        {
////        "quote": "You wouldn't have won if we'd beaten you.",
////        "author": "Yogi Berra",
////        "length": "41",
////        "tags": [
////        "sports"
////        ],
////        "category": "sports",
////        "title": "Sports Quote of the day",
////        "date": "2019-01-15",
////        "id": null
////        }
////        ],
////        "copyright": "2017-19 theysaidso.com"
////    }
////}
//
//enum MyError: Error {
//    case runtimeError(String)
//}
//
//
//class MainNetworkManager {
//    
//   static  var quoteString: String!
//    //string that contains the quote from the JSON
//   static var authorString: String!
//    //String that contains the quote author
//    static var lengthString: String!
//    //for quote length
//    static var tagsStringArray: [String]!
//    //for quote tags array
//    static var categoryString: String!
//    //for quote cat
//   static  var titleString: String!
//    //for quote title
//    static var dateString: String!
//    //for date in which quote is made
//   static  var idString: String!
//    //for the quote id
//    
// 
//    static func getQuote(fetchUrl: String, completion: @escaping (WebsiteObjectStruct) -> Void) {
//
//        let jsonUrlString = fetchUrl
//
//        guard let url = URL(string: jsonUrlString) else {return}
//
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//        //check err, response status 200 ok
//            guard let data = data else {return}
//        //            let dataAsString = String(data: data, encoding: .utf8)
//        //            print(dataAsString)
//
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let websiteObjectStruct = try decoder.decode(WebsiteObjectStruct.self, from: data)
//                //let quotes = try JSONDecoder().decode([Quote].self, from: data)
//                //print(websiteObjectStruct.contents.quotes)
//                completion(websiteObjectStruct)
//                //print(websiteObjectStruct.success.total)
//                
//                //initialize important variables
//                
////                MainNetworkManager.quoteString = websiteObjectStruct.contents.quotes[0].quote
////                print(MainNetworkManager.quoteString)
//        
//                //print(MainNetworkManager.quoteString + "I will murder someone soon")
////                self.authorString = websiteObjectStruct.contents.quotes![0].author
////                self.lengthString = websiteObjectStruct.contents.quotes![0].length
////                self.tagsStringArray = websiteObjectStruct.contents.quotes![0].tags
////                self.categoryString = websiteObjectStruct.contents.quotes![0].category
////                self.titleString = websiteObjectStruct.contents.quotes![0].title
////
//            }
//            catch let jsonErr{
//                print(jsonErr.localizedDescription)
//            }
//        }.resume()
//    }
//
//
//
////    static func getQuote(url: String, completion: @escaping ([Quote]) -> Void){
////
////        Alamofire.request(url, method: .get).validate().responseData { (response) in
////            switch response.result {
////            case .success(let data):
////                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
////                    print(json)
////                }
////                let decoder = JSONDecoder()
////
////                if let websiteObjectStruct = try? decoder.decode(WebsiteObjectStruct.self, from: data) {
////                    print(websiteObjectStruct.contents.quotes)
////                    completion(websiteObjectStruct.contents.quotes)
////                }
////                print("a;dfjl;kjfalsdkjfslkfjasdlk;fjsaldkfjsl;adfkj;sldkfjadl;fkj")
////
////            case .failure(let error):
////                print(error.localizedDescription)
////            }
////        }
////    }
//
//}
//
//
////enum SearchType {
////    case ingredients
////    case title
////}
////
////class NetworkManager {
////
////    private static let recipePuppyURL = "http://www.recipepuppy.com/api"
////
////    static func getRecipe(fromIngredients ingredients: [String], _ didGetRecipes: @escaping ([Recipe]) -> Void) {
////        // TODO: Fill in this function. This function should make a network request
////        // to the Recipe Puppy API given an array of ingredients and then call the
////        // didGetRecipes closure after you receive a response and decode it.
////        let parameters : [String:Any] =
////            [
////                "i": ingredients.joined(separator: ",")
////        ]
////
////        Alamofire.request(recipePuppyURL, method: .get, parameters: parameters).validate().responseData { (response) in
////            switch response.result {
////            case .success(let data):
////                // If you still want to see the JSON response
////                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
////                    print(json)
////                }
////                // Create the JSON decoder
////                let jsonDecoder = JSONDecoder()
////                // Mention .convertFromSnakeCase
////                // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
////
////                // Since the format of the data is { "data": { "classes": { [...] } }
////                // we need to get inside those two layers of json to decode the classes data
////                // into Course objects by first decoding the CourseResponse
////
////                //                struct Recipe: Codable {
////                //                    let title: String
////                //                    let ingredients: String
////                //                }
////                //
////                //                struct RecipeSearchResponse: Codable {
////                //                    var results: [Recipe]
////                //                }
////
////
////                if let ingredients = try? jsonDecoder.decode(RecipeSearchResponse.self, from: data) {
////                    // Call the function we passed in to do whatever we want
////                    // to the classes array (eg. show it on screen)
////                    didGetRecipes(/*ingredients*/ingredients.results)
////                } else {
////                    print("Invalid Response Data")
////                }
////            case .failure(let error):
////                print(error.localizedDescription)
////            }
////        }
////
////    }
////
////    static func getRecipe(fromTitle title: String, _ didGetRecipes: @escaping ([Recipe]) -> Void) {
////        // TODO: Fill in this function. This function should make a network request
////        // to the Recipe Puppy API given a title and then call the
////        // didGetRecipes closure after you receive a response and decode it.
////        let parameters : [String:Any] =
////            [
////                "q": title
////        ]
////
////        Alamofire.request(recipePuppyURL, method: .get, parameters: parameters).validate().responseData { (response) in
////            switch response.result {
////            case .success(let data):
////                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
////                    print(json)
////                }
////                let jsonDecoder = JSONDecoder()
////
////
////                if let title = try? jsonDecoder.decode(RecipeSearchResponse.self, from: data) {
////
////                    didGetRecipes(title.results)
////                } else {
////                    print("Invalid Response Data")
////                }
////            case .failure(let error):
////                print(error.localizedDescription)
////            }
////        }
////
////    }
////
////}
