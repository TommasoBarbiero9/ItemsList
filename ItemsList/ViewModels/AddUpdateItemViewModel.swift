//
//  AddUpdateItemViewModel.swift
//  ItemsList
//
//  Created by Tommaso Barbiero on 23/03/22.
//

import SwiftUI

final class AddUpdateItemViewModel: Identifiable, ObservableObject {
    @Published var itemTitle = ""
    
    var itemID: UUID?
    
    var isUpdating: Bool {
        itemID != nil
    }
    
    var buttonTitle: String {
        itemID != nil ? "UpdateItem" : "Add Item"
    }
    
    init() { }
    
    init(currentItem: Item) {
        self.itemTitle = currentItem.title ?? "tomFaiCagare"
        self.itemID = currentItem.id
    }
    
    func addItem() async throws {
        let urlString = Constants.baseURL + EndPoints.items
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.badUrl
        }
        
        let item = Item(id: nil, title: itemTitle)
        
        try await HTTPClient.shared.sendData(to: url, object: item, httpMethod: HTTPMethods.POST.rawValue)
    }
    
    func updateItem() async throws {
        let urlString = Constants.baseURL + EndPoints.items
        guard let url = URL(string: urlString) else {
            throw HTTPError.badUrl
        }
        
        let itemToUpdate = Item(id: itemID, title: itemTitle)
        try await HTTPClient.shared.sendData(to: url, object: itemToUpdate, httpMethod: HTTPMethods.PUT.rawValue)
    }
    
    func addUpdateAction(completion: @escaping () -> Void) {
        Task {
            do {
                if isUpdating {
                    try await updateItem()
                } else {
                    try await addItem()
                }
            } catch {
                print("❌ Error: \(error)")
            }
            completion()
        }
    }
}
