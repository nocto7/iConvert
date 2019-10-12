//
//  ContentView.swift
//  iConvert
//
//  Created by kirsty darbyshire on 11/10/2019.
//  Copyright © 2019 kirsty darbyshire. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    
    let units = ["Fahrenheit", "Celsius", "Kelvin"]
    
    var inputTemp : Measurement<UnitTemperature>? {
        var input = inputValue.replacingOccurrences(of: Locale.current.decimalSeparator ?? ".", with: ".")
        input = input.replacingOccurrences(of: Locale.current.groupingSeparator ?? "", with: "")
        let inputNumber = Double(input) ?? 0
        
        var inputTemp : Measurement<UnitTemperature>
        
        switch inputUnit {
        case 0:
            inputTemp = Measurement(value: inputNumber, unit: UnitTemperature.fahrenheit)
        case 1:
            inputTemp = Measurement(value: inputNumber, unit: UnitTemperature.celsius)
        case 2:
            inputTemp = Measurement(value: inputNumber, unit: UnitTemperature.kelvin)
        default:
            return nil
        }
        
        return inputTemp
    }
    
    var outputTemp : Measurement<UnitTemperature>? {
        
        guard let input = inputTemp else { return nil }
        var outputTemp : Measurement<UnitTemperature>
        
        switch outputUnit {
        case 0:
            outputTemp = input.converted(to: UnitTemperature.fahrenheit)
        case 1:
            outputTemp = input.converted(to: UnitTemperature.celsius)
        case 2:
            outputTemp = input.converted(to: UnitTemperature.kelvin)
        default:
            return nil
        }
        
        return outputTemp
    }
    
    var inputTempString : String {
        guard let input = inputTemp else { return "" }
        return input.description 
    }
    
    var outputTempString : String {
        guard let output = outputTemp else { return "" }
        return output.description
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What temperature would you like to convert?")) {
                    TextField("Input", text: $inputValue).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Convert from")) {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Convert to")) {
                    Picker("Input Unit", selection: $outputUnit) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("\(inputTempString) converts to")) {
                    if outputTemp != nil {
                        Text(outputTempString)
                    }
                }
            }.navigationBarTitle("iConvert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
