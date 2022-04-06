import Foundation

struct Params: Decodable {
    let code: String?
    let city: City?
    let message: Double?
    let cnt: Int?
    let list: [List]?
}

struct City: Decodable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
}

struct List: Decodable {
    let dt: Int?
    let temp: Temp?
    let weather: [Weather]?
}

struct Coord: Decodable {
    let lat: Double?
    let lon: Double?
}

struct Temp: Decodable {
    let day: Double?
    let min: Double?
    let max: Double?
}

struct Weather: Decodable {
    let id: Int?
    let description: String?
    let icon: String?
}
