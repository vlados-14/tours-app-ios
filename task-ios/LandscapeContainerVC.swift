//
//  LandscapeContainerVC.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import UIKit

protocol DisplayDetailsInLandscapeDelegate: AnyObject {
    func displayDetailsFor(tour: Tour)
}

class LandscapeContainerVC: GenericViewControllerWithNavItems {
    
    let listViewController = ToursListContainerVC(reactor: ToursContainerReactor())
    var detailsViewController = TourDetailsViewController(reactor: TourDetailsReactor(provider: TourDetailsService(), tourId: ""))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ToursApp.mainBackground
        
        listViewController.displayDetailsInLandscapeDelegate = self
        
        addChild(listViewController)
        addChild(detailsViewController)
        
        listViewController.view.translatesAutoresizingMaskIntoConstraints = false
        detailsViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(listViewController.view)
        view.addSubview(detailsViewController.view)
        
        NSLayoutConstraint.activate([
            listViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listViewController.view.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            listViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            detailsViewController.view.leadingAnchor.constraint(equalTo: listViewController.view.trailingAnchor),
            detailsViewController.view.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            detailsViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailsViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension LandscapeContainerVC: DisplayDetailsInLandscapeDelegate {
    func displayDetailsFor(tour: Tour) {
        detailsViewController.reactor?.tourId = String(tour.id)
        detailsViewController.reactor?.action.onNext(.getTourDetailsData)
    }
}
