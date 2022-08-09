//
//  WeatherModel.swift
//  Simple Weather
//
//  Created by p h on 05.08.2022.
//

import Foundation
import UIKit

struct Weather: Decodable {
    var latitude: Double
    var longitude: Double
    var hourlyUnits: HourlyUnits
    var hourly: Hourly
    var dailyUnits: DailyUnits
    var daily: Daily
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude, hourly, daily
        case hourlyUnits = "hourly_units"
        case dailyUnits = "daily_units"
    }
}

struct HourlyUnits: Decodable {
    var time: String
    var temperature: String
    var humidity: String
    var weathercode: String
    var windspeed: String
    
    enum CodingKeys: String, CodingKey {
        case time, weathercode
        case temperature = "temperature_2m"
        case humidity = "relativehumidity_2m"
        case windspeed = "windspeed_10m"
    }
}

struct Hourly: Decodable {
    var time: [String]
    var temperature: [Double]
    var humidity: [Int]
    var weathercode: [Int]
    var windspeed: [Double]
    
    enum CodingKeys: String, CodingKey {
        case time, weathercode
        case temperature = "temperature_2m"
        case humidity = "relativehumidity_2m"
        case windspeed = "windspeed_10m"
    }
}

struct DailyUnits: Decodable {
    var time: String
    var weathercode: String
    var temperatureMax: String
    var temperatureMin: String
    var sunrise: String
    var sunset: String
    var windspeed: String
    
    enum CodingKeys: String, CodingKey {
        case time, weathercode, sunrise, sunset
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
        case windspeed = "windspeed_10m_max"
    }
}

struct Daily: Decodable {
    var time: [String]
    var weathercode: [Int]
    var temperatureMax: [Double]
    var temperatureMin: [Double]
    var sunrise: [String]
    var sunset: [String]
    var windspeed: [Double]
    
    enum CodingKeys: String, CodingKey {
        case time, weathercode, sunrise, sunset
        case temperatureMax = "temperature_2m_max"
        case temperatureMin = "temperature_2m_min"
        case windspeed = "windspeed_10m_max"
    }
}

