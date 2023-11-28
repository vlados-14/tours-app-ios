//
//  TourCell.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import UIKit

class TourCell: UITableViewCell {
    
    var tour: TourListItem? {
        didSet {
            guard let tour = tour else { return }
            configureCell(tour: tour)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell(tour: TourListItem) {
        print(tour.title)
        print("_______")
    }
}
