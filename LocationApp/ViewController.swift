//
//  ViewController.swift
//  LocationApp
//
//  Created by Tobias Ruano on 27/7/18.
//  Copyright © 2018 Tobias Ruano. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    let manager = CLLocationManager()
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var ButtonTraillingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var ButtonleadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var HambView: UIView!
    var menuShowing = false
    @IBOutlet weak var showMenu: UIButton!
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    var lugar = ""
    var longitud = CLLocationDegrees()
    var latitud = CLLocationDegrees()
    var fetchedLocation = CLLocation()
    
    @IBOutlet weak var addNewPlaceButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        style()
    }

    @IBAction func updateLocation(_ sender: UIButton) {
        //Taptic feedback
        let generator = UIImpactFeedbackGenerator()
        generator.impactOccurred()
        
        setMap(longitud, latitud)
        locationLabel.text = lugar
        lugar = ""
    }
    
    func style() {
        nameView.layer.cornerRadius = 8
        nameView.layer.shadowColor = UIColor.gray.cgColor
        nameView.layer.shadowOffset = CGSize(width: 0, height: 0)
        nameView.layer.shadowOpacity = 10
        
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 10
        
        HambView.layer.cornerRadius = 8
        
        sideMenuView.layer.cornerRadius = 8
        sideMenuView.layer.shadowColor = UIColor.gray.cgColor
        sideMenuView.layer.shadowOffset = CGSize(width: 0, height: 0)
        sideMenuView.layer.shadowOpacity = 10
        
        settingsButton.layer.cornerRadius = 8
        addNewPlaceButton.layer.cornerRadius = 8
        
        backgroundView.alpha = 0
    }
    
    func fetchCityAndCountry(location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        fetchCityAndCountry(location: location) { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            //print(city + ", " + country)
            self.lugar = city + ", " + country
            print(self.lugar)
        }
        
        self.longitud = location.coordinate.longitude
        self.latitud = location.coordinate.latitude
        fetchedLocation = location
    }
    
    func setMap(_ longitud: CLLocationDegrees, _ latitud: CLLocationDegrees) {
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitud, longitud)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
    }
    

    @IBAction func showMenu(_ sender: UIButton) {
        
        if (menuShowing) {
            self.sideMenuLeadingConstraint.constant = -250
            
            UIView.animate(withDuration: 0.2) {
                self.backgroundView.alpha = 0
                self.view.layoutIfNeeded()
            }
        } else {
            self.sideMenuLeadingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.2) {
                self.backgroundView.alpha = 0.6
                self.view.layoutIfNeeded()
            }
        }
        
        menuShowing = !menuShowing
        //Taptic feedback
        let generator = UIImpactFeedbackGenerator()
        generator.impactOccurred()
    }
}

