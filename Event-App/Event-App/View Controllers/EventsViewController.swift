//
//  EventsViewController.swift
//  Event-App
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit

protocol EventsViewDelegate: class {
    func reloadView()
    
    func showLoading()
    func hideLoading()
    func showError(_ errorMessage: String)
    func hideError()
}

class EventsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var loadingView: UIActivityIndicatorView!
    
    @IBOutlet var errorView: UIView!
    @IBOutlet var errorLabel: UILabel!
    
    let presenter = EventsPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.view = self
        self.presenter.load()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navigationItem.title = "Latest Events" // TODO: strings should be localized
        
        self.tableView.register(UINib(nibName: EventTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: EventTableViewCell.reuseIdentifier)
    }
    
    @IBAction func errorTapped(_ sender: Any) {
        self.hideError()
        self.presenter.load()
    }
}

extension EventsViewController: EventsViewDelegate {
    func reloadView() {
        tableView.reloadData()
    }
    
    func showLoading() {
        self.loadingView.isHidden = false
    }
    
    func hideLoading() {
        self.loadingView.isHidden = true
    }
    
    func showError(_ errorMessage: String) {
        self.errorView.isHidden = false
        self.errorLabel.text = errorMessage
    }
    
    func hideError() {
        self.errorView.isHidden = true
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.reuseIdentifier) as? EventTableViewCell {
            
            if let vm = self.presenter.getEventVMFor(indexPath.row) {
                cell.setup(with: vm)
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
