//
//  String+extention.swift
//  Food
//
//  Created by APPLE on 16/05/2023.
//

import Foundation
import Kingfisher

extension String {
    
    var asUrl : URL? {
        return URL(string: self)
    }
}
