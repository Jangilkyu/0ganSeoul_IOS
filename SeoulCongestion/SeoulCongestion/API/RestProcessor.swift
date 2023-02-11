//
//  RestProcessor.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/04.
//

import UIKit

protocol RestProcessorRequestDelegate: AnyObject {
    func didFailToPrepareRequest(
        _ result: RestProcessor.Results,
        _ usage: EndPoint
    )
    func didReceiveResponseFromDataTask(
        _ result: RestProcessor.Results,
        _ usage: EndPoint
    )
}

class RestProcessor {
    /// Request
    var requestHttpHeaders = RestEntity()
    var urlQueryParameters = RestEntity()
    var httpBodyParameters = RestEntity()
    
    /// Optional
    var httpBody: Data?
    
    /// Delegate
    weak var reqeustDelegate: RestProcessorRequestDelegate?
    
    /// Mockable
    let urlSession: URLSession
    
    init(
        _ session: URLSession = URLSession(configuration: .default)
    ) {
        urlSession = session
    }
    
    // MARK: - Preparing Requests
    func prepareRequest(
        withURL url: URL?,
        httpBody: Data?,
        httpMethod: HttpMethod
    ) -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod.rawValue
        for (header, value) in requestHttpHeaders.allValues() {
            request.setValue( (value as! String), forHTTPHeaderField: header)
        }
        request.httpBody = httpBody
        return request
    }
    
    // MARK: - Making Requests
    func makeRequest(
        toURL url: URL,
        withHttpMethod httpMethod: HttpMethod,
        usage: EndPoint,
        callBack: (() -> Void)? = nil
    ) {
        let targetURL = self.addURLQueryParameters(toURL: url)
        let httpBody = (httpMethod == .get)
            ? nil
            : self.getHttpBody()
        guard let request = self.prepareRequest(
                        withURL: targetURL,
                        httpBody: httpBody,
                        httpMethod: httpMethod) else {
            /// Case 1: Failed
            let error = Results(withError: CustomError.failedToCreateRequest)
            self.reqeustDelegate?.didFailToPrepareRequest(error, usage)
            callBack?()
            return
        }
        let task = urlSession.dataTask(with: request) { (data, response, error) in
          
            /// Case 2: Success
            let result = Results(
                withData: data,
                response: Response(fromURLResponse: response),
                error: error)
          
            self.reqeustDelegate?.didReceiveResponseFromDataTask(result, usage)
            callBack?()
        }
        task.resume()
    }
    
    // MARK: - Helpers
    private func addURLQueryParameters(toURL url: URL) -> URL {
        if urlQueryParameters.totalItems() > 0 {
            guard var urlComponents = URLComponents(
                url: url,
                resolvingAgainstBaseURL: false
            ) else { return url }
            var queryItems = [URLQueryItem]()
            for (key, value) in urlQueryParameters.allValues() {
                let item = URLQueryItem(name: key, value: (value as! String).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                )
                queryItems.append(item)
            }
            urlComponents.queryItems = queryItems
            guard let updatedURL = urlComponents.url else { return url }
            return updatedURL
        }
        return url
    }
    
    private func getHttpBody() -> Data? {
        guard let contentType = requestHttpHeaders.value(forKey: "Content-Type") as? String else { return nil }
        if contentType.contains("application/json") {
            return try? JSONSerialization.data(
                withJSONObject: httpBodyParameters.allValues(),
                options: [.prettyPrinted, .sortedKeys]
            )
        } else if contentType.contains("application/x-www-form-urlencoded") {
            let bodyString = httpBodyParameters.allValues().map {
                "\($0)=\(String(describing: ($1 as! String).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))"
            }.joined(separator: "&")
            return bodyString.data(using: .utf8)
        } else {
            return httpBody
        }
    }
}
