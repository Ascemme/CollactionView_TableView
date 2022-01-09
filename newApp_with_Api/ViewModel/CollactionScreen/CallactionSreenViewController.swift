//
//  CallactionSreenViewController.swift
//  newApp_with_Api
//
//  Created by Temur on 07/01/2022.
//

import UIKit

class CallactionSreenViewController: UIViewController {

    @IBOutlet weak var CustomCallactionView: UICollectionView!
    
    let searchController = UISearchController()
    var users = [Usersdatabase]()
    var dbUsers = [Usersdatabase]()
    var searchType: Bool = true
    var searchActive: Bool = false
    var isDataloalding = false
    var mySpiner =  SpinerView()
    
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
                self.CustomCallactionView.reloadData()
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
        CustomCallactionView.delegate = self
        CustomCallactionView.dataSource = self
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
            myUser.append(users[(CustomCallactionView.indexPathsForSelectedItems?.first!.row)!])
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
                self.CustomCallactionView.reloadData()
            }
        }
        
    }
    
}


extension CallactionSreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searcher = SearchFilter()
        let searchBar = searchController.searchBar
        users = searcher.filterContentForSearchText(searchBar: searchBar.text!, dbUsers: dbUsers, setting: sortingFunctins())
        self.CustomCallactionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CustomCallactionView.dequeueReusableCell(withReuseIdentifier: "CellCollactionView", for: indexPath) as! CustomCollectionViewCell
        cell.NameLablel.text = users[indexPath.row].user.name
        cell.AvatarImage.image = users[indexPath.row].image
        cell.AgeLable.text = String(users[indexPath.row].user.age )
        cell.GenderLLabel.text = users[indexPath.row].user.gender
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detales", sender: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isDataloalding {
        var insets = CustomCallactionView.contentInset
        if(scrollView.contentOffset.y < -1 && CustomCallactionView.isDragging){
        let frame = CGRect(x: 0, y: -50, width: CustomCallactionView.bounds.size.width, height: SpinerView.defaultHeight)
        mySpiner.frame = frame
            mySpiner.isHidden = true
            CustomCallactionView.addSubview(mySpiner)
        mySpiner.startAnimating()
        insets.top += SpinerView.defaultHeight
            isDataloalding = true
            CustomCallactionView.contentInset = insets
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {[self] timer in
                    loalding()
                    mySpiner.stopAnimating()
                    self.CustomCallactionView.contentInset.top -= SpinerView.defaultHeight
                    isDataloalding = false
            }
        }
    }
    
    }

}
