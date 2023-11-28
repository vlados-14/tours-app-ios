//
//  GenericViewControllerWithNavItems.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import UIKit

class GenericViewControllerWithNavItems: UIViewController {
    
    private let navBarImageSize = CGSize(width: 32, height: 32)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
    }
    
    private func setupNavigationBarItems() {
        //should be added with a custom image
        let moreButton = UIBarButtonItem(title: "...", style: .plain, target: self, action: #selector(handleMore))
        moreButton.tintColor = .black
        
        guard let logoImage = UIImage(named: "imaginary_logo") else { return }
        let logo = UIBarButtonItem(image: UIImage.resize(image: logoImage, targetSize: navBarImageSize), style: .plain, target: self, action: #selector(handleLogoTapped))
        
        let title = UIBarButtonItem(title: "Tourify App", style: .plain, target: self, action: #selector(handleTitle))
        title.tintColor = .black
        
        navigationItem.leftBarButtonItems = [logo,title]
        navigationItem.rightBarButtonItem = moreButton
    }
    
    @objc private func handleLogoTapped() {}
    
    @objc private func handleMore() {}
                                             
    @objc private func handleTitle() {}
}
