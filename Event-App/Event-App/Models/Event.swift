//
//  Event.swift
//  Event-App
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit

class Event: Codable {
    var id: String?
    var title: String?
    var image: String?
    var startDate: Double?
    
    lazy var startDateAsDate: Date? = {
        if let startDateInt = self.startDate {
            return Date(timeIntervalSince1970: startDateInt)
        }
        return nil
    }()
    
    init(id: String?, title: String?, image: String?, startDate: Double?) {
        self.id = id
        self.title = title
        self.image = image
        self.startDate = startDate
    }
}
