
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager, weather: WeatherModal)
    func didFailWithError(error : Error)
    }


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=(YOUR API KEY)"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName:String)  {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude : CLLocationDegrees   , longitude : CLLocationDegrees) {
        
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString )
    }
    
    func performRequest (with urlString : String) {
        
        //1. create url
        if let url = URL(string: urlString){
       
        //2. create url session
        let session = URLSession(configuration: .default)
       
        //3. give session a task
            let task =   session.dataTask(with: url) { data, response, error in //closure syntx way
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData =  data {
                    
                    if  let weather =   self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather:weather)
                    }// passing weather object to viewcontroller
                }
            }
        
        //4.start the task
        task.resume()
        }
    }
    
    func parseJSON(_ weatherData : Data) -> WeatherModal? {
        
        let decorder = JSONDecoder()
        
        do {
       let decodedData = try decorder.decode(WeatherData.self, from: weatherData)
            let id  =  decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather[0].description
            let weather = WeatherModal(conditionId: id, cityName: name, temperature: temp, description: description)
           
            return weather
          
           
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    
}
