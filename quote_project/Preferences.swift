//
//  Preferences.swift
//  quote_project
//
//  Created by Omar Beckdash on 1/29/19.
//  Copyright © 2019 Omar Bekdash. All rights reserved.
//

import Foundation

enum UserDefaultsKey: String {
    case textSize
    

    
}

enum TextUnit: String, CaseIterable {
    case small
    case big

    
    var index: Int {
        switch self {
        case .small: return 0
        case .big: return 1
        }
    }

}


