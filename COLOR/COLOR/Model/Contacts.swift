//
//  Contacts.swift
//  COLOR
//
//  Created by Arvind Prem on 01/02/19.
//  Copyright © 2019 Arvind. All rights reserved.
//

import Foundation

struct Contacts: Decodable {
    var results: [BasicInfo] = []
}

struct BasicInfo: Decodable {
    var name: Name?
    var gender: String?
    var email: String?
    var phone: String?
    var cell: String?
    var nat: String?
    var location: Location?
    var picture: Picture?
}

struct Name: Decodable {
    var title: String?
    var first: String?
    var last: String?
}

struct Location: Decodable {
    var street: String?
    var city: String?
    var state: String?
}

struct Picture: Decodable {
    var large: String?
    var medium: String?
    var thumbnail: String?
}

