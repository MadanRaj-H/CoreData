//
//  Occupation+CoreDataProperties.swift
//  CoreDataExplore
//
//  Created by mh53653 on 1/15/17.
//  Copyright © 2017 madan. All rights reserved.
//

import Foundation
import CoreData


extension Occupation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Occupation> {
        return NSFetchRequest<Occupation>(entityName: "Occupation");
    }

    @NSManaged public var field: String?
    @NSManaged public var skills: String?
    @NSManaged public var location: String?
    @NSManaged public var toImage: Image?
    @NSManaged public var toPerson: Person?

}
