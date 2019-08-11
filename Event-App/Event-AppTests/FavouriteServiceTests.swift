//
//  FavouriteServiceTests.swift
//  Event-AppTests
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import XCTest
@testable import Event_App

class FavouriteServiceTests: XCTestCase {
        let mockID = "EventTestID"

    override func setUp() {
        UserDefaults.standard.set(nil, forKey: mockID)
    }
    
    func testFavouriting() {
        
        let favService = FavouritesService()
        XCTAssert(favService.isEventFavourite(eventId: mockID) == false)
        favService.setEventAsFavourite(eventid: mockID)
        XCTAssert(favService.isEventFavourite(eventId: mockID) == true)
    }
    
    func testServiceFavouriting() {
        let serviceFact = ServiceFactory.shared
        
        XCTAssert(serviceFact.isFavourite(eventId: mockID) == false)
        XCTAssert(serviceFact.toggleEventFavourite(eventId: mockID) == true)
        XCTAssert(serviceFact.toggleEventFavourite(eventId: mockID) == false)
        XCTAssert(serviceFact.toggleEventFavourite(eventId: mockID) == true)
        
        XCTAssert(serviceFact.isFavourite(eventId: nil) == false)

    }
}
