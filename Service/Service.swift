import Foundation

protocol ApiClientProtocol {
    func getElephants(baseUrl: String, endpoint: ApiEndpoints, completion: @escaping ([Elephant]?, Error?) -> Void)
}

enum ApiEndpoints: String {
    case baseEndpointUrl = "http://elephant-api.herokuapp.com/"
    case allElephants = "elephants"
    case randomElephant = "random"
}

class ApiService: ApiClientProtocol {
    
    func getElephants(baseUrl: String, endpoint: ApiEndpoints, completion: @escaping ([Elephant]?, Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(endpoint.rawValue)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == StatusCode.success200.rawValue {
                guard let data = data else { return }
                do {
                    let elephants = try JSONDecoder().decode([Elephant].self, from: data)
                        completion(elephants, nil)
                } catch {
                        completion(nil, error)
                }
            }
        }.resume()
    }
    
}
