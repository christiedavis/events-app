//
//  EventsViewController.swift
//  Event-App
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit

protocol EventsViewDelegate: class {
    
}

class EventsViewController: UIViewController {

    let presenter = EventsPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.view = self
        self.presenter.load()

    }
}

extension EventsViewController: EventsViewDelegate {
    
}
