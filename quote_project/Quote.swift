//
//  Quote.swift
//  quote_project
//
//  Created by Omar Beckdash on 1/13/19.
//  Copyright © 2019 Omar Bekdash. All rights reserved.
//

import Foundation
import UIKit

struct Quote: Decodable {
    var quote: String
    var author: String
    var length: String?
    var tags: [String]
    var category: String
    var title: String
    var date: String
    var permalink: String?
    var id: String?
    var background: String?
}

struct WebsiteObjectStruct: Decodable {
    var success: SuccessStruct
    var contents: ContentsStruct
}

struct SuccessStruct: Decodable{
    var total: Int?
}

struct ContentsStruct: Decodable{
    var quotes: [Quote]
    var copyright:  String?
}



//MOST UPDATED STRUCT HERE
//struct Quote: Decodable {
//    let quote: String
//    let author: String
//    let length: String
//    let tags: [String]
//    let category: String
//    let title: String
//    let date: String
//
//}
//
//struct WebsiteObjectStruct: Decodable {
//    let success: SuccessStruct
//    let contents: ContentsStruct
//}
//
//struct SuccessStruct: Decodable{
//    let total: Int
//}
//
//struct ContentsStruct: Decodable{
//    let quotes: [Quote]
//    let copyright:  String
//}
//struct WebsiteObjectStruct: Codable {
//    let success: SuccessStruct
//    let contents: ContentsStruct
//}
//
//struct SuccessStruct: Codable{
//    let total: Int
//}
//
//struct ContentsStruct: Codable{
//    let quotes: [Quote]
//    let copyright:  String
//}

//struct Quote: Codable {
//    let quote: String
//    let author: String
//    let length: Int
//    let tags: [String]
//    let category: String
//    let title: String
//    let date: String
//    let id: String
//}

//struct QuoteSearchResponse: Codable {
//    var results: [Recipe]
//}




//Whenever I run my code, which attempts to take the fields and store them into variables, it fails. I test it by trying to make a label's textfield appear as the
//author's name (code below)
//These are the important parts of the code:
//
//Class ViewController: UITableViewController  {
//    ...
//    var quoteArray = [Quote]()
//    //quoteArray Stores the quote objects that contain the fields I need
//    .....
//    //STRUCTS TO REPRESENT THE JSON
//
//
//    ...
//    var quoteArray = [Quote]()
//    //quoteArray Stores the quote objects that contain the fields I need
//    .....
//    //STRUCTS TO REPRESENT THE JSON
//    struct Quote: Decodable {
//        let quote: String?
//        let author: String?
//        let length: String?
//        let tags: [String]?
//        let category: String?
//        let title: String?
//        let date: String?
//    }
//    
//    struct WebsiteObjectStruct: Decodable {
//        let success: SuccessStruct?
//        let contents: ContentsStruct?
//    }
//    
//    struct SuccessStruct: Decodable{
//        let total: Int?
//    }
//    
//    struct ContentsStruct: Decodable{
//        let quotes: [Quote]?
//        let copyright:  String?
//    }
//    
//    .....
//
//    fileprivate func fetchJSON(){
//            ...
//            self.websiteObject = try decoder.decode(WebsiteObjectStruct.self, from: data)
//            self.tableView.reloadData()
//            ...
//    }
//    ...
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
//        let authorText = quoteArray[0].author
//        cell.textLabel?.text = author.text
//        //For quoteArray we are looking at zero index because in my JSON there
//        // is only ever one element, located at index 0, in quoteArray
//        return cell
//    }
//}
//
//
//The app runs and the the tableView is empty, it doesnt have the author's name (In this case bill murray). Anyway, here is the error message:
//
//Failed to decode: typeMismatch(Swift.Array<Any>, Swift.DecodingError.Context(codingPath: [], debugDescription: "Expected to decode Array<Any> but found a dictionary instead.",
//underlyingError: nil))
//
//It says it expected to decode an array but instead found a dictionary. Well I changed it one time to decode not an array but a struct, and had a variable declared
//outside the class that was of type struct. Short story is, I changed the code slightly to accomodate for this, and while it could print the author's name to the console, it
//still couldnt store it into a variable for use. I don't think the problem is Array vs Dictionary but with the "underlyingError" the console talks about, that the Array is nil. No matter what type the variable is, it is always nil. I get this error: Fatal Error: unexpected found nil while unwrapping optional value
//
//
//
//
//
//
//
//{
//    "success": {
//        "total": 1
//    },
//    "contents": {
//        "quotes": [
//        {
//        "quote": "The last time doesn't exist. It's only this time. And everything is going to be different this time. There's only now.",
//        "author": "Bill Murray",
//        "length": "118",
//        "tags": [
//        "inspire",
//        "present"
//        ],
//        "category": "inspire",
//        "title": "Inspiring Quote of the day",
//        "date": "2019-01-16",
//        "id": null
//        }
//        ],
//        "copyright": "2017-19 theysaidso.com"
//    }
//}
