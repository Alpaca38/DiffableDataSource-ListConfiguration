//
//  ViewController.swift
//  DiffableDataSource+ListConfiguration
//
//  Created by 조규연 on 7/18/24.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private var dataSource: UICollectionViewDiffableDataSource<SettingOptions, SettingItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "설정"
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        configureDataSource()
        updateSnapshot()
    }
}

private extension SettingViewController {
    func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        config.headerMode = .supplementary
        config.backgroundColor = .systemBackground
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    func configureDataSource() {
        var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, SettingItem>!
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.subOption
            content.textProperties.font = .boldSystemFont(ofSize: 15)
            
            content.image = UIImage(systemName: itemIdentifier.image)
            content.imageProperties.tintColor = .systemPurple
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            
            var content = UIListContentConfiguration.groupedHeader()
            content.text = section.mainOptions
            content.textProperties.font = .boldSystemFont(ofSize: 20)
            
            supplementaryView.contentConfiguration = content
        }
        
        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SettingOptions, SettingItem>()
        snapshot.appendSections(SettingOptions.allCases)
        SettingOptions.allCases.forEach { option in
            let items = option.subOptions.map { subOptions in
                SettingItem(subOption: subOptions, image: option.imageName)
            }
            snapshot.appendItems(items, toSection: option)
        }
        
        dataSource.apply(snapshot)
    }
}
