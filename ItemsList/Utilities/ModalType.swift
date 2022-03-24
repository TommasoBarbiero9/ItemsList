//
//  ModalType.swift
//  ItemsList
//
//  Created by Tommaso Barbiero on 23/03/22.
//

import Foundation

enum ModalType: Identifiable {
    var id: String {
        switch self {
            case .add: return "add"
            case .update: return "update"
        }
    }
    
    case add
    case update(Item)
}
