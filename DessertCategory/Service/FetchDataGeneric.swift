//
//  FetchDataProtocol.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import Foundation


protocol DecodeDataProtocol: Decodable {
    associatedtype T
    static func decodeData(data: Data) -> Result<T, NetworkError>
}

struct FetchDataGeneric<T> where T: DecodeDataProtocol {
    private let urlSession: URLSession?
    private let urlApi: String
    
    init(urlSession: URLSession, urlApi: String) {
        self.urlSession = urlSession
        self.urlApi = urlApi
    }
    
    func fetchData() async -> Result<T?, NetworkError> {
        guard let url = URL(string: urlApi) else {
            return Result.failure(NetworkError.invalidUrl)
        }
        
        if let (data, _) = try? await urlSession?.data(from: url) {
            let decodedData = T.decodeData(data: data)
            switch decodedData {
            case .success(let res):
                return Result.success(res as? T)
            case .failure(let err):
                return Result.failure(err)
            }
        } else {
            return Result.failure(NetworkError.dataNotFound)
        }
    }
}
