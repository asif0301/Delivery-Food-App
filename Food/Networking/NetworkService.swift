//
//  NetworkService.swift
//  Food
//
//  Created by APPLE on 11/07/2023.
//

import Foundation

struct NetworkService {
    
    static let shared = NetworkService()
    
    private init(){}

       func placeOrder(dishId: String, name: String, completion: @escaping (Result<Orders, Error>) -> Void) {
           guard let url = URL(string: "\(Route.baseUrl)/orders/item\(dishId)") else {
               completion(.failure(appError.invalidUrl))
               return
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = Method.post.rawValue
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
           let parameters: [String: Any] = [
               "name": name
           ]
           
           do {
               request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
           } catch {
               completion(.failure(error))
               return
           }
           
           let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
               guard let data = data, error == nil else {
                   completion(.failure(error ?? appError.unkonwnError))
                   return
               }
               
               do {
                   let decodedResponse = try JSONDecoder().decode(ApiResponse<Orders>.self, from: data)
                   if let error = decodedResponse.error {
                       completion(.failure(appError.serverError(error)))
                   } else if let order = decodedResponse.data {
                       completion(.success(order))
                   } else {
                       completion(.failure(appError.errorDecoding))
                   }
               } catch {
                   completion(.failure(error))
               }
           }
           
           task.resume()
       }
    
    //    func placeOrder(dishId:String,name:String,completion: @escaping(Result<Orders,Error>) -> Void){
    //        let params = ["name":name]
    //
    //        request(route: .placeOrder(dishId), method: .post, parameters: params, completion: completion)
    //    }

    func fetchAllCategories(completion: @escaping(Result<AllDishes,Error>)->Void) {
        request(route: .fetchAllCategories, method: .get, completion: completion)
    }
    
    func fetchOrder(completion:@escaping(Result<[Orders],Error>)->Void) {
        request(route: .fetchOrders, method: .get, completion: completion)
    }
    
    func fetchCategoryDishes(categoryId:String,completion:@escaping(Result<[Dishes],Error>)->Void) {
        request(route: .fetchCateoryDishes(categoryId), method: .get, completion: completion)
        
    }
    

    
    private func request<T:Decodable>(route:Route,
                                      method:Method,
                                      parameters:[String:Any]? = nil,
                                      completion: @escaping(Result<T,Error>) -> Void){
        guard let request = createRequest(route: route, method: method, parameters: parameters)else {
            completion(.failure(appError.unkonwnError))
            return}
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data,Error>?
            if let data = data {
                result = .success(data)
                let responseString = String(data:data,encoding:.utf8) ?? "could not stringfily our data"
                //  print("This response is: \(responseString)")
            } else if let error = error {
                result = .failure(error)
                print("This error is \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.HandleResponse(result: result, completion: completion)
            }
            
        }.resume()
    }
    
    
    
    
    
    private func HandleResponse<T: Decodable>(result:Result<Data,Error>?,completion:(Result<T,Error>) -> Void) {
        
        guard let result = result else {
            completion(.failure(appError.unkonwnError))
            return
        }
        switch result {
            
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(appError.errorDecoding))
                return
            }
            if let error = response.error {
                completion(.failure(appError.serverError(error)))
            }
            if let decodeData = response.data {
                completion(.success(decodeData))
            }else {
                completion(.failure(appError.unkonwnError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    /// This function help us to generate a urlRequest
    /// - Parameters:
    ///   - route: The path the resource in the backend
    ///   - method: type of request to be made
    ///   - parameters: whatever extra information you need to pass to the backend
    /// - Returns: URLRequest
    private func createRequest(route:Route,
                               method: Method,
                               parameters:[String:Any]? = nil) -> URLRequest? {
        let urlString = (Route.baseUrl + route.description)
        guard let  url = urlString.asUrl else {return nil}
        var urlRequest = URLRequest(url: url)
//        urlRequest.addValue("application.json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlcomponent = URLComponents(string: urlString)
                // https://google.com/book?/type = cartoon&page
                urlcomponent?.queryItems = params.map {
                    URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlcomponent?.url
                
            case .post,.delete,.patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
            }
        }
        return urlRequest
    }
}

