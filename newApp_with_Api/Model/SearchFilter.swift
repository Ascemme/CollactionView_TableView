//
//  SearchFilter.swift
//  newApp_with_Api
//
//  Created by Temur on 08/01/2022.
//

import Foundation
import UIKit

struct SearchFilter{
    
    func filterContentForSearchText(searchBar: String, dbUsers: [Usersdatabase], setting: Int) -> ([Usersdatabase]) {
        
        let users = dbUsers.filter{ (user: Usersdatabase) -> Bool in
            let searchName = user.user.name.localizedCaseInsensitiveContains(searchBar)
            let searchSex = user.user.gender.localizedCaseInsensitiveContains(searchBar.lowercased())
            let age = user.user.age
            let searchAge = String(age).contains(searchBar)
            let genderMale = user.user.gender == searchBar.lowercased()
            if searchBar.lowercased() == "male"{
                return genderMale
            }
            
            if searchBar != ""{
                let b = String(Array(user.user.name)[0]) == String(Array(searchBar)[0])
                if b{
                    return searchName
                }
            }
            return (searchAge || searchSex)
        }
        
        if setting == 0{
            if searchBar.isEmpty {
                return dbUsers
            }
            return users
        }
        
        if setting == 1{
            if searchBar.isEmpty {
                let dbUsers = dbUsers.sorted(by: { $0.user.age > $1.user.age })
                return dbUsers
            }
            let users = users.sorted(by: { $0.user.age > $1.user.age })
            return users
        }
        if setting == 2{
            if searchBar.isEmpty {
                let dbUsers = dbUsers.sorted(by: { $0.user.gender > $1.user.gender })
                return dbUsers
            }
            let users = users.sorted(by: { $0.user.gender > $1.user.gender })
            return users
        }
        return users
    }
}
