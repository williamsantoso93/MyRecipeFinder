//
//  APIModel.swift
//  MyRecipeFinder
//
//  Created by iOS Dev on 6/7/21.
//

//https://www.themealdb.com/api.php

import Foundation


//www.themealdb.com/api/json/v1/1/categories.php
// MARK: - AllCategories
struct AllCategories: Codable {
    var categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    var idCategory, strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String
}

//https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
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

//https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772
// MARK: - MealData
struct MealData: Codable {
    var meals: [[String: String?]]
}
