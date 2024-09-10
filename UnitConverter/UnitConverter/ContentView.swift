//
//  ContentView.swift
//  UnitConverter
//
//  Created by Ali Syed on 2024-09-10.
//

import SwiftUI

struct ContentView: View {
    let time_measurements = ["seconds", "minutes", "hours", "day"]
    @State private var inputUnit = "seconds"
    @State private var outputUnit = "seconds"
    @State private var userTimeInput = 0.0
    
    @FocusState private var timeInputHasBeenSelected: Bool
    
    var convertedTime: Double {
        var inputValueInSeconds = 0.0
        
        //Convert any input unit to base unit (seconds)
        if inputUnit == time_measurements[0] { //seconds
            inputValueInSeconds = userTimeInput
        } else if inputUnit == time_measurements[1] { //minutes
            inputValueInSeconds = userTimeInput * 60.0
        } else if inputUnit == time_measurements[2] { // hours
            inputValueInSeconds = userTimeInput * 60.0 * 60.0
        } else { //day
            inputValueInSeconds = userTimeInput * 24.0 * 60.0 * 60.0
        }
        
        var result = 0.0
        
        //Convert base unit to desired output unit
        if outputUnit == time_measurements[0] { //seconds
            result = inputValueInSeconds
        } else if outputUnit == time_measurements[1] { //minutes
            result = inputValueInSeconds / 60.0
        } else if outputUnit == time_measurements[2] { // hours
            result = inputValueInSeconds / (60.0 * 60.0)
        } else { //day
            result = inputValueInSeconds / (24.0 * 60.0 * 60.0)
        }
        
        return result
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter a number") {
                    TextField("Amount", value: $userTimeInput, format: .number)
                }
                .keyboardType(.decimalPad)
                .focused($timeInputHasBeenSelected)
                Section("Input unit") {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(time_measurements, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Output unit") {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(time_measurements, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Result of conversion") {
                    Text(convertedTime, format: .number)
                }
            }
            .navigationTitle("Time Converter")
            .toolbar {
                if timeInputHasBeenSelected {
                    Button("Done") {
                        timeInputHasBeenSelected = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
