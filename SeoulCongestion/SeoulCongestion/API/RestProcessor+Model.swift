//
//  RestProcessor+Model.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/04.
//

import Foundation

extension RestProcessor {
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    struct RestEntity {
        private var values: [String: Any] = [:]
        
        mutating func add(
            value: Any,
            forKey key: String) {
            values[key] = value
        }
        
        func value(forKey key: String) -> Any? {
            return values[key]
        }
        
        func allValues() -> [String: Any] {
            return values
        }
        
        func totalItems() -> Int {
            return values.count
        }
        
        mutating func reset() {
            values = [:]
        }
    }
    
    /// Response
    struct Response {
        var httpStatusCode: Int = 0
        var headers = RestEntity()
        var response: URLResponse?
        
        init(fromURLResponse response: URLResponse?) {
            guard let response = response else { return }
            self.response = response
            httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields {
                for (key, value) in headerFields {
                    headers.add(
                        value: "\(value)",
                        forKey: "\(key)"
                    )
                }
            }
        }
    }
    
    enum CustomError: Error {
        case failedToCreateRequest
    }
    
    struct Results {
        var data: Data?
        var response: Response?
        var error: Error?
        
        init(
            withData data: Data?,
            response: Response?,
            error: Error?
        ) {
            self.data = data
            self.response = response
            self.error = error
        }
        
        init(withError error: Error) {
            self.error = error
        }
    }
}

extension RestProcessor.CustomError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .failedToCreateRequest:
            return NSLocalizedString("Unable to create the URLRequest object", comment: "")
        }
    }
}
