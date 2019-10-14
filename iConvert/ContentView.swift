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
    @State private var inputUnit = [0,0,0,0,0]
    @State private var outputUnit = [1,1,1,1,1]
    @State private var convertOption = 0
    
    let convert = ["Temperature", "Volume", "Length", "Area", "Mass"]
    
    var unitsAllNames = [
        ["Fahrenheit", "Celsius", "Kelvin"],
        ["ml", "cups"],
        ["miles", "kilometres", "nautical miles", "nm"],
        ["acres", "square metres", "hectares"],
        ["carats", "tonnes", "pounds"]]
    
    var unitsAll : [[Dimension]] = [
        [UnitTemperature.fahrenheit, UnitTemperature.celsius, UnitTemperature.kelvin],
        [UnitVolume.milliliters, UnitVolume.cups],
        [UnitLength.miles, UnitLength.kilometers, UnitLength.nauticalMiles, UnitLength.nanometers],
        [UnitArea.acres, UnitArea.squareMeters, UnitArea.hectares],
        [UnitMass.carats, UnitMass.metricTons, UnitMass.pounds]]
    
    var unitNames : [String] {
        return unitsAllNames[convertOption]
    }
    
    var units : [Dimension] {
            return unitsAll[convertOption]
    }
    
    var inputNumber : Double {
        var input = inputValue.replacingOccurrences(of: Locale.current.decimalSeparator ?? ".", with: ".")
        input = input.replacingOccurrences(of: Locale.current.groupingSeparator ?? "", with: "")
        return Double(input) ?? 0
    }
    
    var input : Measurement<Dimension> {
        Measurement(value: inputNumber, unit: units[inputUnit[convertOption]])
    }
    
    var output : Measurement<Dimension> {
        input.converted(to: units[outputUnit[convertOption]])
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
                    Picker("Input Unit", selection: $inputUnit[convertOption]) {
                        ForEach(0 ..< unitNames.count, id: \.self) {
                            Text("\(self.unitNames[$0])")
                        }
                    }
                    .id(convertOption)
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Convert to")) {
                    Picker("Input Unit", selection: $outputUnit[convertOption]) {
                        ForEach(0 ..< unitNames.count, id: \.self) {
                            Text("\(self.unitNames[$0])")
                        }
                    }
                    .id(convertOption)
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("\(input.description) converts to")) {
                    Text(output.description)
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
