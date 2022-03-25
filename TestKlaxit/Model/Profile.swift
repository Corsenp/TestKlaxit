//
//  Profile.swift
//  TestKlaxit
//
//  Created by Pierre Corsenac on 25/03/2022.
//

import Foundation

struct LocalProfile: Codable {
    let picture_url: String?
    let first_name: String?
    let last_name: String?
    let phone_number: String?
    let company: String?
    let job_position: String?
}
