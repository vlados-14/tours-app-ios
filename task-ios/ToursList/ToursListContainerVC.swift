//
//  ToursListContainerVC.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import UIKit
import RxSwift
import ReactorKit

protocol SetCurrentPageDelegate: AnyObject {
    func currentPage(index: Int)
}

protocol OpenDetailsScreenDelegate: AnyObject {
    func openDetailsScreenFor(tour: Tour)
}

class ToursListContainerVC: GenericViewControllerWithNavItems {
    var disposeBag = DisposeBag()
    
    private var currentIndex = 0
    
    lazy var segmentedControl: CustomSegmentedControl = {
        $0.addTarget(self, action: #selector(switchPage), for: .valueChanged)
        $0.selectedSegmentIndex = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(CustomSegmentedControl(items: ["all".uppercased(), "top 5".uppercased()]))
    
    var pages: [UIViewController] = []
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    let allToursListVC: ToursListViewController
    let top5ToursListVC: ToursListViewController
    
    init(reactor: ToursContainerReactor) {
        allToursListVC = ToursListViewController(reactor: ToursListReactor(isTop5: false, provider: ToursListService()))
        top5ToursListVC = ToursListViewController(reactor: ToursListReactor(isTop5: true, provider: ToursListService()))
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ToursApp.mainBackground
        
        allToursListVC.setCurrentPageDelegate = self
        top5ToursListVC.setCurrentPageDelegate = self
        
        allToursListVC.openDetailsScreenDelegate = self
        top5ToursListVC.openDetailsScreenDelegate = self
        
        pages.append(allToursListVC)
        pages.append(top5ToursListVC)
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
        
        view.addSubview(pageViewController.view)
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            
            pageViewController.view.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    @objc func switchPage() {
        if currentIndex == segmentedControl.selectedSegmentIndex { return }
        let direction = currentIndex < segmentedControl.selectedSegmentIndex ? UIPageViewController.NavigationDirection.forward : UIPageViewController.NavigationDirection.reverse
        
        self.pageViewController.setViewControllers([self.pages[self.segmentedControl.selectedSegmentIndex]], direction: direction, animated: true)
    }
}

extension ToursListContainerVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if currentIndex == 0 {
            return nil
        } else {
            return pages[pages.index(before: currentIndex)]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentIndex == 1 {
            return nil
        } else {
            return pages[pages.index(after: currentIndex)]
        }
    }
}

extension ToursListContainerVC: SetCurrentPageDelegate {
    func currentPage(index: Int) {
        currentIndex = index
        segmentedControl.selectedSegmentIndex = currentIndex
    }
}

extension ToursListContainerVC: OpenDetailsScreenDelegate {
    func openDetailsScreenFor(tour: Tour) {
        let detailsViewController = TourDetailsViewController(reactor: TourDetailsReactor(provider: TourDetailsService(tourId: String(tour.id))))
        detailsViewController.title = tour.title
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension ToursListContainerVC: View {
    typealias Reactor = ToursContainerReactor
    
    func bind(reactor: ToursContainerReactor) {
        
    }
}
