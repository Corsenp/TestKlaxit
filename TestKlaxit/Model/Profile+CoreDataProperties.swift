//
//  Profile+CoreDataProperties.swift
//  TestKlaxit
//
//  Created by Pierre Corsenac on 24/03/2022.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var picture_URL: String?
    @NSManaged public var first_name: String?
    @NSManaged public var last_name: String?
    @NSManaged public var phone_number: String?
    @NSManaged public var company: String?
    @NSManaged public var job_position: String?
    @NSManaged public var address: String?

}

extension Profile : Identifiable {

}
