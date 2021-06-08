//
//  APIModel.swift
//  MyRecipeFinder
//
//  Created by iOS Dev on 6/7/21.
//

import Foundation


// MARK: - AllCategories
struct AllCategories: Codable {
    var categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
}

// MARK: - AllMeals
struct AllMeals: Codable {
    var meals: [Meal]
}

// MARK: - Meal
struct Meal: Codable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
}

// MARK: - MealData
struct MealData: Codable {
    var meals: [[String: String?]]
}

struct DetailMeal: Codable {
    
}
