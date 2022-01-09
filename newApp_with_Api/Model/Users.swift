//
//  Users.swift
//  newApp_with_Api
//
//  Created by Temur on 07/01/2022.
//

import Foundation
import UIKit

// MARK: - Element
struct User: Decodable {
    let id: String
    let index: Int
    let guid: String
    let isActive: Bool
    let balance: String
    let picture: String
    let age: Int
    let eyeColor, name, gender, company: String
    let email, phone, address, about: String
    let registered: String
    let latitude, longitude: Double
    let tags: [String]
    let friends: [Friend]
    let greeting, favoriteFruit: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case index, guid, isActive, balance, picture, age, eyeColor, name, gender, company, email, phone, address, about, registered, latitude, longitude, tags, friends, greeting, favoriteFruit
    }
}

// MARK: - Friend
struct Friend: Decodable {
    let id: Int
    let name: String
}
struct Usersdatabase {
    let user: User
    let image: UIImage
}

struct NewUsersdatabase {
    let user: User
    let image: UIImage
    
    init(user: User, image: UIImage) {
        self.user = user
        self.image = image
    }
}
