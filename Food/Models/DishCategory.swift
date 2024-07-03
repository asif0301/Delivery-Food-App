//
//  DishCategory.swift
//  Food
//
//  Created by APPLE on 16/05/2023.
//

import Foundation
 
struct DishCategory:Decodable {
    
  let id : String?
  let name: String?
  let image : String?
    
    enum CodingKeys : String,CodingKey {
        
        case id
        case name = "title"
        case image
    }
}
