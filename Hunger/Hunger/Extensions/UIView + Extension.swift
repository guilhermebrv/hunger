//
//  UIView + Extension.swift
//  Hunger
//
//  Created by Guilherme Viana on 12/03/2024.
//

import UIKit

extension UIView {
	public func pin(to superview: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor),
			bottomAnchor.constraint(equalTo: superview.bottomAnchor)
		])
	}
	public func pinWithSpace(to superview: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor, constant: 8),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 16),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -16),
			bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -16)
		])
	}
}
