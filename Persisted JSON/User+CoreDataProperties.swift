//
//  User+CoreDataProperties.swift
//  Persisted JSON
//
//  Created by Aleksey Alyonin on 17.04.2023.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?

}

extension User : Identifiable {

}
