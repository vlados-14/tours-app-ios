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

class ToursListContainerVC: UIViewController {
    var disposeBag = DisposeBag()
    
    fileprivate var currentIndex = 0
    
    private let navBarImageSize = CGSize(width: 32, height: 32)
    
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
        
        setupNavigationBarItems()
    }
    
    @objc func switchPage() {
        if currentIndex == segmentedControl.selectedSegmentIndex { return }
        let direction = currentIndex < segmentedControl.selectedSegmentIndex ? UIPageViewController.NavigationDirection.forward : UIPageViewController.NavigationDirection.reverse
        
        self.pageViewController.setViewControllers([self.pages[self.segmentedControl.selectedSegmentIndex]], direction: direction, animated: true)
    }
    
    private func setupNavigationBarItems() {
        //should be added with a custom image
        let moreButton = UIBarButtonItem(title: "...", style: .plain, target: self, action: #selector(handleMore))
        moreButton.tintColor = .black
        
        guard let logoImage = UIImage(named: "imaginary_logo") else { return }
        let logo = UIBarButtonItem(image: UIImage.resize(image: logoImage, targetSize: navBarImageSize), style: .plain, target: self, action: #selector(handleLogoTapped))
        
        let title = UIBarButtonItem(title: "Tourify App", style: .plain, target: self, action: #selector(handleTitle))
        title.tintColor = .black
        
        navigationItem.leftBarButtonItems = [logo,title]
        navigationItem.rightBarButtonItem = moreButton
    }
    
    @objc private func handleLogoTapped() {}
    
    @objc private func handleMore() {}
                                             
    @objc private func handleTitle() {}
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
        let detailsViewController = TourDetailsViewController()
        detailsViewController.title = tour.title
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension ToursListContainerVC: View {
    typealias Reactor = ToursContainerReactor
    
    func bind(reactor: ToursContainerReactor) {
        
    }
}

class CustomSegmentedControl: UISegmentedControl {
    
    //Custom class created in case we need to customize the appearance of the segmented control
    override init(items: [Any]?) {
        super.init(items: items)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
