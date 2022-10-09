//
//  UIFont+Utils.swift
//  Stravaganza
//
//  Created by Marcos Federico Varani on 07/10/2022.
//

import UIKit

extension UIFont {
    
    static func abelRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Abel-Regular", size: size) ?? systemFont(ofSize: size)
    }
}
