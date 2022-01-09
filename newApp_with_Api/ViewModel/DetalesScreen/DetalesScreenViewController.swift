//
//  DetalesScreenViewController.swift
//  newApp_with_Api
//
//  Created by Temur on 07/01/2022.
//

import UIKit
import MapKit

class DetalesScreenViewController: UIViewController {
    var user = [Usersdatabase]()
    
    @IBOutlet weak var AvatarImage: UIImageView!
    @IBOutlet weak var CompanyLable: UILabel!
    @IBOutlet weak var EyesLable: UILabel!
    @IBOutlet weak var OnleneLable: UILabel!
    @IBOutlet weak var DateLable: UILabel!
    @IBOutlet weak var GenderLable: UILabel!
    @IBOutlet weak var AboutLable: UITextView!
    @IBOutlet weak var locationMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("workc")
        initView()
        mapPick()
            
    }
    
    func initView(){
        let user = user[0]
        navigationItem.title = user.user.name
        AvatarImage.image = user.image
        CompanyLable.text = user.user.company
        EyesLable.text = user.user.eyeColor
        OnleneLable.text = "online \(user.user.isActive)"
        DateLable.text = user.user.phone
        GenderLable.text = user.user.gender
        AboutLable.text = user.user.about
    }
    
    func mapPick(){
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: user[0].user.latitude, longitude: user[0].user.longitude)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        annotation.title = user[0].user.name
        annotation.subtitle = user[0].user.address
        locationMap.addAnnotation(annotation)
        locationMap.setRegion(region, animated: true)
    }

}
