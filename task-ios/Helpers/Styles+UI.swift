//
//  Styles+UI.swift
//  task-ios
//
//  Created by Vladislav Kobyakov on 28.11.23.
//

import UIKit

///Mark: UIColor helper methods
public extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: alpha)
    }
    
    convenience init(all: Int) {
        self.init(red: all, green: all, blue: all)
    }
    
    struct ToursApp {
        static let mainBackground = UIColor.white
    }
}

///Mark: UIImage helper methods
extension UIImage {
    static func resize(image: UIImage, targetSize: CGSize, tintColor: UIColor? = nil) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        guard let imageToReturn = newImage else { return UIImage() }
        
        if let tintColor = tintColor {
            return imageToReturn.withRenderingMode(.alwaysTemplate).withTintColor(tintColor)
        } else {
            return imageToReturn.withRenderingMode(.alwaysOriginal)
        }
    }
}
