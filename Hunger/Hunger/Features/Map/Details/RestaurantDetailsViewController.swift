//
//  RestaurantDetailsViewController.swift
//  Hunger
//
//  Created by Guilherme Viana on 20/03/2024.
//

import UIKit
import MapKit

class RestaurantDetailsViewController: UIViewController {
	var detailsView: RestaurantDetailsView?
	let selectedItem: String

	init(selectedItem: String) {
		self.selectedItem = selectedItem
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		detailsView = RestaurantDetailsView()
		view = detailsView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		signProtocols()
    }

}

extension RestaurantDetailsViewController {
	private func signProtocols() {
		detailsView?.detailsTableView.delegate = self
		detailsView?.detailsTableView.dataSource = self
	}
}

extension RestaurantDetailsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: InfoDetailsTableViewCell.identifier, for: indexPath) as? InfoDetailsTableViewCell
		cell?.setupCell(item: selectedItem)
		return cell ?? UITableViewCell()
	}
}
