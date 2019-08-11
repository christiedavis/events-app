//
//  EventTableViewCell.swift
//  Event-App
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit
import AlamofireImage
protocol FavouritingDelegate: class {
    func setAsFavourite(_ eventID: String) -> Bool
}

struct EventCellVM {
    var eventId: String?
    var eventName: String?
    var eventDateString: String?
    var imageUrl: URL?
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
        
        if let imageurl = eventVM.imageUrl {
            self.evnetImageView.layer.cornerRadius = 22
            self.evnetImageView.af_setImage(
                withURL: imageurl,
                placeholderImage: UIImage(named: "placeholder_image")
            )
        }
        
        self.nameLabel.text = eventVM.eventName
        self.dateLabel.text = eventVM.eventDateString
        
        self.setupFavouriting(isFavourite: eventVM.isFavourite)
    }
    
    private func setupFavouriting(isFavourite: Bool) {
        if isFavourite {
            favouriteButton.setTitle("Unfavourite", for: .normal)
        } else {
            favouriteButton.setTitle("Favourite", for: .normal)
        }
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
       
        guard let delegate = self.favouriteDelegate else {
            print("delegate not set")
            return
        }
        
            if let eventID = self.eventID {
                let favouriteResult = delegate.setAsFavourite(eventID)
                
                self.setupFavouriting(isFavourite: favouriteResult)
        }
    }
    
    static var reuseIdentifier: String {
        return "EventTableViewCell"
    }
}
