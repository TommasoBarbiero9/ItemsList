//
//  Item.swift
//  ItemsList
//
//  Created by Tommaso Barbiero on 23/03/22.
//

import Foundation

struct Item: Identifiable, Codable {
    let id: UUID?
    var title: String?
}
