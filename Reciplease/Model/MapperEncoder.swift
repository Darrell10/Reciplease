//
//  MapperEncoder.swift
//  Reciplease
//
//  Created by Frederick Port on 23/01/2020.
//  Copyright © 2020 Frederick Port. All rights reserved.
//

import Foundation

public protocol MapperEncoder {
    func encode(baseUrl: URL, parameters: [String: String]?) -> URL
}

public extension MapperEncoder {
    /// function who encode url and parameters for API with URLComponents
    func encode(baseUrl: URL, parameters: [String: String]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false), let parameters = parameters, !parameters.isEmpty else { return baseUrl }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(queryItem)
        }
        guard let urlParameted = urlComponents.url else { return baseUrl }
        return urlParameted
    }
}
