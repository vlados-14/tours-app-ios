//
//  TourDetailsViewController.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import UIKit

class TourDetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ToursApp.mainBackground
        
        view.addSubview(detailsView)
        
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    let detailsView: DetailsView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(DetailsView())
}
