//
//  WeatherManager.swift
//  WeatherChallenge
//
//  Created by Nicholas Gilbert on 10/2/23.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=86cd039c2d5079ccd08bdbae63647ffb&units=imperial"
    
    let iconURL = "https://api.openweathermap.org/data/2.5/weather?q="
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let arraySubstring = cityName.components(separatedBy: " ")
        let cityName2 = arraySubstring.joined(separator: "+")
        let urlString = "\(weatherURL)&q=\(cityName2)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //Create a URL
        if let url = URL(string: urlString){
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON( safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4. Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            print(decodedData.weather[0].icon)
            let temp = decodedData.main.temp
            let name = decodedData.name
            let icon = decodedData.weather[0].icon
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, icon: icon)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
