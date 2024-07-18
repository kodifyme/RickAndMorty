//
//  UIStackView + Extensions.swift
//  RickAndMorty
//
//  Created by KOДИ on 17.07.2024.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat,
                     aligment: UIStackView.Alignment) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = aligment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
