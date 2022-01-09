//
//  Parser.swift
//  newApp_with_Api
//
//  Created by Temur on 07/01/2022.
//

import Foundation
import UIKit


struct Parser{
    func dataParserFormURL(url: String ,dataOfUsers: @escaping ([User]) -> () ){
        guard let url = URL(string: url) else {return}
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url) { data, urlresponse, error in
            
            
            guard let data = data else {return}
            let users = try? JSONDecoder().decode([User].self, from: data)
            
            dataOfUsers(users!)
            
        }.resume()
    }
    
    func imagePareser (url: String, image: @escaping (UIImageView) -> ()){
        
    }
    
    
    func dataFromFile(dataOfUsers: @escaping ([User]) -> () ){
        
        guard let jsonFile = Bundle.main.url(forResource: "generated", withExtension: "json") else { return }
        do {
            let data =  try Data(contentsOf: jsonFile)
            let users = try JSONDecoder().decode([User].self, from: data)
            dataOfUsers(users)
        }catch{
            print(error)
        }
        
    }
    
    
    
    func allData(dataOfUsers: @escaping ([Usersdatabase]) -> ()){
        
        var myDB = [Usersdatabase]()
        dataFromFile { allUsers in
            
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
