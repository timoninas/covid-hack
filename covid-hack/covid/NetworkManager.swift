
import Foundation

protocol NetworkManagerDescription {
    func loadCountries(completion: ((Timeseries?) -> Void)?)
}

class NetworkManager: NetworkManagerDescription {
    static let shared = NetworkManager()
    
    private init() {}
    
    func loadCountries(completion: ((Timeseries?) -> Void)?) {
        
        let urlString = "https://api.covid19api.com/summary"
        guard let url = URL(string: urlString) else {
            completion?(nil)
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion?(nil)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let covidInfo = try decoder.decode(Timeseries.self, from: data)
                completion?(covidInfo)
            } catch let error {
                print(error.localizedDescription)
                completion?(nil)
            }
        }
        
        dataTask.resume()
    }
    
}
