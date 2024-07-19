//
//  SettingOptions.swift
//  DiffableDataSource+ListConfiguration
//
//  Created by 조규연 on 7/18/24.
//

import Foundation

enum SettingOptions: Int, CaseIterable {
    case total, personal, others
    
    var mainOptions: String {
        switch self {
        case .total:
            return "전체 설정"
        case .personal:
            return "개인 설정"
        case .others:
            return "기타"
        }
    }
    
    var subOptions: [String] {
        switch self {
        case .total:
            return ["공지사항", "실험실", "버전 정보"]
        case .personal:
            return ["개인/보안", "알림", "채팅", "멀티 프로필"]
        case .others:
            return ["고객센터/도움말"]
        }
    }
    
    var imageName: String {
        switch self {
        case .total:
            return "star"
        case .personal:
            return "person"
        case .others:
            return "heart"
        }
    }
}
