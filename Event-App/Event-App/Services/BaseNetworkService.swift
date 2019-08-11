//
//  BaseNetworkService.swift
//  Event-App
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit
import PromiseKit
import Alamofire

internal protocol BaseServiceProtocol {
    
    func request<T: Encodable, E: Decodable >(method: HTTPMethod, path: String, requestDTO: T?) -> Promise<E>
}

class BaseNetworkService {
    
    internal let defaultEndpointEncoder: JSONEncoder = JSONEncoder()
    internal let defaultEndpointDecoder: JSONDecoder = JSONDecoder()
    
    internal var sessionManager: SessionManager = Alamofire.SessionManager.default
    
    internal func retrieveBasedURL(_ endpoint: String) -> URL? {
        return URL(string: "https://jsonplaceholder.typicode.com/\(endpoint)")
    }
}

extension BaseNetworkService: BaseServiceProtocol {
    
    internal func request<T: Encodable, E: Decodable >(method: HTTPMethod, path: String, requestDTO: T?) -> Promise<E> {
        let dict = try? requestDTO.asDictionary()
        return request(method: method, path: path, parameters: dict)
    }
    
    internal func request<T: Decodable>(method: HTTPMethod, path: String, parameters: Parameters? = nil) -> Promise<T> {
        guard let url = retrieveBasedURL(path) else {
            return Promise(error: ServiceError.invalidEndpoint)
            
        }
        return self.request(url: url, method: method, parameters: parameters)
    }
    
    internal func request<T: Decodable>(url: URL, method: HTTPMethod, parameters: Parameters? = nil) -> Promise<T> {
        
        return Promise { seal in
            
            sessionManager.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: [:])
                .validate(statusCode: 200..<400)
                .response(completionHandler: { response in
                    
                    if let error = response.error {
                        seal.reject(error)
                        
                    } else {
                        
                        guard let responseData = response.data else {
                            seal.reject(ServiceError.noResponseData)
                            return
                        }
                        
                        do {
                            
                            let result = try self.defaultEndpointDecoder.decode(T.self, from: responseData)
                            seal.fulfill(result)
                        } catch let error {
                            
                            print(error)
                            seal.reject(ServiceError.invalidDataDecoding)
                            return
                        }
                    }
                })
        }
    }
}
