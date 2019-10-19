//
//  ContentView.swift
//  BetterRest
//
//  Created by Frank Guchelaar on 19/10/2019.
//  Copyright © 2019 Awesomation. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()

    var body: some View {
        NavigationView {
            Form {
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%.3g") hours")
                }

                DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
            }
            .navigationBarTitle("Better Rest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
