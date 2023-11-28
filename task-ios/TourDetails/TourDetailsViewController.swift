//
//  TourDetailsViewController.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import UIKit
import ReactorKit
import SDWebImage

class TourDetailsViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ToursApp.mainBackground
        guard let reactor = reactor else { return }
        reactor.tourId.isEmpty ? displayLogo() : displayDetails()
        
        if UIDevice.current.orientation == .portrait {
            reactor.action.onNext(.getTourDetailsData)
        }
    }
    
    init(reactor: TourDetailsReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let detailsView: DetailsView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(DetailsView())
    
    let logoView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "imaginary_logo")
        $0.contentMode = .scaleAspectFit
        $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return $0
    }(UIImageView())
    
    private func displayLogo() {
        view.addSubview(logoView)
        
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func displayDetails() {
        logoView.removeFromSuperview()
        view.addSubview(detailsView)
        
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

extension TourDetailsViewController: View {
    typealias Reactor = TourDetailsReactor
    
    func bind(reactor: TourDetailsReactor) {
        reactor.state.map { $0.tourDetailsData }
            .subscribe(onNext: { [weak self] tourDetails in
                guard let self = self, let tourDetails = tourDetails else { return }
                self.displayDetails()
                
                detailsView.titleLabel.text = tourDetails.title
                detailsView.descriptionLabel.text = tourDetails.description
                detailsView.bookableIntervalLabel.text = "\(tourDetails.startDate) - \(tourDetails.endDate)"
                
                if let imageUrlString = tourDetails.image, let url = URL(string: imageUrlString) {
                    detailsView.imageView.sd_setImage(with: url, placeholderImage: nil)
                }
            })
            .disposed(by: disposeBag)
    }
}
