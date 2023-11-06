//
//  FetchDataProtocol.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case dataNotFound
    case decodedFailed
}

protocol FetchDataProtocol {
    associatedtype T
    func fetchData(urlString: String, completion: @escaping((Result<T?, NetworkError>) -> Void))
    
}

protocol DecodeDataProtocol: Decodable {
    associatedtype T
    static func decodeData(data: Data) -> Result<T, NetworkError>
}

struct FetchDataGeneric<T>: FetchDataProtocol where T: DecodeDataProtocol {
    private let urlSession: URLSession?
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func fetchData(urlString: String, completion: @escaping ((Result<T?, NetworkError>) -> Void)) {
        guard let url = URL(string: urlString) else {
            completion(Result.failure(NetworkError.invalidUrl))
            return
        }
        
        urlSession?.dataTask(with: url, completionHandler: { data, response, err in
            guard let data, err == nil else {
                completion(Result.failure(NetworkError.dataNotFound))
                return
            }
            let decodedData = T.decodeData(data: data)
            switch decodedData {
            case .success(let res):
                completion(.success(res as? T))
            case .failure(let err):
                completion(.failure(err))
            }
            
            
        }).resume()
        
    }
    
    
}
