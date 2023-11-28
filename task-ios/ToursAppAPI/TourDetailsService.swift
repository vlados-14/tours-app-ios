//
//  TourDetailsService.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import Foundation
import RxSwift

protocol TourDetailsProtocol {
    func fetchDetails(tourId: String) -> Single<Tour>
}

final class TourDetailsService: TourDetailsProtocol {
    
    private lazy var uriPathTourDetails = "/tours"
    private let uriPathContactInfo = "/contact"
    
    func fetchDetails(tourId: String) -> Single<Tour> {
        guard let config = Network.shared.configureGeneralRequest(uriPath: "\(uriPathTourDetails)/\(tourId)", httpMethod: .get) else {
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
