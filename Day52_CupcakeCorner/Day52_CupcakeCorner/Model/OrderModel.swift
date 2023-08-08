//
//  OrderModel.swift
//  Day52_CupcakeCorner
//
//  Created by cem on 8.08.2023.
//

import Foundation

struct OrderModel : Codable {
    
    static let types : [String] = ["Vanilla","Strawberry","Chocolate","Rainbow"]
    
    var quantity : Int = 3
    var selectedTypeIndex : Int = 0
    
    var extraFrosting : Bool = false
    var addSprinkles : Bool = false
    
    var name : String = ""
    var streetAddress : String = ""
    var city : String = ""
    var zip : String = ""
    
    
    var specialRequestEnabled : Bool = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
              return false
          }

          return true
      }

    var cost: Double {
          // $2 per cake
        var cost  = Double(quantity) * 2

          // complicated cakes cost more
          cost += (Double(selectedTypeIndex) / 2)

          // $1/cake for extra frosting
          if extraFrosting {
              cost += Double(quantity)
          }

          // $0.50/cake for sprinkles
          if addSprinkles {
              cost += Double(quantity) / 2
          }

          return cost
      }

    
}
