//
//  TourDetailsReactor.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import ReactorKit

class TourDetailsReactor: Reactor {
    
    let provider: TourDetailsProtocol
    var tourId: String
    
    enum Action {
        case getTourDetailsData
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setError(Error?)
        case setTourDetailsData(Tour)
    }
    
    struct State {
        var tourDetailsData: Tour?
        
        var isLoading: Bool = false
        var error: Error?
    }
    
    let initialState: State
    
    init(provider: TourDetailsProtocol, tourId: String) {
        self.initialState = State()
        self.provider = provider
        self.tourId = tourId
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .getTourDetailsData:
            let tourDetailsDataObsrv = provider.fetchDetails(tourId: self.tourId)
                                            .asObservable()
                                            .flatMap { Observable.just(Mutation.setTourDetailsData($0)) }
                                            .catch { Observable.just(Mutation.setError($0)) }
        
            return .concat([.just(Mutation.setLoading(true)),
                            tourDetailsDataObsrv,
                            .just(Mutation.setLoading(false))])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setError(let error):
            state.error = error
        case .setLoading(let loading):
            state.isLoading = loading
        case .setTourDetailsData(let tourDetailsData):
            state.tourDetailsData = tourDetailsData
        }
        
        return state
    }
}
