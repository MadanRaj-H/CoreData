//
//  PersonType+CoreDataProperties.swift
//  CoreDataExplore
//
//  Created by mh53653 on 1/15/17.
//  Copyright © 2017 madan. All rights reserved.
//

import Foundation
import CoreData


extension PersonType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonType> {
        return NSFetchRequest<PersonType>(entityName: "PersonType");
    }

    @NSManaged public var personType: String?
    @NSManaged public var toPerson: Person?

}
