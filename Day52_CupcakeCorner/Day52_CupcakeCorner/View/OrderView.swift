//
//  OrderView.swift
//  Day52_CupcakeCorner
//
//  Created by cem on 8.08.2023.
//

import SwiftUI

struct OrderView: View {
    @StateObject var orderViewModel = OrderViewModel(model: OrderModel())

       var body: some View {
           NavigationView {
               Form {
                   Section {
                       Picker("Select your cake type", selection: $orderViewModel.model.selectedTypeIndex) {
                           ForEach(OrderModel.types.indices) {
                               Text(OrderModel.types[$0])
                           }
                       }

                       Stepper("Number of cakes: \(orderViewModel.model.quantity)", value: $orderViewModel.model.quantity, in: 3...20)
                   }

                   Section {
                       Toggle("Any special requests?", isOn: $orderViewModel.model.specialRequestEnabled.animation())

                       if orderViewModel.model.specialRequestEnabled {
                           Toggle("Add extra frosting", isOn: $orderViewModel.model.extraFrosting)
                           Toggle("Add extra sprinkles", isOn: $orderViewModel.model.addSprinkles)
                       }
                   }

                   Section {
                       NavigationLink {
                           AddressView(order: orderViewModel)
                       } label: {
                           Text("Delivery details")
                       }
                   }
               }
               .navigationTitle("Cupcake Corner")
           }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
