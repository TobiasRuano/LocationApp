//
//  SideMenuTableViewController.swift
//  LocationApp
//
//  Created by Tobias Ruano on 28/7/18.
//  Copyright © 2018 Tobias Ruano. All rights reserved.
//

import UIKit
import CoreLocation

struct place {
    var name: String
    var latitude: Double
    var longitude: Double
}

class SideMenuTableViewController: UITableViewController {
    
    var countries = [place(name: "Buenos Aires", latitude: -34.603722, longitude: -58.381592), place(name: "New York", latitude: 40.730610, longitude: -73.935242)]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let longitud = countries[indexPath.row].longitude
        let latitud = countries[indexPath.row].latitude
        print(latitud, "," , longitud)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
