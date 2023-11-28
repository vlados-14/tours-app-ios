//
//  TourDetailsService.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import Foundation
import RxSwift

protocol TourDetailsProtocol {
    func fetchDetails() -> Single<Tour>
}

final class TourDetailsService: TourDetailsProtocol {
    
    let tourId: String
    
    private lazy var uriPathTourDetails = "/tours/\(tourId)"
    private let uriPathContactInfo = "/contact"
    
    init(tourId: String) {
        self.tourId = tourId
    }
    
    func fetchDetails() -> Single<Tour> {
        guard let config = Network.shared.configureGeneralRequest(uriPath: uriPathTourDetails, httpMethod: .get) else {
            return Observable.empty().asSingle()
        }

        return config.session.rx.response(request: config.request)
            .map{ try JSONDecoder().decode(Tour.self, from: $0.data) }
            .observe(on: MainScheduler.instance)
            .asSingle()
            .catch { error in
                throw Network.TourifyError.cannotLoadTourDetails(description: error.localizedDescription)
            }
    }
}
