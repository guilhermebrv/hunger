//
//  TypeSelectionTableViewCell.swift
//  Hunger
//
//  Created by Guilherme Viana on 14/03/2024.
//

import UIKit

class TypeSelectionTableViewCell: UITableViewCell {
	var collectionView: UICollectionView?
	static let identifier = String(describing: TypeSelectionTableViewCell.self)
	var callback: ((_ collectionViewCell: TypeSelectionCollectionViewCell) -> Void)?

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .secondarySystemBackground
		setupCollectionView()
		signProtocols()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension TypeSelectionTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
									  UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return RestaurantTypes.typeOfFood.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeSelectionCollectionViewCell.identifier,
													  for: indexPath) as? TypeSelectionCollectionViewCell
		cell?.button.setTitle(RestaurantTypes.typeOfFood[indexPath.row], for: .normal)
		cell?.delegate = self
		return cell ?? UICollectionViewCell()
	}
}

extension TypeSelectionTableViewCell {
	private func signProtocols() {
		guard let collectionView else { return }

		collectionView.dataSource = self
		collectionView.delegate = self
	}
	private func setupCollectionView() {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

		guard let collectionView else { return }

		contentView.addSubview(collectionView)
		collectionView.pinWithSpace(to: contentView)
		collectionView.backgroundColor = .secondarySystemBackground
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.isScrollEnabled = false
		collectionView.allowsSelection = true
		collectionView.isUserInteractionEnabled = true
		collectionView.allowsMultipleSelection = false
		collectionView.register(TypeSelectionCollectionViewCell.self,
								forCellWithReuseIdentifier: TypeSelectionCollectionViewCell.identifier)
	}
}

extension TypeSelectionTableViewCell: TypeSelectionCollectionViewCellDelegate {
	func tappedTypeSelectionButton(in collection: TypeSelectionCollectionViewCell) {
		callback?(collection)
	}
}
