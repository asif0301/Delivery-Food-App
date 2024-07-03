//
//  AppError.swift
//  Food
//
//  Created by APPLE on 12/07/2023.
//

import Foundation

enum appError:LocalizedError {
    
case errorDecoding
case unkonwnError
case invalidUrl
case serverError(String)
    
    var errorDescription: String?{
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unkonwnError:
            return "I have no idea what go on"
        case .invalidUrl:
            return "Give me valid a url"
        case .serverError(let error):
            return error
        }
    }
}

