//
//  AuthorImage.swift
//  quote_project
//
//  Created by Omar Beckdash on 1/28/19.
//  Copyright © 2019 Omar Bekdash. All rights reserved.
//

import Foundation
import UIKit

//An apt quotation is like a lamp which flings its light over the whole sentence.
//Letitia Elizabeth Landon

struct WikiStruct: Decodable {
    var query: QueryStruct
    var batchcomplete: String?
}

struct QueryStruct: Decodable {
    var normalized: [NormalizedStruct]?
    var pages: PageStruct?
}

struct NormalizedStruct: Decodable{
    var from: String?
    var to: String?
}

struct PageStruct: Decodable{
    var pageid: Int?
    var ns: Int?
    var title: String?
    var thumbnail: ThumbStruct?
    var pageimage: String?


}

struct ThumbStruct: Decodable{
    var source: String?//this is what I want
    var width: Int?
    var height: Int?
}


//struct PageStruct: Decodable{
//    var pageid: SomeStruct?
//
//
//}
//
//struct SomeStruct: Decodable{
//    var pageid: Int?
//    var ns: Int?
//    var title: String?
//    var thumbnail: ThumbStruct?
//    var pageimage: String?
//
//}
