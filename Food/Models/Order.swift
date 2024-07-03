//
//  Order.swift
//  Food
//
//  Created by APPLE on 11/07/2023.
//

import Foundation

struct Orders:Decodable {
    
    let id: String?
    let name: String?
    let dish : Dishes?
}
