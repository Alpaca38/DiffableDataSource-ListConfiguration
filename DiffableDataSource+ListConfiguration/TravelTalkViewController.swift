//
//  TravelTalkViewController.swift
//  DiffableDataSource+ListConfiguration
//
//  Created by 조규연 on 7/19/24.
//

import UIKit
import SnapKit

final class TravelTalkViewController: UIViewController {
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private var dataSource: UICollectionViewDiffableDataSource<String, ChatRoom>!
    private var list = ChatRoomList.mockChatList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "TRAVEL TALK"
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        configureDataSource()
        updateSnapshot()
    }
}

private extension TravelTalkViewController {
    func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        config.backgroundColor = .systemBackground
        config.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    func configureDataSource() {
        var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, ChatRoom>!
        cellRegistration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.chatroomName
            content.textProperties.font = .boldSystemFont(ofSize: 14)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let dateString = itemIdentifier.chatList.last?.date, let date = formatter.date(from: dateString) else { return }
            content.secondaryText = date.formatted(.dateTime.year(.twoDigits).month(.twoDigits).day(.twoDigits).locale(Locale(identifier: "ko_KR")))
            content.secondaryTextProperties.font = .systemFont(ofSize: 11)
            
            guard let chatRoomImage = itemIdentifier.chatroomImage.first else { return }
            content.image = UIImage(named: chatRoomImage)
            content.imageProperties.maximumSize = CGSize(width: 50, height: 50)
            content.imageProperties.reservedLayoutSize = CGSize(width: 40, height: 40)
            content.imageToTextPadding = 20
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .clear
            
            cell.backgroundConfiguration = backgroundConfig
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<String, ChatRoom>()
        snapshot.appendSections(["Travel Talk"])
        snapshot.appendItems(list, toSection: "Travel Talk")
        dataSource.apply(snapshot)
    }
}
