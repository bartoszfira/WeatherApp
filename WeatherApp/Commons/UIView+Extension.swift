//
//  UIView+Extension.swift
//  WeatherApp
//
//  Created by Bartek Fira on 31/05/2022.
//

import UIKit

extension UIView {
    
    static var identifier: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
