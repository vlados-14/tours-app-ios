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
        guard var config = Network.shared.configureGeneralRequest(uriPath: isTop5 ? uriPathTop5Tours : uriPathAllTours, httpMethod: .get)
        else {
            return Observable.empty().asSingle()
        }
        
        config.request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return config.session.rx.response(request: config.request)
            .map { result in
                do {
                    let decoded = try JSONDecoder().decode([Tour].self, from: result.data)
                    return decoded
                } catch {
                    print(error)
                    throw error
                }
            }
            .observe(on: MainScheduler.instance)
            .asSingle()
            .catch { error in
                throw Network.TourifyError.cannotLoadTours(description: error.localizedDescription)
            }
    }
}

