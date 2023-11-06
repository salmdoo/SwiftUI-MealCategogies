//
//  MealModel.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import Foundation

struct Meal: Decodable {
    let name: String?
    let image: String?
    let id: String?
    
    private enum CodingKeys: CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .strMeal)
        self.image = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        self.id = try container.decodeIfPresent(String.self, forKey: .idMeal)
    }
}

struct MealList: Decodable, DecodeDataProtocol {
    typealias T = Self
    
    let meals: [Meal]
    
    static func decodeData(data: Data) -> Result<T, NetworkError> {
        do
        {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return Result.success(decodedData)
        } catch {
            return Result.failure(NetworkError.decodedFailed)
        }
    }
}

