//
//  SearchRestaurantViewController.swift
//  Hunger
//
//  Created by Guilherme Viana on 11/03/2024.
//

import UIKit

protocol SearchRestaurantViewControllerDelegate: AnyObject {
	func searchButtonClicked()
}

class SearchRestaurantViewController: UIViewController {
	weak var delegate: SearchRestaurantViewControllerDelegate?
	var searchView: SearchRestaurantView?

	override func loadView() {
		super.loadView()
		searchView = SearchRestaurantView()
		view = searchView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		signProtocols()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationBar.backgroundColor = .systemBackground
		navigationItem.title = "Search"
		navigationItem.titleView?.tintColor = .label
		let appearance = UINavigationBarAppearance()
			appearance.configureWithTransparentBackground()
			appearance.backgroundColor = UIColor.clear

			let blurEffect = UIBlurEffect(style: .regular) // Choose your style: .light, .extraLight, .dark, etc.
			let blurView = UIVisualEffectView(effect: blurEffect)
			blurView.frame = self.navigationController?.navigationBar.bounds ?? CGRect.zero
			blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

			appearance.backgroundEffect = blurEffect
			navigationController?.navigationBar.standardAppearance = appearance
			navigationController?.navigationBar.scrollEdgeAppearance = appearance
			navigationController?.navigationBar.isTranslucent = true
	}

}

extension SearchRestaurantViewController: SearchRestaurantViewDelegate {
	func searchButtonClicked() {
		delegate?.searchButtonClicked()
	}
}

extension SearchRestaurantViewController {
	private func signProtocols() {
		searchView?.delegate = self
	}
}
