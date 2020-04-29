//
//  APIServiceError.swift
//  GithubSearcher
//
//  Created by Duy Thien Chau on 4/27/20.
//  Copyright © 2020 Duy Thien Chau. All rights reserved.
//

import Foundation

enum APIServiceError : Error {
    case responseError
    case parseError
}
