//
//  ViewController.swift
//  UICollectionViewDemo
//
//  Created by Jayesh Kawli on 12/21/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var profiles: [Profile] = []

    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    private enum LayoutConstant {
        static let spacing: CGFloat = 16.0
        static let itemHeight: CGFloat = 300.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        populateProfiles()
        collectionView.reloadData()
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.identifier)
    }

    private func setupLayouts() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        // Layout constraints for `collectionView`
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func populateProfiles() {
        profiles = [
            Profile(name: "Thor", location: "Boston", imageName: "astronomy", profession: "astronomy"),
            Profile(name: "Mike", location: "Albequerque", imageName: "basketball", profession: "basketball"),
            Profile(name: "Walter White", location: "New Mexico", imageName: "chemistry", profession: "chemistry"),
            Profile(name: "Sam Brothers", location: "California", imageName: "geography", profession: "geography"),
            Profile(name: "Chopin", location: "Norway", imageName: "geometry", profession: "geometry"),
            Profile(name: "Castles", location: "UK", imageName: "history", profession: "history"),
            Profile(name: "Dr. Johnson", location: "Australia", imageName: "microscope", profession: "microscope"),
            Profile(name: "Tom Hanks", location: "Bel Air", imageName: "theater", profession: "theater"),
            Profile(name: "Roger Federer", location: "Switzerland", imageName: "trophy", profession: "trophy"),
            Profile(name: "Elon Musk", location: "San Francisco", imageName: "graduate", profession: "graduate")
        ]
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profiles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell

        let profile = profiles[indexPath.row]
        cell.setup(with: profile)
        cell.contentView.backgroundColor = .red
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)

        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2

        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow

        return floor(finalWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
}
