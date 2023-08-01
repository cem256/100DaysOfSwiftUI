//
//  ContentView.swift
//  Day19_Challange
//
//  Created by cem on 31.07.2023.
//

import SwiftUI

struct ContentView: View {
    let temperatureUnits: [String] = ["Celcius", "Fahrenheit", "Kelvin"]
    @State private var fromUnitIndex: Int = 0
    @State private var toUnitIndex: Int = 0
    @State private var temperatureValue: Double = 0
    @FocusState private var isValueFocused: Bool
    
    var result: Double {
        let inputTemperature = Measurement(value: temperatureValue, unit: getUnit(fromUnitIndex))
        let outputTemperature = inputTemperature.converted(to: getUnit(toUnitIndex))
        return outputTemperature.value
    }
    
    func getUnit(_ index: Int) -> UnitTemperature {
        switch index {
        case 0:
            return .celsius
        case 1:
            return .fahrenheit
        case 2:
            return .kelvin
        default:
            return .celsius
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header : Text("Value")) {
                    TextField("Enter the value", value: $temperatureValue, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .focused($isValueFocused)
                }
                
                Section(header: Text("From")) {
                    Picker("From", selection: $fromUnitIndex) {
                        ForEach(0..<temperatureUnits.count) {
                            Text(temperatureUnits[$0])
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section(header: Text("To")) {
                    Picker("To", selection: $toUnitIndex) {
                        ForEach(0..<temperatureUnits.count) {
                            Text(temperatureUnits[$0])
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section(header: Text("Result")) {
                    Text("\(result, specifier: "%.2f")")
                }
            }.navigationTitle("Day 19 Challange")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard, content: {
                        Spacer()
                        Button("Done"){
                            isValueFocused = false
                        }
                    })
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
