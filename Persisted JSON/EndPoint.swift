//
//  EndPoint.swift
//  Persisted JSON
//
//  Created by Aleksey Alyonin on 17.04.2023.
//

import Foundation
import CoreData

enum EndPoint <T: NSManagedObject> {
    case entries
    
    var urlPath : String {
        switch self {
        case .entries : return "https://api.publicapis.org/entries"
        }
    }
}
