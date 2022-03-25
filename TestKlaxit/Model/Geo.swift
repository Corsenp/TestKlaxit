//
//  Geo.swift
//  TestKlaxit
//
//  Created by Pierre Corsenac on 25/03/2022.
//

import Foundation

struct Geo : Codable {
    let type: String?
    let version: String?
    let features: [Feature]?
    let attribution: String?
    let licence: String?
    let query: String?
    let limit: Int?
}

struct Feature : Codable {
    let type: String?
    let geometry: Geometry?
    let properties: Properties
}

struct Geometry: Codable {
    let type: String?
    let coordinates: [Float]?
}

struct Properties: Codable {
    let label: String?
    let score: Double?
    let housenumber: String?
    let id: String?
    let name: String?
    let postcode: String?
    let citycode: String?
    let x: Float?
    let y: Float?
    let city: String?
    let context: String?
    let type: String?
    let importance: Double?
    let street: String?
}
