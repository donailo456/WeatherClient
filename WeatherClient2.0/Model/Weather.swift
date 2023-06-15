//
//  Weather.swift
//  WeatherClient2.0
//
//  Created by Danil Komarov on 11.06.2023.
//

import Foundation

struct Weather {
    var name: String = "Идет загрузки"
    var temperature: Double = 0.0
    var temperatureString: String {
        return String(temperature)
    }
    var conditionCode: String = ""
    var url: String = ""
    var condition: String = ""
    var pressureMm: Int = 0
    var windSpeed: Double = 0.0
    var tempMin: Int = 0
    var tempMax: Int = 0
    
    var conditionString: String {
        switch condition {
        case "clear" : return "Ясно"
        case "partly-cloudy" : return "Малооблачно"
        case "cloudy" : return " Облачно с прояснениями"
        case "overcast" : return "Пасмурно"
            
        default:
            return "Загрузка..."
        }
    }
    
    init?(weatherData: WeatherData) {
        temperature = weatherData.fact.temp
        conditionCode = weatherData.fact.icon
        url = weatherData.info.url
        condition = weatherData.fact.condition
        pressureMm = weatherData.fact.pressureMm
        windSpeed = weatherData.fact.windSpeed
        tempMin = weatherData.forecasts.first!.parts.day.tempMin!
        tempMax = weatherData.forecasts.first!.parts.day.tempMax!
    }
    init() {
        
    }
}
