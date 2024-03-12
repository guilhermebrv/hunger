//
//  AppDelegate.swift
//  Hunger
//
//  Created by Guilherme Viana on 06/03/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	let tabBarController = TabBarController()
	let restSearchVC = SearchRestaurantViewController()

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
	[UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		window?.backgroundColor = .systemBackground
		displayTabBar()
		return true
	}
}

extension AppDelegate {	
	private func displayTabBar() {
		setRootViewController(tabBarController, animated: true)
		tabBarController.navigationController?.navigationBar.isHidden = true
	}
}

extension AppDelegate {
	func setRootViewController(_ viewController: UIViewController, animated: Bool = true) {
		guard animated, let window = self.window else {
			self.window?.rootViewController = UINavigationController(rootViewController: viewController)
			self.window?.makeKeyAndVisible()
			return
		}

		window.rootViewController = UINavigationController(rootViewController: viewController)
		window.makeKeyAndVisible()
		UIView.transition(with: window,
						  duration: 0.5,
						  options: .transitionCrossDissolve,
						  animations: nil,
						  completion: nil)
	}
}
