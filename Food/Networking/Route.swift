//
//  Route.swift
//  Food
//
//  Created by APPLE on 11/07/2023.
//

import Foundation

enum Route {
    
    static let baseUrl = "https://yummie.glitch.me"
    
    case fetchAllCategories
    case placeOrder(String)
    case fetchCateoryDishes(String)
    case fetchOrders
    
    var description: String {
      switch self {
      case .fetchAllCategories:
          return "/dish-categories"
      case .placeOrder(let dishId):
          return "/orders/\(dishId)"
      case .fetchCateoryDishes(let categoryId):
          return "/dishes/\(categoryId)"
      case .fetchOrders:
          return "/orders"
          
      }
  }
}
