//
//  AddUpdateItem.swift
//  ItemsList
//
//  Created by Tommaso Barbiero on 23/03/22.
//

import SwiftUI

struct AddUpdateItem: View {
    
    @ObservedObject var viewModel: AddUpdateItemViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("item title", text: $viewModel.itemTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button {
                viewModel.addUpdateAction {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text(viewModel.buttonTitle)
            }

        }
    }
}


//struct AddUpdateItem_Preview: PreviewProvider {
//    static var previews: some View {
//        AddUpdateItem(viewModel: AddUpdateItemViewModel())
//    }
//}
