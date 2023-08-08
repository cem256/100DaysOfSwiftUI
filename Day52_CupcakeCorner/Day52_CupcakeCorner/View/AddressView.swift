//
//  AddressView.swift
//  Day52_CupcakeCorner
//
//  Created by cem on 8.08.2023.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: OrderViewModel

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.model.name)
                TextField("Street address", text: $order.model.streetAddress)
                TextField("City", text: $order.model.city)
                TextField("Zip", text: $order.model.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.model.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderViewModel(model: OrderModel()))
    }
}
