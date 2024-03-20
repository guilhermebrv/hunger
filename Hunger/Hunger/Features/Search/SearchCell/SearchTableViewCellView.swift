//
//  SearchTableViewCellView.swift
//  Hunger
//
//  Created by Guilherme Viana on 15/03/2024.
//

import UIKit

protocol SearchTableViewCellViewDelegate: AnyObject {
	func tappedSearchButton()
}

class SearchTableViewCellView: UIView {
	weak var delegate: SearchTableViewCellViewDelegate?
	let searchButton = UIButton(type: .system)

	override init(frame: CGRect) {
		super.init(frame: frame)
		createElements()
		addElements()
		configConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension SearchTableViewCellView {
	private func createElements() {
		searchButton.translatesAutoresizingMaskIntoConstraints = false
		searchButton.configuration = .filled()
		searchButton.configuration?.title = "Search for place to eat 🍽️"
		searchButton.configuration?.buttonSize = .large
		searchButton.configuration?.baseBackgroundColor = .systemBlue
		searchButton.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
		searchButton.isEnabled = false
	}
	private func addElements() {
		addSubview(searchButton)
	}
	private func configConstraints() {
		NSLayoutConstraint.activate([
			searchButton.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
			searchButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
			trailingAnchor.constraint(equalToSystemSpacingAfter: searchButton.trailingAnchor, multiplier: 2)
		])
	}
}

extension SearchTableViewCellView {
	@objc func tappedSearchButton() {
		delegate?.tappedSearchButton()
	}
}
