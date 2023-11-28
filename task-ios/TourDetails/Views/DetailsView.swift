//
//  DetailsView.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import UIKit

class DetailsView: UIView {
    
    private let padding: CGFloat = 20
    private let buttonHeight: CGFloat = 50
    private let imageViewHeight: CGFloat = 200
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(scrollView)
        
        scrollView.addSubview(imageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(bookableIntervalLabel)
        scrollView.addSubview(callButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(padding*2)),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            
            bookableIntervalLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            bookableIntervalLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            bookableIntervalLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            
            callButton.topAnchor.constraint(equalTo: bookableIntervalLabel.bottomAnchor, constant: padding),
            callButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            callButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            callButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    lazy var imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        return $0
    }(UIImageView())
    
    let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let bookableIntervalLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var callButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemGreen
        $0.setTitle("Call to book".uppercased(), for: .normal)
        $0.tintColor = .white
        $0.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        return $0
    }(UIButton(type: .infoLight))
}
