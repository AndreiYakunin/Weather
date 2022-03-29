import Foundation

class NetworkManager {
    
    static let shared : NetworkManager = NetworkManager()
    
    func getWeather(city: String, cnt: String, result: @escaping ((Params) -> Void)) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast/daily"
        
        let queryItemQuery = URLQueryItem(name: "q", value: city)
        let queryItemCnt = URLQueryItem(name: "cnt", value: cnt)
        let queryItemToken = URLQueryItem(name: "appid",
                                          value: "bd9e45736ac5513dc9cba3f68aa81d3d")
        
        urlComponents.queryItems = [queryItemQuery, queryItemCnt, queryItemToken]
        
        guard let url = urlComponents.url else { return }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                print(NetworkError.missingURL)
                return
            }
            
            var decoderParams: Params?
            guard let data = data else { return }
            decoderParams = try? JSONDecoder().decode(Params.self, from: data)
            if let decoderParams = decoderParams {
                result(decoderParams)
            } else {
                print(NetworkError.parametersNil)
            }
            
        }.resume()
    }
}
