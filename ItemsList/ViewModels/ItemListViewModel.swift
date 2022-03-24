//
//  ItemListViewModel.swift
//  ItemsList
//
//  Created by Tommaso Barbiero on 23/03/22.
//

import Foundation

class ItemListViewModel: ObservableObject {
    @Published var items = [Item]()
    
    func fetchItems() async throws {
        let urlString = Constants.baseURL + EndPoints.items
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.badUrl
        }
        
        let itemResponse: [Item] = try await HTTPClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.items = itemResponse
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { i in
            guard let itemID = items[i].id else {
                return
            }
            
            guard let url = URL(string: Constants.baseURL + EndPoints.items + "/\(itemID)") else {
                return
            }
            
            Task {
                do {
                    try await HTTPClient.shared.delete(at: itemID, url: url)
                } catch {
                    print("❌ Error: \(error)")
                }
            }
        }
        
        items.remove(atOffsets: offsets)
    }
}
