//
//  CitiesWeather.swift
//  WeatherClient2.0
//
//  Created by Danil Komarov on 12.06.2023.
//

import Foundation
import CoreLocation

let apiMeneger = APIMeneger()

func getCityWeather(citiesArray: [String], complition: @escaping(Int, Weather) -> Void) {
    for (index, item) in citiesArray.enumerated() {
        getCoordinate(city: item) { (coordinate, error) in
            guard let coordinate = coordinate, error == nil else {return}
            apiMeneger.weatherAPI(latitude: coordinate.latitude, longitude: coordinate.longitude) { (weather) in
                complition(index, weather)
            }
        }
    }
}

func getCoordinate(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ){
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
        completion(placemark?.first?.location?.coordinate, error)
    }
    
}
