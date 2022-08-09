//
//  ViewController.swift
//  Simple Weather
//
//  Created by p h on 05.08.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    private lazy var weekForecasts: [Daily] = []
    private lazy var days: [String] = []
    lazy var latitude: CLLocationDegrees = 52.9
    lazy var longitude: CLLocationDegrees = 27.6
    lazy var city: String = "\(String(TimeZone.current.identifier))"
    lazy var timezone: String = "\(String(TimeZone.current.identifier))"
    
    // MARK: - Outlets
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var degrees: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var weekForecast: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var sunriseImageView: UIImageView!
    @IBOutlet weak var sunsetImageView: UIImageView!
    @IBOutlet weak var humidityWindView: UIView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getValues()
        DispatchQueue.global(qos: .default).async { [weak self] in
            self?.weekForecast.backgroundColor = .clear
            self?.weekForecast.separatorColor = .lightGray
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.weekForecast.delegate = self
            self?.weekForecast.dataSource = self
        }
        
        DispatchQueue.global(qos: .default).async { [weak self] in
            self?.locationManager.delegate = self
            self?.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self?.locationManager.requestLocation()
        }
    }
    
    // MARK: - Funcs
    private func getValues() {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m,relativehumidity_2m,weathercode,windspeed_10m&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,windspeed_10m_max&windspeed_unit=ms&timezone=\(timezone.replacingOccurrences(of: "/", with: "%2F"))") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let weatherInfo = try JSONDecoder().decode(Weather.self, from: data)
                    DispatchQueue.main.async {
                        self.setupUI(data: weatherInfo)
                    }
                    self.weekForecasts = [weatherInfo.daily]
                    self.days = weatherInfo.daily.time
                } catch {
                    print(error)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private func setupUI(data: Weather) {
        let city = self.city
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0, 1, 2, 3, 4, 22, 23:
            getBlur(UIView: backgroundImageView, blurIsOn: false)
        default:
            getBlur(UIView: backgroundImageView, blurIsOn: true)
        }
        let degrees = Int(data.hourly.temperature[hour])
        let humidity = Int(data.hourly.humidity[hour])
        let windSpeed = Int(data.hourly.windspeed[hour])
        self.cityName.text = "\(city)"
        self.degrees.text = "\(degrees)\(data.hourlyUnits.temperature)"
        self.humidity.text = "Current humidity: \(humidity)\(data.hourlyUnits.humidity)"
        self.windSpeed.text = "Current wind speed: \(windSpeed) \(data.hourlyUnits.windspeed)"
        sunriseImageView.image = UIImage(systemName: "sunrise.fill")
        sunsetImageView.image = UIImage(systemName: "sunset.fill")
        weekForecast.showsVerticalScrollIndicator = false
        humidityWindView.layer.cornerRadius = 30
        weekForecast.layer.cornerRadius = 30
        if let image = UIImage(named: "gradient2") {
            humidityWindView.backgroundColor = UIColor(patternImage: image)
        }
        weekForecast.reloadData()
        setImageView(weathercode: data.hourly.weathercode[hour], weatherImage: backgroundImageView, string: "background ")
        formatDate(dateString: data.daily.sunrise[0], label: sunrise, dateFormat1: "yyyy-MM-dd'T'HH:mm", dateFormat2: ": HH:mm")
        formatDate(dateString: data.daily.sunset[0], label: sunset, dateFormat1: "yyyy-MM-dd'T'HH:mm", dateFormat2: ": HH:mm")
        setupNib()
    }
    
    private func setupNib() {
        let cell = UINib(nibName: CellWeekForecast.xib, bundle: nil)
        weekForecast.register(cell, forCellReuseIdentifier: CellWeekForecast.reuseIdentifier)
    }
    
    private func setImageView(weathercode: Int, weatherImage: UIImageView, string: String) {
        switch weathercode {
        case 0:
            weatherImage.image = UIImage(named: "\(string)clear")
        case 1, 2, 3:
            weatherImage.image = UIImage(named: "\(string)partly cloudy")
        case 45, 48:
            weatherImage.image = UIImage(named: "\(string)foggy")
        case 51, 53, 55, 56, 57, 61, 63, 65, 66, 67, 80, 81, 82:
            weatherImage.image = UIImage(named: "\(string)rain")
        case 71, 73, 75, 77, 85, 86:
            weatherImage.image = UIImage(named: "\(string)snow")
        case 95, 96, 99:
            weatherImage.image = UIImage(named: "\(string)thunderstorm")
        default:
            weatherImage.image = UIImage(named: "\(string)clear")
        }
    }
    
    private func getBlur(UIView: UIView, blurIsOn: Bool) {
        switch blurIsOn {
        case true:
            for view in UIView.subviews {
                if let view = view as? UIVisualEffectView {
                    view.removeFromSuperview()
                }
            }
        case false:
            var blurEffectView = UIVisualEffectView()
            let blurEffect = UIBlurEffect(style: .dark)
            blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = UIView.bounds
            UIView.addSubview(blurEffectView)
        }
    }
    
    private func formatDate(dateString: String, label: UILabel, dateFormat1: String, dateFormat2: String) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_us")
        formatter.dateFormat = dateFormat1
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = dateFormat2
            let weekDay = formatter.string(from: date)
            label.text = "\(weekDay)"
        }
    }
}

// MARK: - Extensions
extension ViewController: UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let day = weekForecasts[0]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellWeekForecast.reuseIdentifier, for: indexPath) as? CellWeekForecast else { return UITableViewCell() }
        cell.backgroundColor = .clear
        setImageView(weathercode: day.weathercode[indexPath.row], weatherImage: cell.weatherImage, string: "")
        switch indexPath.row {
        case 0:
            cell.weekDay.text = "Today"
        default:
            formatDate(dateString: days[indexPath.row], label: cell.weekDay, dateFormat1: "yyyy-MM-dd", dateFormat2: "EEEE")
        }
        cell.minTemp.text = "\(Int(day.temperatureMin[indexPath.row]))°C"
        cell.maxTemp.text = "\(Int(day.temperatureMax[indexPath.row]))°C"
        if let image = UIImage(named: "gradient2") {
            cell.backgroundColor = UIColor(patternImage: image)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
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
        if let location = locations.last {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
        }
    }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
        }
}
