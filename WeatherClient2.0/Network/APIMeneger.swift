//
//  APIMeneger.swift
//  WeatherClient2.0
//
//  Created by Danil Komarov on 11.06.2023.
//

import Foundation

struct APIMeneger {
    
    func weatherAPI(latitude: Double, longitude: Double, completion: @escaping(Weather)-> Void) {
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("7c92b3d3-46ec-4514-899e-6ae9ef4e93fc", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print(String(describing: error))
                return
            }
//            print(String(data: data, encoding: .utf8)!)
            if let weather = self.parseJSON(withData: data){
                completion(weather)
            }
        }
        task.resume()
        
    }
    
    func parseJSON(withData data: Data) -> Weather? {
        do {
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            guard let weather = Weather(weatherData: weatherData) else {
                return nil
            }
            return weather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
