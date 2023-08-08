//
//  CheckoutView.swift
//  Day52_CupcakeCorner
//
//  Created by cem on 8.08.2023.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: OrderViewModel

    @State private var confirmationMessage = ""
    @State private var alertTitle = ""
    @State private var showingConfirmation = false

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

                Text("Your total is \(order.model.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle, isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.model) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)

            let decodedOrder = try JSONDecoder().decode(OrderModel.self, from: data)
            alertTitle = "Thank You"
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderModel.types[decodedOrder.selectedTypeIndex].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed.")
            alertTitle = "Oops"
            confirmationMessage = "Something went wrong while processing your order"
            showingConfirmation = true
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: OrderViewModel(model: OrderModel()))
    }
}
