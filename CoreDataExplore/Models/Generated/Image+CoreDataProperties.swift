//
//  Image+CoreDataProperties.swift
//  CoreDataExplore
//
//  Created by mh53653 on 1/15/17.
//  Copyright © 2017 madan. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toPerson: Person?
    @NSManaged public var toOccupation: Occupation?

}
