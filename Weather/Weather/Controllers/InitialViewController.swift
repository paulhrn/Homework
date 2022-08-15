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
    private let cities: [[String]:[CLLocationDegrees]] = [["\(L10n.moscow), RU", "Europe/Moscow"]: [55.751244, 37.618423],
                                                          ["\(L10n.minsk), BY", "Europe/Moscow"]: [53.893009, 27.567444],
                                                          ["\(L10n.saintPetersburg), RU", "Europe/Minsk"]: [59.937500, 30.308611],
                                                          ["\(L10n.wellington), NZ", "Pacific/Auckland"]: [-41.276825, 174.777969],
                                                          ["\(L10n.london), GB", "Europe/London"]: [51.509865, -0.118092],
                                                          ["\(L10n.berlin), DE", "Europe/Berlin"]: [52.520008, 13.404954],
                                                          ["\(L10n.paris), FR", "Europe/Berlin"]: [48.864716, 2.349014],
                                                          ["\(L10n.istanbul), TR", "Europe/Moscow"]: [41.015137, 28.979530],
                                                          ["\(L10n.madrid), ES", "Europe/Berlin"]: [40.416775, -3.703790]]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var labelMyLocation: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNib()
    }
    
    // MARK: - Funcs
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        if let image = UIImage(named: "gradient") {
            tableView.backgroundView = UIImageView(image: image)
            label.backgroundColor = UIColor(patternImage: image)
            labelMyLocation.backgroundColor = UIColor(patternImage: image)
        }
        view.backgroundColor = #colorLiteral(red: 0.8237888195, green: 0.9884701204, blue: 1, alpha: 1)
        label.text = L10n.chooseCity
        labelMyLocation.text = L10n.myLocation
        labelMyLocation.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapMyLocation)))
        label.clipsToBounds = true
        labelMyLocation.clipsToBounds = true
        let outlets = [tableView, label, blackView, labelMyLocation]
        outlets.forEach{ $0?.layer.cornerRadius = 30 }
    }
    
    @objc private func didTapMyLocation() {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "WeatherVC") as? ViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
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
