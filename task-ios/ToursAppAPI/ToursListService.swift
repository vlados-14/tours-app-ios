//
//  ToursListService.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import Foundation
import RxSwift

protocol ToursListProtocol {
    func fetchTours(isTop5: Bool) -> Single<[Tour]>
}

final class ToursListService: ToursListProtocol {
    
    private lazy var uriPathAllTours = "/tours"
    private lazy var uriPathTop5Tours = "\(uriPathAllTours)/top5"
    
    
    func fetchTours(isTop5: Bool) -> Single<[Tour]> {
        let uriPath = isTop5 ? uriPathTop5Tours : uriPathAllTours
        guard let config = Network.shared.configureGeneralRequest(uriPath: uriPath, httpMethod: .get) else {
            return Observable.empty().asSingle()
        }

        return config.session.rx.response(request: config.request)
            .map{ try JSONDecoder().decode([Tour].self, from: $0.data) }
            .observe(on: MainScheduler.instance)
            .asSingle()
            .catch { error in
                throw Network.TourifyError.cannotLoadTours(description: error.localizedDescription)
            }
    }
}

