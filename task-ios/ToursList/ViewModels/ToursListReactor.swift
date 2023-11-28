//
//  ToursListReactor.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import ReactorKit

class ToursListReactor: Reactor {
    
    let isTop5: Bool
    
    enum Action {

    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    let initialState: State
    
    init(isTop5: Bool) {
        self.initialState = State()
        self.isTop5 = isTop5
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        

        return state
    }
}
