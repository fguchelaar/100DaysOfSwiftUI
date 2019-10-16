//
//  ContentView.swift
//  UnitConversion
//
//  Created by Frank Guchelaar on 14/10/2019.
//  Copyright © 2019 Awesomation. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedFromType = 0
    @State private var selectedToType = 0
    @State private var input = "0"

    private var output: Double {
        let inputValue = Double(input) ?? 0;

        let measurement = Measurement(value: inputValue, unit: unitTypes[selectedFromType].1)

        return measurement.converted(to: unitTypes[selectedToType].1).value
    }

    private let unitTypes = [
        ("meters", UnitLength.meters),
        ("kilometers", UnitLength.kilometers),
        ("feet", UnitLength.feet),
        ("yard", UnitLength.yards),
        ("miles", UnitLength.miles)
    ]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("From")) {
                    TextField("Input value", text: $input).keyboardType(.decimalPad)

                    Picker("From units", selection: $selectedFromType) {
                        ForEach(0..<unitTypes.count) {
                            Text("\(self.unitTypes[$0].0)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("To")) {
                    Picker("To units", selection: $selectedToType) {
                        ForEach(0..<unitTypes.count) {
                            Text("\(self.unitTypes[$0].0)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Text("\(output, specifier: "%.2f")")
                }

            }
            .navigationBarTitle("Unit Conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
