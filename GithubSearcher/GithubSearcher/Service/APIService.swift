//
//  APIService.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/27/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation

final class APIService {
    
    static let shared = APIService(URL(string: "https://api.github.com/")!)
    let Token = "Token 3cb3b078e720b5d9741f472fc5f12caed1bdea6f"
    
    private let baseURL: URL
    
    private init(_ baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func response<Request>(from requestType: Request, completion: @escaping (Decodable?, APIServiceError?) -> ()) -> URLSessionDataTask where Request : APIRequestType  {
        
        let pathURL = URL(string: requestType.path, relativeTo: self.baseURL)!
        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = requestType.queryItems
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Token, forHTTPHeaderField: "Authorization")

        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, APIServiceError.responseError)
                }
                return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(Request.Response.self, from: data) else {
                DispatchQueue.main.async {
                    completion(nil, APIServiceError.parseError)
                }
                return
            }

            DispatchQueue.main.async {
                completion(decodedResponse, nil)
            }

        }
        
        dataTask.resume()
        
        return dataTask
    }
}

