//
//  DateExtensions.swift
//  Event-App
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit

extension Date {
    
    public func asDisplaySlashDateString() -> String {
        return Date.displayDateFormatter.string(from: self)
    }
    
    private static var displayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE h:mma\nMMM d yyyy"
        return dateFormatter
    }()
}
