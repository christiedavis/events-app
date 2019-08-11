//
//  MockServices.swift
//  Event-AppTests
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit

import PromiseKit
@testable import Event_App

class MockServiceFactory: ServiceFactoryProtocol {
    func getEventList(for page: Int) -> Promise<[Event]> {
        return Promise.value(MockNetworkService.createEvents(number: Int.random(in: 1...40)))
    }
    
    func isFavourite(eventId: String?) -> Bool {
        return true // todo
    }
    
    func toggleEventFavourite(eventId: String) -> Bool {
        return true // todo
    }
}
    
    
//    var response: Response = Response(path: "presente", response_code: "weres")
//
//    var error: ServiceError?
//    var mockRequests: Int = 0
//
//    func getCode() -> Promise<Response> {
//        if let err = self.error {
//            return Promise(error: err)
//        }
//        return Promise.value(self.response)
//    }
//
//    func getNumberRequests() -> Int {
//        return mockRequests


class MockNetworkService: NetworkServiceProtocol {
    func getEventList(for page: Int) -> Promise<[Event]> {
        return Promise.value(MockNetworkService.createEvents(number: Int.random(in: 1...40)))
    }
    
    
//    var response: Response = Response(path: "presente", response_code: "weres")
//    var nextPath: NextPath = NextPath(next_path: "fake path")
//
//    var error: ServiceError?
//    var mockRequests: Int = 0
//
//    func getPath() -> Promise<NextPath> {
//        return Promise.value(self.nextPath)
//    }
//
//    func getCode(path: String) -> Promise<Response> {
//        if let err = self.error {
//            return Promise(error: err)
//        }
//        return Promise.value(self.response)
//    }
    
    static func createEvents(number: Int) -> [Event] {
        var events: [Event] = []
        
        for index in 0...number {
            let newEvent = Event(id: UUID().uuidString, title: "new event", image: nil, startDate: 76546789)
//
            events.append(newEvent)
        }
        return events
    }
}
