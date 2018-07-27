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
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    var lugar = ""
    var longitud = CLLocationDegrees()
    var latitud = CLLocationDegrees()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

    @IBAction func updateLocation(_ sender: UIButton) {
        setMap(longitud, latitud)
        locationLabel.text = lugar
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
        }
        
        self.longitud = location.coordinate.longitude
        self.latitud = location.coordinate.latitude
        
    }
    
    func setMap(_ longitud: CLLocationDegrees, _ latitud: CLLocationDegrees) {
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitud, longitud)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
    }
    
}

