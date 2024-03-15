//
//  SearchTableViewCell.swift
//  Hunger
//
//  Created by Guilherme Viana on 15/03/2024.
//

import UIKit

protocol SearchTableViewCellDelegate: AnyObject {
	func tappedSearchButton()
}

class SearchTableViewCell: UITableViewCell {
	let view = SearchTableViewCellView()
	weak var delegate: SearchTableViewCellDelegate?
	static let identifier = String(describing: SearchTableViewCell.self)

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .secondarySystemBackground
		contentView.addSubview(view)
		view.pin(to: contentView)
		view.delegate = self
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension SearchTableViewCell: SearchTableViewCellViewDelegate {
	func tappedSearchButton() {
		delegate?.tappedSearchButton()
	}
}
