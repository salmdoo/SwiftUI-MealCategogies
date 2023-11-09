//
//  NetworkError.swift
//  DessertCategory
//
//  Created by Salmdo on 11/8/23.
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
