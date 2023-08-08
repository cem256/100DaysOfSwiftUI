//
//  OrderViewModel.swift
//  Day52_CupcakeCorner
//
//  Created by cem on 8.08.2023.
//

import Foundation


class OrderViewModel : ObservableObject{
    
    @Published var model : OrderModel
    
    init(model: OrderModel) {
        self.model = model
    }
}
