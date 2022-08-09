//
//  InitialViewController.swift
//  Simple Weather
//
//  Created by p h on 05.08.2022.
//

import Foundation
import UIKit
import CoreLocation

class Initial: UIViewController {
    
    // MARK: - Properties
    private let cities: [[String]:[Double]] = [["Moscow, RU", "Europe/Moscow"]: [55.751244, 37.618423],
                                               ["Minsk, BY", "Europe/Moscow"]: [53.893009, 27.567444],
                                               ["Saint Petersburg, RU", "Europe/Minsk"]: [59.937500, 30.308611],
                                               ["Wellington, NZ", "Pacific/Auckland"]: [-41.276825, 174.777969],
                                               ["London, GB", "Europe/London"]: [51.509865, -0.118092],
                                               ["Berlin, DE", "Europe/Berlin"]: [52.520008, 13.404954],
                                               ["Paris, FR", "Europe/Berlin"]: [48.864716, 2.349014],
                                               ["Istanbul, TR", "Europe/Moscow"]: [41.015137, 28.979530],
                                               ["Madrid, ES", "Europe/Berlin"]: [40.416775, -3.703790]]
    private let locationManager = CLLocationManager()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var labelMyLocation: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNib()
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Funcs
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        if let image = UIImage(named: "gradient") {
            tableView.backgroundView = UIImageView(image: image)
            label.backgroundColor = UIColor(patternImage: image)
            labelMyLocation.backgroundColor = UIColor(patternImage: image)
        }
        view.backgroundColor = #colorLiteral(red: 0.8237888195, green: 0.9884701204, blue: 1, alpha: 1)
        label.text = "Choose city to show weather:"
        labelMyLocation.text = "My location"
        labelMyLocation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapMyLocation)))
        label.clipsToBounds = true
        labelMyLocation.clipsToBounds = true
        let outlets = [tableView, label, blackView, labelMyLocation]
        outlets.forEach{ $0?.layer.cornerRadius = 30 }
    }
    
    @objc private func didTapMyLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestLocation()
    }
    
    private func setupNib() {
        let cell = UINib(nibName: InitialCell.reuseIdentifier, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: InitialCell.reuseIdentifier)
    }
}

// MARK: - Extensions
extension Initial: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InitialCell.reuseIdentifier, for: indexPath) as? InitialCell else { return UITableViewCell() }
        let key = Array(cities.keys)[indexPath.row]
        cell.cityLabel?.text = key[0]
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherVC") as? ViewController else { return }
        let value = Array(cities.values)[indexPath.row]
        let key = Array(cities.keys)[indexPath.row]
        viewController.city = key[0]
        viewController.timezone = key[1]
        viewController.latitude = value[0]
        viewController.longitude = value[1]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension Initial: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            manager.startUpdatingLocation()
            print("authorizedAlways")
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
            print("authorizedWhenInUse")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach { location in
            guard let viewController = storyboard?.instantiateViewController(withIdentifier: "WeatherVC") as? ViewController else { return }
            viewController.latitude = location.coordinate.latitude
            viewController.longitude = location.coordinate.latitude
            viewController.timezone = String(TimeZone.current.identifier)
            viewController.city = String(TimeZone.current.identifier)
            self.navigationController?.pushViewController(viewController, animated: true)
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
