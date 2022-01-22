//
//  Parser.swift
//  newApp_with_Api
//
//  Created by Temur on 07/01/2022.
//

import Foundation
import UIKit


// here we parsing data from inet or json file

struct Parser{
    
    //MARK: - dataParserFormURL
    
    func dataParserFormURL(url: String ,dataOfUsers: @escaping ([User]) -> () ){
        guard let url = URL(string: url) else {return}
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url) { data, urlresponse, error in
            
            
            guard let data = data else {return}
            let users = try? JSONDecoder().decode([User].self, from: data)
            
            dataOfUsers(users!)
            
        }.resume()
    }
    
    //MARK: - dataFromFile
    
    func dataFromFile(parsingFile: String, dataOfUsers: @escaping ([User]) -> () ){
        
        guard let jsonFile = Bundle.main.url(forResource: parsingFile, withExtension: "json") else { return }
        do {
            let data =  try Data(contentsOf: jsonFile)
            let users = try JSONDecoder().decode([User].self, from: data)
            dataOfUsers(users)
        }catch{
            print(error)
        }
        
    }
    
    //MARK: - allData
    
        // we combine all data witch we have into special type
        // images + user data
    
    
    func allData(dataOfUsers: @escaping ([Usersdatabase]) -> ()){
        var parsingFile = ""
        let newNextIndex =  Int.random(in: 0..<4)
        switch newNextIndex {
        case 1: parsingFile = "first"
        case 2: parsingFile = "second"
        case 3: parsingFile = "third"
        default: parsingFile = "defolt"
        }
        print(newNextIndex)
        var myDB = [Usersdatabase]()
        dataFromFile(parsingFile: parsingFile) { allUsers in
            
            for i in 0..<allUsers.count{
                if let imageURL = URL(string: allUsers[i].picture){
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data{
                        let image = UIImage(data: data) ?? UIImage(systemName: "list.bullet" )
                        let userdb = Usersdatabase(user: allUsers[i], image: image!)
                        myDB.append(userdb)
                        dataOfUsers(myDB)
                    }
                    
                }
                
            }
            
        }
        
    }
}
