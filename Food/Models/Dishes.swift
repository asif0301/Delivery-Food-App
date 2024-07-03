//
//  Dishes.swift
//  Food
//
//  Created by APPLE on 16/05/2023.
//

import Foundation

struct Dishes:Decodable {
    
    let id :String?
    let name:String?
    let image:String?
    let description: String?
    let calories: Double?
    
    var formattedCalories:String {
//        return String(format: "%2f calories", calories ?? 0 )
        return "\( calories ?? 0 )calories"
    }
}
