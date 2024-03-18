//
//  TabBarController.swift
//  Hunger
//
//  Created by Guilherme Viana on 12/03/2024.
//

import UIKit

class TabBarController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTabBar()
	}

	private func setupTabBar() {
		let search = UINavigationController(rootViewController: SearchRestaurantViewController())
		//let favorites = UINavigationController(rootViewController: RestaurantResultsViewController(foodType: <#String?#>))
		setViewControllers([search], animated: false)

		let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
		tabBarAppearance.configureWithDefaultBackground()
		tabBarAppearance.backgroundColor = .systemBackground

		tabBar.isTranslucent = false
		tabBar.tintColor = .label
		tabBar.standardAppearance = tabBarAppearance
		tabBar.scrollEdgeAppearance = tabBarAppearance
		tabBar.unselectedItemTintColor = .black

		guard let items = tabBar.items else { return }
		items[0].image = UIImage(systemName: "fork.knife")
		items[0].title = "Search"
		//items[1].image = UIImage(systemName: "star")
		//items[1].title = "Favorites"
	}
}
