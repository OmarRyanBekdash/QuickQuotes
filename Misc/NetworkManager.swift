//
//  RecipeAPI.swift
//  p7
//
//  Created by Monica Ong on 2/20/18.
//  Copyright © 2018 CS 1998. All rights reserved.
//

//import Foundation
//import Alamofire
//import SwiftyJSON
//
//
//
//enum SearchType {
//    case ingredients
//    case title
//}
//
//class NetworkManager {
//    
//    private static let recipePuppyURL = "http://www.recipepuppy.com/api"
//    
//    static func getRecipe(fromIngredients ingredients: [String], _ didGetRecipes: @escaping ([Recipe]) -> Void) {
//        // TODO: Fill in this function. This function should make a network request
//        // to the Recipe Puppy API given an array of ingredients and then call the
//        // didGetRecipes closure after you receive a response and decode it.
//        let parameters : [String:Any] =
//            [
//                "i": ingredients.joined(separator: ",")
//        ]
//        
//        Alamofire.request(recipePuppyURL, method: .get, parameters: parameters).validate().responseData { (response) in
//            switch response.result {
//            case .success(let data):
//                // If you still want to see the JSON response
//                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
//                    print(json)
//                }
//                // Create the JSON decoder
//                let jsonDecoder = JSONDecoder()
//                // Mention .convertFromSnakeCase
//                // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//                
//                // Since the format of the data is { "data": { "classes": { [...] } }
//                // we need to get inside those two layers of json to decode the classes data
//                // into Course objects by first decoding the CourseResponse
//                
//                //                struct Recipe: Codable {
//                //                    let title: String
//                //                    let ingredients: String
//                //                }
//                //
//                //                struct RecipeSearchResponse: Codable {
//                //                    var results: [Recipe]
//                //                }
//                
//                
//                if let ingredients = try? jsonDecoder.decode(RecipeSearchResponse.self, from: data) {
//                    // Call the function we passed in to do whatever we want
//                    // to the classes array (eg. show it on screen)
//                    didGetRecipes(/*ingredients*/ingredients.results)
//                } else {
//                    print("Invalid Response Data")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        
//    }
//    
//    static func getRecipe(fromTitle title: String, _ didGetRecipes: @escaping ([Recipe]) -> Void) {
//        // TODO: Fill in this function. This function should make a network request
//        // to the Recipe Puppy API given a title and then call the
//        // didGetRecipes closure after you receive a response and decode it.
//        let parameters : [String:Any] =
//            [
//                "q": title
//        ]
//        
//        Alamofire.request(recipePuppyURL, method: .get, parameters: parameters).validate().responseData { (response) in
//            switch response.result {
//            case .success(let data):
//                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
//                    print(json)
//                }
//                let jsonDecoder = JSONDecoder()
//                
//                
//                if let title = try? jsonDecoder.decode(RecipeSearchResponse.self, from: data) {
//                    
//                    didGetRecipes(title.results)
//                } else {
//                    print("Invalid Response Data")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        
//    }
//    
//}





























//enum SearchType {
//    case ingredients
//    case title
//}
//
//class NetworkManager {
//
//    private static let recipePuppyURL = "http://www.recipepuppy.com/api"
//
//    static func getRecipe(fromIngredients ingredients: [String], _ didGetRecipes: @escaping ([Recipe]) -> Void) {
//        // TODO: Fill in this function. This function should make a network request
//        // to the Recipe Puppy API given an array of ingredients and then call the
//        // didGetRecipes closure after you receive a response and decode it.
//        let parameters : [String:Any] =
//            [
//                "i": ingredients.joined(separator: ",")
//        ]
//
//        Alamofire.request(recipePuppyURL, method: .get, parameters: parameters).validate().responseData { (response) in
//            switch response.result {
//            case .success(let data):
//                // If you still want to see the JSON response
//                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
//                    print(json)
//                }
//                // Create the JSON decoder
//                let jsonDecoder = JSONDecoder()
//                // Mention .convertFromSnakeCase
//                // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//
//                // Since the format of the data is { "data": { "classes": { [...] } }
//                // we need to get inside those two layers of json to decode the classes data
//                // into Course objects by first decoding the CourseResponse
//
//                //                struct Recipe: Codable {
//                //                    let title: String
//                //                    let ingredients: String
//                //                }
//                //
//                //                struct RecipeSearchResponse: Codable {
//                //                    var results: [Recipe]
//                //                }
//
//
//                if let ingredients = try? jsonDecoder.decode(RecipeSearchResponse.self, from: data) {
//                    // Call the function we passed in to do whatever we want
//                    // to the classes array (eg. show it on screen)
//                    didGetRecipes(/*ingredients*/ingredients.results)
//                } else {
//                    print("Invalid Response Data")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//    }
//
//    static func getRecipe(fromTitle title: String, _ didGetRecipes: @escaping ([Recipe]) -> Void) {
//        // TODO: Fill in this function. This function should make a network request
//        // to the Recipe Puppy API given a title and then call the
//        // didGetRecipes closure after you receive a response and decode it.
//        let parameters : [String:Any] =
//            [
//                "q": title
//        ]
//
//        Alamofire.request(recipePuppyURL, method: .get, parameters: parameters).validate().responseData { (response) in
//            switch response.result {
//            case .success(let data):
//                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
//                    print(json)
//                }
//                let jsonDecoder = JSONDecoder()
//
//
//                if let title = try? jsonDecoder.decode(RecipeSearchResponse.self, from: data) {
//
//                    didGetRecipes(title.results)
//                } else {
//                    print("Invalid Response Data")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//    }
//
//}
