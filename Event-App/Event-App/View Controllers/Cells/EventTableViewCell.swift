//
//  EventTableViewCell.swift
//  Event-App
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit

protocol FavouritingDelegate: class {
    func setAsFavourite(_ eventID: String)
}

struct EventCellVM {
    var eventId: String?
    var eventName: String?
    var eventDateString: String?
    var isFavourite: Bool
    var favouritingDelegate: FavouritingDelegate
}

class EventTableViewCell: UITableViewCell {

    @IBOutlet var evnetImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var favouriteButton: UIButton!
    
    var eventID: String?
    weak var favouriteDelegate: FavouritingDelegate?
    
    func setup(with eventVM: EventCellVM) {
        self.favouriteDelegate = eventVM.favouritingDelegate
        self.eventID = eventVM.eventId
        
        self.evnetImageView.layer.cornerRadius = 22
        
        self.nameLabel.text = eventVM.eventName
        self.dateLabel.text = eventVM.eventDateString
        
        if eventVM.isFavourite {
            favouriteButton.setTitle("Unfavourite", for: .normal)
        } else {
            favouriteButton.setTitle("Favourite", for: .normal)
        }
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
       
            if let eventID = self.eventID {
                self.favouriteDelegate?.setAsFavourite(eventID)
        }
    }
    
    static var reuseIdentifier: String {
        return "EventTableViewCell"
    }
}
