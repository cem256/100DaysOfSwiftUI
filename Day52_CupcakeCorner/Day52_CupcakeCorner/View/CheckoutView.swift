//
//  CheckoutView.swift
//  Day52_CupcakeCorner
//
//  Created by cem on 8.08.2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderViewModel: OrderViewModel

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(orderViewModel.model.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await orderViewModel.placeOrder(order: orderViewModel.model)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(orderViewModel.alertTitle, isPresented: $orderViewModel.showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(orderViewModel.alertDescription)
        }
    }


}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderViewModel: OrderViewModel(model: OrderModel()))
    }
}
