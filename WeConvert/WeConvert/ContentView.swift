//
//  ContentView.swift
//  WeConvert
//
//  Created by Amelia Riddell on 8/11/25.
//

import SwiftUI

struct ContentView: View {
    let measurements: [UnitLength] = [
            .centimeters,
            .meters,
            .kilometers,
            .inches,
            .feet,
            .yards,
            .miles
        ]
        
    @State private var selectedInputMeasurement = UnitLength.meters
    @State private var selectedOutputMeasurement = UnitLength.meters
    
    @State private var inputDouble = 0.0
    @State private var outputDouble = 0.0
    
    @FocusState private var amountIsFocused: Bool
        
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Enter value", value: $inputDouble, format: .number.precision(.fractionLength(4)))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Measurement", selection: $selectedInputMeasurement) {
                        ForEach(measurements, id: \.self) { unit in
                            Text(unit.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                Section("Output") {
                    Text(outputDouble.formatted(.number.precision(.fractionLength(4))))
                    
                    Picker("Measurement", selection: $selectedOutputMeasurement) {
                        ForEach(measurements, id: \.self) { unit in
                            Text(unit.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        .task(id: inputDouble) {
            convert()
        }
        .task(id: selectedInputMeasurement.symbol) {
            convert()
        }
        .task(id: selectedOutputMeasurement.symbol) {
            convert()
        }
    }
    
    func convert() {
            let inputMeasurement = Measurement(value: inputDouble, unit: selectedInputMeasurement)
            let outputMeasurement = inputMeasurement.converted(to: selectedOutputMeasurement)
            outputDouble = outputMeasurement.value
        }
}

#Preview {
    ContentView()
}
