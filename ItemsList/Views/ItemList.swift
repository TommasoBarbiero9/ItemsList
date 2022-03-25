//
//  ItemList.swift
//  ItemsList
//
//  Created by Tommaso Barbiero on 23/03/22.
//

import SwiftUI

struct ItemList: View {
    
    @StateObject var viewModel = ItemListViewModel()
    
    @State var modal: ModalType? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    Button {
                        modal = .update(item)
                    } label: {
                        Text(item.title ?? "")
                            .font(.title3)
                            .foregroundColor(Color(.label))
                    }
                }.onDelete(perform: viewModel.delete)
            }
            .navigationTitle(Text("Items"))
            .toolbar {
                Button {
                    modal = .add
                } label: {
                    Label("add item", systemImage: "plus.circle")
                }
            }
        }
        .sheet(item: $modal, onDismiss: {
            Task {
                do {
                    try await viewModel.fetchItems()
                } catch {
                    print("❌ Error: \(error)")
                }
            }
        }) { modal in
            switch modal {
                case .add:
                    AddUpdateItem(viewModel: AddUpdateItemViewModel())
                case .update(let item):
                    AddUpdateItem(viewModel: AddUpdateItemViewModel(currentItem: item))
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchItems()
                } catch {
                    print("❌ Error: \(error)")
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemList()
//    }
//}
