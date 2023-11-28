//
//  Tour.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import Foundation

struct Tour: Codable {
    let id: Int
    let title, shortDescription: String
    let thumb: String
    let startDate, endDate: String
    let price: String
}
