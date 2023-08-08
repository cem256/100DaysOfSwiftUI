//
//  AddressView.swift
//  Day52_CupcakeCorner
//
//  Created by cem on 8.08.2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderViewModel: OrderViewModel

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderViewModel.model.name)
                TextField("Street address", text: $orderViewModel.model.streetAddress)
                TextField("City", text: $orderViewModel.model.city)
                TextField("Zip", text: $orderViewModel.model.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(orderViewModel: orderViewModel)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(orderViewModel.model.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderViewModel: OrderViewModel(model: OrderModel()))
    }
}
