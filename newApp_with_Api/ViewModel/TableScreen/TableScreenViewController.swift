//
//  TableScreenViewController.swift
//  newApp_with_Api
//
//  Created by Temur on 07/01/2022.
//

import UIKit

class TableScreenViewController: UIViewController {
    
    @IBOutlet weak var CustomTableView: UITableView!
    
    var isDataloalding = false
    var mySpiner =  SpinerView()
    let searchController = UISearchController()
    var users = [Usersdatabase]()
    var dbUsers = [Usersdatabase]()
    var searchType: Bool = true
    var searchActive: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        loalding()
        
    }
    func loalding(){
        let parser = Parser()
        DispatchQueue.main.async {
            parser.allData { db in
                self.dbUsers = db
                self.users = db
                self.CustomTableView.reloadData()
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if navigationItem.searchController == nil {
            navigationItem.searchController = searchController
        }
    }
    
    
    
    func initView(){
        navigationController?.navigationItem.searchController = searchController
        CustomTableView.delegate = self
        CustomTableView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: "list.bullet.indent" ), for: UISearchBar.Icon.bookmark, state: .normal)
        searchController.hidesNavigationBarDuringPresentation = true
        //searchController.obscuresBackgroundDuringPresentation = true
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "TableView"
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        //self.navigationController?.showDetailViewController(SettingsViewController(), sender: true)
        //let sertw = self.present(SettingsViewController(), animated: true)
        //self.showDetailViewController(SettingsViewController(), sender: self)
        performSegue(withIdentifier: "searchSettings", sender: self)
        
    }
    
    func sortingFunctins() -> (Int){
        if searchActive{
            if searchType{
                return 1
            }
            return 2
        }
        return 0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detales"{
            guard let destination = segue.destination as? DetalesScreenViewController else { return }
            var myUser = [Usersdatabase]()
            myUser.append(users[CustomTableView.indexPathForSelectedRow!.row])
            destination.user = myUser
        }
        if segue.identifier == "searchSettings"{
            guard let destination = segue.destination as? SettingsViewController else { return }
            destination.searcgActivity = searchActive
            destination.searchType = searchType
            destination.searchSettingsData = {[self] actyvity, sType in
                searchType = sType
                searchActive = actyvity
                users = SearchFilter().filterContentForSearchText(searchBar:"", dbUsers: dbUsers, setting: sortingFunctins())
                self.CustomTableView.reloadData()
            }
        }
        
    }
    
    
}


extension TableScreenViewController: UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UINavigationBarDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableView.dequeueReusableCell(withIdentifier: "CellTableView", for: indexPath) as! CustomTableViewCell
        
        cell.CellNameLable.text = users[indexPath.row].user.name
        cell.CellImage.image = users[indexPath.row].image
        cell.CellAgeLable.text = String(users[indexPath.row].user.age )
        cell.CellSexLabele.text = users[indexPath.row].user.gender
        return cell
    }
    
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searcher = SearchFilter()
        let searchBar = searchController.searchBar
        users = searcher.filterContentForSearchText(searchBar: searchBar.text!, dbUsers: dbUsers, setting: sortingFunctins())
        self.CustomTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detales", sender: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isDataloalding {
        var insets = CustomTableView.contentInset
        if(scrollView.contentOffset.y < -1 && CustomTableView.isDragging){
        let frame = CGRect(x: 0, y: -50, width: CustomTableView.bounds.size.width, height: SpinerView.defaultHeight)
        mySpiner.frame = frame
            mySpiner.isHidden = true
            CustomTableView.addSubview(mySpiner)
        mySpiner.startAnimating()
        insets.top += SpinerView.defaultHeight
            isDataloalding = true
        CustomTableView.contentInset = insets
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {[self] timer in
                    loalding()
                    mySpiner.stopAnimating()
                    self.CustomTableView.contentInset.top -= SpinerView.defaultHeight
                    isDataloalding = false
            }
        }
    }
    
    }
}
