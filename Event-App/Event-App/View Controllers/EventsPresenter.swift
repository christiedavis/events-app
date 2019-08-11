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
    func numRows(section: Int) -> Int
    func getEventVMFor(_ row: Int) -> EventCellVM?
    func loadMore()
}

class EventsPresenter: BasePresenter {
    weak var coordinator: AppCoordinatorDelegate?
    weak var view: EventsViewDelegate?
    
    var eventlist: [Event] = []
    var page: Int = 1
}

extension EventsPresenter: EventsPresenterProtocol {
    
    func load() {
       self.loadPage()
    }
    
    func loadMore() {
        self.loadPage()
    }
    
    private func loadPage() {
        self.view?.showLoading()
        
        self.serviceFactory.getEventList(for: self.page)
            .done { (eventList) in
                print(eventList)
                self.page += 1
                let sortedList = eventList.sorted(by: { (event1, event2) -> Bool in
                    if let eventDate1 = event1.startDateAsDate, let eventDate2 = event2.startDateAsDate {
                        return eventDate1 < eventDate2
                    }
                    return true
                })
                self.eventlist.append(contentsOf: sortedList)
                
                self.view?.hideLoading()
                self.view?.reloadView()
            }
            .catch { [weak self] (error) in
                print(error)
                self?.view?.hideLoading()
                self?.view?.showError("Unexpected error getting the latest in events.")
        }
    }
    
    func numRows(section: Int) -> Int {
        if section == 0 {
            return self.eventlist.count
        } else if section == 1 {
        // if it is more than three pages, the api has nothing more for us
            if self.page <= 3 {
                return 1
            }
        }
        return 0
    }
    
    func getEventVMFor(_ row: Int) -> EventCellVM? {
        if let event = self.eventFor(row) {
            
            let eventVM = EventCellVM(eventId: event.id, eventName: event.title, eventDateString: event.startDateAsDate?.asDisplaySlashDateString(), imageUrl: URL(string: event.image ?? "error"), isFavourite: false, favouritingDelegate: self)
            
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
