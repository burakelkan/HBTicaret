//
//  Network.swift
//  HBTicaret
//
//  Created by halil ibrahim Elkan on 27.05.2022.
//

import Foundation

struct Network {
    
    static let cartId: Int = 2
    private let baseUrlString = "http://159.223.0.153/"
    
    func request<T: Decodable>(endpointType: EndpointType, completion: @escaping (Result<T, CustomError>) -> Void) {
        
        let session = URLSession.shared
    
        guard let url = URL(string: baseUrlString + endpointType.endpoint) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpointType.method.rawValue
        
        session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(.failure(CustomError(message: "Gelen Response içerisinde data yok!")))
                return
            }
            
            Logger.log(text: "\(data)")
            
            let decoder = JSONDecoder()
            
            do {
                
                let decodedResponse = try decoder.decode(T.self, from: data)
                completion(.success(decodedResponse))
                
            }
            catch let error {
                completion(.failure(CustomError(message: error.localizedDescription)))
            }
            
        }.resume()
    }
}
