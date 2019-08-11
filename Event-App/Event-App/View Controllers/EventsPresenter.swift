//
//  EventsPresenter.swift
//  Event-App
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit
import PromiseKit

protocol EventsPresenterProtocol: BasePresenterProtocol {
    func numRows() -> Int
    func getEventVMFor(_ row: Int) -> EventCellVM?
}

class EventsPresenter: BasePresenter {
    weak var coordinator: AppCoordinatorDelegate?
    weak var view: EventsViewDelegate?
    
    var eventlist: [Event] = []
}

extension EventsPresenter: EventsPresenterProtocol {
    func load() {
        self.view?.showLoading()

        self.serviceFactory.getEventList()
        .done { (eventList) in
            print(eventList)
            self.eventlist = eventList
            
            self.view?.hideLoading()
            self.view?.reloadView()
        }
        .catch { [weak self] (error) in
            print(error)
            self?.view?.hideLoading()
            self?.view?.showError("Unexpected error getting the latest in events.")
        }
    }
    
    func numRows() -> Int {
        return self.eventlist.count
    }
    
    func getEventVMFor(_ row: Int) -> EventCellVM? {
        if let event = self.eventFor(row) {
            let eventVM = EventCellVM(eventId: event.id, eventName: event.title, eventDateString: "todo", isFavourite: false, favouritingDelegate: self)
            
            return eventVM
        }
        return nil
    }
    
    private func eventFor(_ row: Int) -> Event? {
        if row >= 0 && row < eventlist.count {
            return eventlist[row]
        }
        return nil
    }
}

extension EventsPresenter: FavouritingDelegate {
    func setAsFavourite(_ eventID: String) {
        
    }
}
