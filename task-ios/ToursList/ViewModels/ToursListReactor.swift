//
//  ToursListReactor.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import ReactorKit

class ToursListReactor: Reactor {
    
    let isTop5: Bool
    let provider: ToursListProtocol
    
    enum Action {
        case getToursListData
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setError(Error?)
        case setToursListData([Tour])
    }
    
    struct State {
        var sections: [ToursListSectionModel]
        var toursListData: [Tour]?
        
        var isLoading: Bool = false
        var error: Error?
    }
    
    let initialState: State
    
    init(isTop5: Bool, provider: ToursListProtocol) {
        self.initialState = State(
            sections: []
        )
        self.isTop5 = isTop5
        self.provider = provider
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .getToursListData:
            let toursListDataObsrv = provider.fetchTours(isTop5: self.isTop5)
                                            .asObservable()
                                            .flatMap { Observable.just(Mutation.setToursListData($0)) }
                                            .catch { Observable.just(Mutation.setError($0)) }
        
            return .concat([.just(Mutation.setLoading(true)),
                            toursListDataObsrv,
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
        case .setToursListData(let toursListData):
            state.toursListData = toursListData
            state.sections = createToursDataSections(toursListData: toursListData)
        }

        return state
    }
    
    private func createToursDataSections(toursListData: [Tour]) -> [ToursListSectionModel] {
        var items: [TourListItem] = []
        toursListData.forEach { tour in
            let newItem = TourListItem(identity: tour.id, title: tour.title, shortDescription: tour.shortDescription, thumb: tour.thumb, startDate: tour.startDate, endDate: tour.endDate, price: tour.price)
            items.append(newItem)
        }
        
        return [ToursListSectionModel(items: items)]
    }
}
