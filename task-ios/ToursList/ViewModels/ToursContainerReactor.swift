//
//  ToursContainerReactor.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import ReactorKit

class ToursContainerReactor: Reactor {
    
    enum Action {}

    struct State {}
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
}
