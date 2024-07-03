//
//  AllDishes.swift
//  Food
//
//  Created by APPLE on 12/07/2023.
//

import Foundation

struct AllDishes : Decodable {
    
    let categories : [DishCategory]?
    let populars : [Dishes]?
    let specials : [Dishes]?
}
