//
//  ToursListSectionModel.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import RxDataSources

struct ToursListSectionModel: AnimatableSectionModelType {
    typealias Identity = String
    var identity: String = UUID.init().uuidString
    
    var items: [TourListItem]
}

extension ToursListSectionModel: SectionModelType {
    typealias Item = TourListItem
    
    init(original: ToursListSectionModel, items: [TourListItem]) {
        self = original
        self.items = items
    }
}

struct TourListItem: IdentifiableType, Equatable {
    
    static func == (lhs: TourListItem, rhs: TourListItem) -> Bool {
        lhs.identity == rhs.identity
    }
    
    typealias Identity = Int
    
    let identity: Int
    let title, shortDescription: String
    let thumb: String
    let startDate, endDate: String
    let price: String
}
