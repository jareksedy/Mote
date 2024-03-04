//
//  UIFont+Rounded.swift
//  Mote
//
//  Created by Ярослав on 04.03.2024.
//

import SwiftUI

extension UIFont {
    func rounded() -> UIFont {
        guard let descriptor = fontDescriptor.withDesign(.rounded) else {
            return self
        }

        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
