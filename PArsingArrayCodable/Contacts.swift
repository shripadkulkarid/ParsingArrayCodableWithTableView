//
//  Contacts.swift
//  PArsingArrayCodable
//
//  Created by Samvidya Edutech LLP on 29/08/18.
//  Copyright © 2018 Samvidya Edutech LLP. All rights reserved.
//

import Foundation
// To parse the JSON, add this file to your project and do:
//
//   let contacts = try? newJSONDecoder().decode(Contacts.self, from: jsonData)



class Contacts: Codable {
    let contacts: [Contact]?
    
    init(contacts: [Contact]?) {
        self.contacts = contacts
    }
}

class Contact: Codable {
    let id, name, email: String?
    let address: Address?
    let gender: Gender?
    let phone: Phone?
    
    init(id: String?, name: String?, email: String?, address: Address?, gender: Gender?, phone: Phone?) {
        self.id = id
        self.name = name
        self.email = email
        self.address = address
        self.gender = gender
        self.phone = phone
    }
}

enum Address: String, Codable {
    case xxXxXxxxXStreetXCountry = "xx-xx-xxxx,x - street, x - country"
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

class Phone: Codable {
    let mobile: Mobile?
    let home, office: Home?
    
    init(mobile: Mobile?, home: Home?, office: Home?) {
        self.mobile = mobile
        self.home = home
        self.office = office
    }
}

enum Home: String, Codable {
    case the00000000 = "00 000000"
}

enum Mobile: String, Codable {
    case the910000000000 = "+91 0000000000"
}
