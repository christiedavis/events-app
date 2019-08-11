//
//  EventsPresenter.swift
//  Event-App
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit

protocol EventsPresenterProtocol: BasePresenterProtocol {
    
}

class EventsPresenter: BasePresenter {
    weak var coordinator: AppCoordinatorDelegate?
    weak var view: EventsViewDelegate?
}

extension EventsPresenter: EventsPresenterProtocol {
    func load() {
        self.serviceFactory.getEventList().done { (eventList) in
            print(eventList)
        }
    }
}
