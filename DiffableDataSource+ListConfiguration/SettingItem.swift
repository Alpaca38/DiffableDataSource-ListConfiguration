//
//  SettingItem.swift
//  DiffableDataSource+ListConfiguration
//
//  Created by 조규연 on 7/18/24.
//

import Foundation

struct SettingItem: Hashable, Identifiable {
    let id = UUID().uuidString
    let subOption: String
    let image: String
}
