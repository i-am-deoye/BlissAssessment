//
//  RepoEntity+CoreDataProperties.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//
//

import Foundation
import CoreData


extension RepoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepoEntity> {
        return NSFetchRequest<RepoEntity>(entityName: "RepoEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var fullname: String
    @NSManaged public var isPrivate: Bool

}

extension RepoEntity : Identifiable {

}
