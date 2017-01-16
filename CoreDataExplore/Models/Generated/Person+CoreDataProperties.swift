//
//  Person+CoreDataProperties.swift
//  CoreDataExplore
//
//  Created by mh53653 on 1/15/17.
//  Copyright © 2017 madan. All rights reserved.
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person");
    }

    @NSManaged public var name: String?
    @NSManaged public var created: NSDate?
    @NSManaged public var bloodGroup: String?
    @NSManaged public var mobileNumber: String?
    @NSManaged public var emailId: String?
    @NSManaged public var toImage: Image?
    @NSManaged public var toOccupation: Occupation?
    @NSManaged public var toPersonType: PersonType?

}
