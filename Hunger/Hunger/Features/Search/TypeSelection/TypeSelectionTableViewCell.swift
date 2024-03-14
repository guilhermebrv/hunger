//
//  TypeSelectionTableViewCell.swift
//  Hunger
//
//  Created by Guilherme Viana on 14/03/2024.
//

import UIKit

class TypeSelectionTableViewCell: UITableViewCell {
	var buttons: [String] = ["Brazilian", "Hamburguer", "Pizza", "Falafel", "Vegan", "Vegetarian", "Sushi", "Japanese", "Chinese", "Mexican", "Italian", "Fast Food", "Bakery", "Coffee", "Bar", "Pub"]
	var collectionView: UICollectionView!
	static let identifier = String(describing: TypeSelectionTableViewCell.self)

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		backgroundColor = .secondarySystemBackground
		let layout = UICollectionViewFlowLayout()
	    layout.scrollDirection = .vertical
	    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
	    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
	    collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = .clear
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.dataSource = self
		collectionView.isScrollEnabled = false
		collectionView.delegate = self
		collectionView.register(TypeSelectionCollectionViewCell.self, forCellWithReuseIdentifier: TypeSelectionCollectionViewCell.identifier)
	    contentView.addSubview(collectionView)
		collectionView.pin(to: contentView)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

extension TypeSelectionTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return buttons.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeSelectionCollectionViewCell.identifier, for: indexPath) as? TypeSelectionCollectionViewCell
		cell?.button.setTitle(buttons[indexPath.row], for: .normal)
		return cell ?? UICollectionViewCell()
	}


}
