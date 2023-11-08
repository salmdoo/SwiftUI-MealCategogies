//
//  MealModel.swift
//  DessertCategory
//
//  Created by Salmdo on 11/6/23.
//

import Foundation

struct Meal: Decodable, Equatable {
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
    
    init(id: String,name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}

struct MealList: Decodable, DecodeDataProtocol, Equatable {
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
    
    static func == (lhs: MealList, rhs: MealList) -> Bool {
        if lhs.meals.count != rhs.meals.count {
            return false
        }
        
        for item in lhs.meals {
            if !rhs.meals.contains(where: {$0 == item}) {
                return false
            }
        }
        return true
    }
}

