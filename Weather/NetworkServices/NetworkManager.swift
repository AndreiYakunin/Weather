import Foundation

class NetworkManager {
    
    static let shared : NetworkManager = NetworkManager()
    
    func getWeather(city: String, result: @escaping (_ params: Params) -> ()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme.rawValue
        urlComponents.host = Constants.host.rawValue
        urlComponents.path = Constants.path.rawValue
        
        let queryItemQuery = URLQueryItem(name: "q", value: city)
        let queryItemToken = URLQueryItem(name: "appid",
                                          value: Constants.appid.rawValue)
        let queryItemUnits = URLQueryItem(name: "units", value: Constants.units.rawValue)
        
        urlComponents.queryItems = [queryItemQuery, queryItemToken, queryItemUnits]
        
        guard let url = urlComponents.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard error == nil else {
                print(NetworkError.missingURL)
                return
            }
            
            guard let data = data else { return }
            let decoderParams = try? JSONDecoder().decode(Params.self, from: data)
            if let decoderParams = decoderParams {
                result(decoderParams)
            } else {
                print(NetworkError.parametersNil)
            }
            
        }.resume()
    }
}
