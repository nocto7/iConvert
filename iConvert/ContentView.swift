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
    @State private var convertOption = 0
    
    let convert = ["Temperature", "Volume"]
    
    let unitsTemp = ["Fahrenheit", "Celsius", "Kelvin"]
    let unitsVol = ["ml", "cups"]
    
    var unitsAll : [[String]] {
        return [unitsTemp, unitsVol]
    }
    
    var units : [String] {
        return unitsAll[convertOption]
    }
    
    var inputNumber : Double {
        var input = inputValue.replacingOccurrences(of: Locale.current.decimalSeparator ?? ".", with: ".")
        input = input.replacingOccurrences(of: Locale.current.groupingSeparator ?? "", with: "")
        return Double(input) ?? 0
    }
    
    var inputTemp : Measurement<UnitTemperature>? {
        switch inputUnit {
        case 0:
            return Measurement(value: inputNumber, unit: UnitTemperature.fahrenheit)
        case 1:
            return Measurement(value: inputNumber, unit: UnitTemperature.celsius)
        case 2:
            return Measurement(value: inputNumber, unit: UnitTemperature.kelvin)
        default:
            return nil
        }
    }
    
    var outputTemp : Measurement<UnitTemperature>? {
        guard let input = inputTemp else { return nil }
        switch outputUnit {
        case 0:
            return input.converted(to: UnitTemperature.fahrenheit)
        case 1:
            return input.converted(to: UnitTemperature.celsius)
        case 2:
            return input.converted(to: UnitTemperature.kelvin)
        default:
            return nil
        }
    }
    
    var inputVol : Measurement<UnitVolume>? {
        switch inputUnit {
        case 0:
            return Measurement(value: inputNumber, unit: UnitVolume.milliliters)
        case 1:
            return Measurement(value: inputNumber, unit: UnitVolume.cups)
        default:
            return nil
        }
    }
    
    var outputVol : Measurement<UnitVolume>? {
        guard let input = inputVol else { return nil }
        switch outputUnit {
        case 0:
            return input.converted(to: UnitVolume.milliliters)
        case 1:
            return input.converted(to: UnitVolume.cups)
        default:
            return nil
        }
    }
    
    var inputString : String {
        switch convertOption {
        case 0: // temperature
            return inputTemp?.description ?? ""
        case 1: // volume
            return inputVol?.description ?? ""
        default:
            return ""
        }
    }
    
    var outputString : String {
        switch convertOption {
        case 0: // temperature
            return outputTemp?.description ?? ""
        case 1: // volume
            return outputVol?.description ?? ""
        default:
            return ""
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What do you want to convert?")) {
                    
                    Picker("Convert", selection: $convertOption) {
                        ForEach(0 ..< convert.count, id: \.self) {
                            Text("\(self.convert[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Enter the \(convert[convertOption])")) {
                    TextField("Input", text: $inputValue).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Convert from")) {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(0 ..< units.count, id: \.self) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .id(convertOption)
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Convert to")) {
                    Picker("Input Unit", selection: $outputUnit) {
                        ForEach(0 ..< units.count, id: \.self) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .id(convertOption)
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("\(inputString) converts to")) {
                    Text(outputString)
                    
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
