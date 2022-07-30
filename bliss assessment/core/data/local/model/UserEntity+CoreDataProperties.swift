//
//  UserEntity+CoreDataProperties.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var username: String
    @NSManaged public var avatarUrl: String

}

extension UserEntity : Identifiable {

}
