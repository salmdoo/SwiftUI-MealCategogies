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
extension NetworkError: LocalizedError {
    public var localizedString: String {
        switch self {
        case .dataNotFound:
            return NSLocalizedString("Data not found. Please try later.", comment: "No Data")
        case .decodedFailed, .invalidUrl:
            return NSLocalizedString("Server request failed. Please try later.", comment: "Invalid URL or Failed Decoded Data")
        }
    }
}

protocol FetchDataProtocol {
    associatedtype T
    func fetchData(urlString: String) async -> Result<T?, NetworkError>
    
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
    
    func fetchData(urlString: String) async -> Result<T?, NetworkError> {
        guard let url = URL(string: urlString) else {
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
