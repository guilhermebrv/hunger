//
//  UIViewController + Extension.swift
//  Hunger
//
//  Created by Guilherme Viana on 12/03/2024.
//

import UIKit

extension UIViewController {
	func configureNavBar(title: String) {
		setNavBarTitle(with: title)
		setNavBarAppearance()
	}
	private func setNavBarTitle(with title: String) {
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.title = title
		navigationItem.titleView?.tintColor = .label
	}
	private func setNavBarAppearance() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithTransparentBackground()
		appearance.backgroundColor = .secondarySystemBackground

		let blurEffect = UIBlurEffect(style: .regular)
		let blurView = UIVisualEffectView(effect: blurEffect)
		blurView.frame = self.navigationController?.navigationBar.bounds ?? CGRect.zero
		blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

		appearance.backgroundEffect = blurEffect
		
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
		navigationController?.navigationBar.isTranslucent = true
	}
}
