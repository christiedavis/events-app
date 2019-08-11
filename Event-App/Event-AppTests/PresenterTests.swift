//
//  PresenterTests.swift
//  Event-AppTests
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import XCTest
@testable import Event_App

class PresenterTests: XCTestCase {
    
    func testNumRows() {
        let mockServices = MockServiceFactory()
        let presenter = EventsPresenter(serviceFactory: mockServices)
        XCTAssert(presenter.numRows(section: 0) == 0)
        XCTAssert(presenter.numRows(section: 1) == 1)
        XCTAssert(presenter.numRows(section: 2) == 0)

        presenter.eventlist = MockNetworkService.createEvents(number: 343)
        XCTAssert(presenter.numRows(section: 0) == 344)
    }
    
    func testEventVMForRow() {
        let mockServices = MockServiceFactory()
        let presenter = EventsPresenter(serviceFactory: mockServices)
        XCTAssertNil(presenter.getEventVMFor(0))
        XCTAssertNil(presenter.getEventVMFor(455334))
        
        let list = MockNetworkService.createEvents(number: 343)
        presenter.eventlist = list
        XCTAssert(presenter.getEventVMFor(34)?.eventId == list[34].id)
        XCTAssert(presenter.getEventVMFor(200)?.eventId == list[200].id)
        
        XCTAssert(presenter.getEventVMFor(234)?.eventId == list[234].id)
    }
    
    func testLoadMore()  {
        let mockServices = MockServiceFactory()
        let presenter = EventsPresenter(serviceFactory: mockServices)
        XCTAssert(presenter.eventlist.isEmpty)
        
        let mockVc = MockViewController()
        presenter.view = mockVc
        mockVc.finishLoadingCallBack = {
            XCTAssert(presenter.eventlist.isEmpty == false)
        }
        
        presenter.loadMore()
    }
}

class MockViewController: EventsViewDelegate {
    
    var finishLoadingCallBack: (() -> ())?
    var isLoading: Bool = false
    
    func reloadView() {
        
    }
    
    func showLoading() {
        isLoading = true
    }
    
    func hideLoading() {
        self.isLoading = false
        finishLoadingCallBack?()
    }
    
    func showError(_ errorMessage: String) {
        
    }
    
    func hideError() {
        
    }
}
