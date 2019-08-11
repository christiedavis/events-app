//
//  NetworkService.swift
//  Event-App
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit
import PromiseKit

protocol NetworkServiceProtocol: class {
    func getEventList(for page: Int) -> Promise<[Event]>
}

class NetworkService: BaseNetworkService {
    let eventPath = "events"
}

extension NetworkService: NetworkServiceProtocol {
    func getEventList(for page: Int) -> Promise<[Event]> {
        return self.request(method: .get, path: self.eventPath, parameters: ["_page": page])
    }
}
