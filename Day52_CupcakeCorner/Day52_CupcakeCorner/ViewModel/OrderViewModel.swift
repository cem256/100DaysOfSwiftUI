//
//  OrderViewModel.swift
//  Day52_CupcakeCorner
//
//  Created by cem on 8.08.2023.
//

import Foundation


class OrderViewModel : ObservableObject{
    
    @Published var model : OrderModel
    @Published var alertTitle : String = ""
    @Published var alertDescription : String = ""
    @Published var showingConfirmation: Bool = false
    
    init(model: OrderModel) {
        self.model = model
    }
    
    func placeOrder(order : OrderModel) async {
        guard let encoded = try? JSONEncoder().encode(order) else {
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
            alertDescription = "Your order for \(decodedOrder.quantity)x \(OrderModel.types[decodedOrder.selectedTypeIndex].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed.")
            alertTitle = "Oops"
            alertDescription = "Something went wrong while processing your order"
            showingConfirmation = true
        }
    }
}
