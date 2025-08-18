//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Amelia Riddell on 8/15/25.
//

import SwiftUI

struct TitleStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .fontWeight(.bold)
    }
}

extension View {
    public func titleStyle() -> some View {
        self.modifier(TitleStyle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .titleStyle()
    }
}

#Preview {
    ContentView()
}
