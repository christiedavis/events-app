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

class MockNetworkService: NetworkServiceProtocol {
    func getEventList(for page: Int) -> Promise<[Event]> {
        return Promise.value(MockNetworkService.createEvents(number: Int.random(in: 1...40)))
    }
    
    static func createEvents(number: Int) -> [Event] {
        var events: [Event] = []
        
        for _ in 0...number {
            let newEvent = Event(id: UUID().uuidString, title: "new event", image: nil, startDate: 76546789)

            events.append(newEvent)
        }
        return events
    }
}
