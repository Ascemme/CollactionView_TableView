//
//  SettingsViewController.swift
//  newApp_with_Api
//
//  Created by Temur on 08/01/2022.
//

import UIKit

class SettingsViewController: UIViewController {
   
    var sorting: Int?
    var searchType:Bool = true
    var searcgActivity:Bool = true
    var Maxview = UIView()
    var btnSorting1 = UIButton()
    var btnlable1 = UILabel()
    var btnSorting2 = UIButton()
    var btnlable2 = UILabel()
    var searchSettingsData: ((Bool, Bool) -> ())?
    var btnActin = UIButton()
    var btnlable3 = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Maxview.frame = CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: view.frame.height / 2)
        self.Maxview.backgroundColor = UIColor.white
        self.Maxview.layer.masksToBounds = true
        self.Maxview.layer.cornerRadius = 10
        self.Maxview.layer.borderWidth = 0.1
        self.view.addSubview(Maxview)
        createDesplay()
    }
    
    func createDesplay(){
        //first batoon
        self.btnSorting1.frame = CGRect(x: 100, y: 60, width: 20, height: 20)
        self.btnSorting1.backgroundColor = UIColor.white
        self.btnSorting1.layer.masksToBounds = true
        self.btnSorting1.layer.cornerRadius = 10
        self.btnSorting1.layer.borderWidth = 3
        self.btnSorting1.layer.borderColor = CGColor(red: 94/255, green: 54/255, blue: 245/255, alpha: 1)
        self.btnSorting1.addTarget(self, action: #selector(btnAction1), for: .touchUpInside)
        self.Maxview.addSubview(btnSorting1)
        // second batton
        self.btnSorting2.frame = CGRect(x: 100, y: 90, width: 20, height: 20)
        self.btnSorting2.backgroundColor = UIColor.white
        self.btnSorting2.layer.masksToBounds = false
        self.btnSorting2.layer.cornerRadius = 10
        self.btnSorting2.layer.borderWidth = 3
        self.btnSorting2.layer.borderColor = CGColor(red: 94/255, green: 54/255, blue: 245/255, alpha: 1)
        self.btnSorting2.addTarget(self, action: #selector(btnAction2), for: .touchUpInside)
        self.Maxview.addSubview(btnSorting2)
        //lablse
        btnlable1.frame = CGRect(x: 130, y: 60, width: 150, height: 20)
        btnlable1.textColor = UIColor.black
        btnlable1.text = "По возрасту"
        Maxview.addSubview(btnlable1)
        
        btnlable2.frame = CGRect(x: 130, y: 90, width: 150, height: 20)
        btnlable2.textColor = UIColor.black
        btnlable2.text = "По полу"
        Maxview.addSubview(btnlable2)
        
        self.btnActin.frame = CGRect(x: 310, y: 30, width: 20, height: 20)
        self.btnActin.backgroundColor = UIColor.white
        self.btnActin.layer.masksToBounds = false
        self.btnActin.layer.cornerRadius = 10
        self.btnActin.layer.borderWidth = 3
        self.btnActin.layer.borderColor = CGColor(red: 94/255, green: 54/255, blue: 245/255, alpha: 1)
        self.btnActin.addTarget(self, action: #selector(btnAction3), for: .touchUpInside)
        self.Maxview.addSubview(btnActin)
        
        btnlable3.frame = CGRect(x: 200, y: 30, width: 150, height: 20)
        btnlable3.textColor = UIColor.black
        btnlable3.text = "Сортировка"
        Maxview.addSubview(btnlable3)
        if searcgActivity{
            self.btnActin.layer.borderWidth = 7
            if searchType{
                self.btnSorting1.layer.borderWidth = 7
                self.btnSorting2.layer.borderWidth = 3

            }else{
                self.btnSorting1.layer.borderWidth = 3
                self.btnSorting2.layer.borderWidth = 7
            }
        }else{
            self.btnActin.layer.borderWidth = 3
        }
        
        
        
        
        
    }
    
    
    @objc func btnAction1(){
        self.btnSorting1.layer.borderWidth = 7
        self.btnSorting2.layer.borderWidth = 3
        self.searchType = true
        searchSettingsData?(searcgActivity, searchType)
    }
    @objc func btnAction2(){
        self.btnSorting1.layer.borderWidth = 3
        self.btnSorting2.layer.borderWidth = 7
        self.searchType = false
        searchSettingsData?(searcgActivity, searchType)
    }
    @objc func btnAction3(){
        if searcgActivity{
            self.btnActin.layer.borderWidth = 3
            self.searcgActivity = false
            searchSettingsData?(searcgActivity, searchType)
        }else{
            self.btnActin.layer.borderWidth = 7
            self.searcgActivity = true
            searchSettingsData?(searcgActivity, searchType)
        }
    }

}
