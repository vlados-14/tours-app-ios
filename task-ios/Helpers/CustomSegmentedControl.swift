//
//  CustomSegmentedControl.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {
    
    //Custom class created in case we need to customize the appearance of the segmented control
    override init(items: [Any]?) {
        super.init(items: items)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
