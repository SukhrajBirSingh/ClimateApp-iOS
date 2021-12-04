
import Foundation

struct WeatherModal {
    let conditionId : Int
    let cityName : String
    let temperature : Double
    let description : String
    
    var descriptionCapital : String {
        return String(description.capitalized)
    }
    
    var temperatureString : String {
        return String(format: "%.1f", temperature)
    }
    
    
    
    var conditionName : String {   //computed property 
        switch conditionId {
        case 200...202: //range operator
            return "cloud.bolt.rain"
        case 210...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...501:
            return "cloud.rain"
        case 502...504:
            return "cloud.heavyrain"
        case 511:
            return "cloud.hail"
        case 520...531:
            return "cloud.rain"
        case 600...602:
            return "cloud.snow"
        case 611...616:
            return "cloud.sleet"
        case 620...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
            
        default:
            return "cloud"
        }
    }
    
    
}
