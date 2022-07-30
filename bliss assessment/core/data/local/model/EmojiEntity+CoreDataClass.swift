//
//  EmojiEntity+CoreDataClass.swift
//  bliss assessment
//
//  Created by Moses on 30/07/2022.
//
//

import Foundation
import CoreData

@objc(EmojiEntity)
public class EmojiEntity: NSManagedObject {
    convenience init() {
        if #available(iOS 10.0, *) {
            self.init(context: CoreDataDriver.shared.context)
        } else {
            // Fallback on earlier versions'
            let entityDescription = NSEntityDescription.entity(forEntityName: "EmojiEntity", in: CoreDataDriver.shared.context)!
            self.init(entity: entityDescription, insertInto: CoreDataDriver.shared.context)
        }
    }
}
