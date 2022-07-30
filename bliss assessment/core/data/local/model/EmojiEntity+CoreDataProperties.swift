//
//  EmojiEntity+CoreDataProperties.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//
//

import Foundation
import CoreData


extension EmojiEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmojiEntity> {
        return NSFetchRequest<EmojiEntity>(entityName: "EmojiEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var icon: String

}

extension EmojiEntity : Identifiable {

}
