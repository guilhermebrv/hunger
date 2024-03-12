//
//  RestaurantResultsViewController.swift
//  Hunger
//
//  Created by Guilherme Viana on 11/03/2024.
//

import UIKit

protocol RestaurantResultsViewControllerDelegate: AnyObject {
	func selectedRestaurant()
}

class RestaurantResultsViewController: UIViewController, UINavigationBarDelegate {
	var listView: RestaurantResultsView?
	private let viewModel: RestaurantResultsViewModel = RestaurantResultsViewModel()

	override func loadView() {
		super.loadView()
		listView = RestaurantResultsView()
		view = listView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		signProtocols()
    }

	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationBar.backgroundColor = .systemBackground
		navigationItem.title = "Restaurants"
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

extension RestaurantResultsViewController {
	private func signProtocols() {
		listView?.restaurantsTableView.delegate = self
		listView?.restaurantsTableView.dataSource = self
	}
}

extension RestaurantResultsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.numberOfRowsInSection
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: SelectedRestaurantTableViewCell.identifier,
												 for: indexPath) as? SelectedRestaurantTableViewCell
		return cell ?? UITableViewCell()
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		viewModel.heightForRowAt
	}
}
