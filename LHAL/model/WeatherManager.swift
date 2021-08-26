//
//  WeatherManager.swift
//  LHAL
//
//  Created by Home on 8/26/21.
//

import Foundation
import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6916143bfe3fff55ce96dac2d6baf9c9&units=metric"
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(cityName : String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    func fetchWeather(latitude : CLLocationDegrees , longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String) {
        // create URL
        if let url = URL(string: urlString){
            
        
        //Create URLSession
        let session = URLSession(configuration: .default)
        
        //Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
        
            //Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
           let decodedData = try decoder.decode(Weatherdata.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
           
            
            let weather = WeatherModel(conditionId: id, cityName: name , temperature: temp)
            return weather
            
        } catch{
            print(error)
            
            return nil
        }
        
    }

    
   
}
