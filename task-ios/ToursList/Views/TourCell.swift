//
//  TourCell.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import UIKit
import SDWebImage

class TourCell: UITableViewCell {
    
    let iconSize = CGSize(width: 60, height: 60)
    let padding: CGFloat = 10
    
    var tour: TourListItem? {
        didSet {
            guard let tour = tour else { return }
            configureCell(tour: tour)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(tourImageView)
        contentView.addSubview(tourTitleLabel)
        contentView.addSubview(tourShortDescriptionLabel)
        contentView.addSubview(tourEndDateLabel)
        contentView.addSubview(tourPriceLabel)
        
        NSLayoutConstraint.activate([
            tourImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tourImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            tourTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            tourTitleLabel.leadingAnchor.constraint(equalTo: tourImageView.trailingAnchor, constant: padding),
            tourTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: tourPriceLabel.leadingAnchor, constant: -padding),
            
            tourShortDescriptionLabel.topAnchor.constraint(equalTo: tourTitleLabel.bottomAnchor, constant: padding),
            tourShortDescriptionLabel.leadingAnchor.constraint(equalTo: tourImageView.trailingAnchor, constant: padding),
            tourShortDescriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -padding),
            
            tourEndDateLabel.topAnchor.constraint(equalTo: tourShortDescriptionLabel.bottomAnchor, constant: padding),
            tourEndDateLabel.leadingAnchor.constraint(equalTo: tourImageView.trailingAnchor, constant: padding),
            tourEndDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            tourPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            tourPriceLabel.topAnchor.constraint(equalTo: tourTitleLabel.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tourImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.widthAnchor.constraint(equalToConstant: iconSize.width).isActive = true
        $0.heightAnchor.constraint(equalToConstant: iconSize.height).isActive = true
        return $0
    }(UIImageView())
    
    let tourTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let tourShortDescriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let tourEndDateLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let tourPriceLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private func configureCell(tour: TourListItem) {
        tourTitleLabel.text = tour.title
        tourShortDescriptionLabel.text = tour.shortDescription
        setDateInReadableFormat(dateString: tour.endDate)
        tourPriceLabel.text = "\(tour.price)€"
        
        guard let url = URL(string: tour.thumb) else { return }
        tourImageView.sd_setImage(with: url, placeholderImage: nil)
    }
    
    private func setDateInReadableFormat(dateString: String) {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate]
        if let date = dateFormatter.date(from: dateString) {
            tourEndDateLabel.text = "Available until: \(date.formatted(date: .numeric, time: .omitted))"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tourTitleLabel.text = nil
        tourShortDescriptionLabel.text = nil
        tourPriceLabel.text = nil
        tourEndDateLabel.text = nil
        tourImageView.image = nil
    }
}
