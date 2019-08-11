//
//  FavouritesService.swift
//  Event-App
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit

// TODO: This is using user defaults, its semi appropriate considering the limited number of potential events
// This should be moved to something like CoreData if it were to be extended,
// It is using Userdefaults for pragmatism purposes for this test

protocol FavouritesServiceProtocol: class {
    func setEventAsFavourite(eventid: String)
    func setEventAsNotFavourite(eventid: String)
    
    func isEventFavourite(eventId: String) -> Bool
}

class FavouritesService: NSObject {
   
}

extension FavouritesService: FavouritesServiceProtocol {
    func setEventAsFavourite(eventid: String) {
        self.setFavourite(favourite: true, eventId: eventid)
    }
    
    func setEventAsNotFavourite(eventid: String) {
        self.setFavourite(favourite: false, eventId: eventid)
    }
    
    func isEventFavourite(eventId: String) -> Bool {
        return UserDefaults.standard.bool(forKey: eventId)

    }
    
    private func setFavourite(favourite: Bool, eventId: String) {
        let defaults = UserDefaults.standard
        defaults.set(favourite, forKey: eventId)
        defaults.synchronize()
    }
}
