//
//  ServiceFactory.swift
//  Event-App
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit
import PromiseKit

protocol ServiceFactoryProtocol {
    func getEventList(for page: Int) -> Promise<[Event]>
    
    func isFavourite(eventId: String?) -> Bool
    func toggleEventFavourite(eventId: String) -> Bool
}

class ServiceFactory {
    private static var sharedInstance: ServiceFactoryProtocol?
    public static var shared: ServiceFactoryProtocol {
        if let instance = sharedInstance {
            return instance
        }
        let instance = ServiceFactory()
        sharedInstance = instance
        return instance
    }
    
    init() {
        self.networkService = NetworkService()
        self.favouriteService = FavouritesService()
    }
    
    var networkService: NetworkServiceProtocol
    var favouriteService: FavouritesServiceProtocol
}

extension ServiceFactory: ServiceFactoryProtocol {
    //TODO: this would be good to come back to test further and further test the logic.
    func getEventList(for page: Int) -> Promise<[Event]> {
        return self.networkService.getEventList(for: page)
    }
    
    func isFavourite(eventId: String?) -> Bool {
        guard let eventId = eventId else {
            return false
        }
        return self.favouriteService.isEventFavourite(eventId: eventId)
    }
    
    func toggleEventFavourite(eventId: String) -> Bool {
        let currentState = self.favouriteService.isEventFavourite(eventId: eventId)

        if currentState == true {
        self.favouriteService.setEventAsNotFavourite(eventid: eventId)
            
        } else {
            self.favouriteService.setEventAsFavourite(eventid: eventId)
        }
        return currentState == false
    }
}
