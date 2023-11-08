//
//  APIEndpoint.swift
//  DessertCategory
//
//  Created by Salmdo on 11/7/23.
//

import Foundation

enum APIEndpoint {
    private static let domain: String = "https://themealdb.com/api/json/v1/1/"
    static let getDeserts: String = "\(APIEndpoint.domain)/filter.php?c=Dessert"
    
    static let getDesertDetails: (String) -> String = { desertId in
        "\(APIEndpoint.domain)/lookup.php?i=\(desertId)"
    }
}
