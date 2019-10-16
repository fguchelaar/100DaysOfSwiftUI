//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Frank Guchelaar on 16/10/2019.
//  Copyright © 2019 Awesomation. All rights reserved.
//

import SwiftUI

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

struct Prominent: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle)
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }

    func prominent() -> some View {
        self.modifier(Prominent())
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.yellow
                .edgesIgnoringSafeArea(.all)
                .watermarked(with: "Frank was here")
            Text("Hello world")
                .prominent()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
