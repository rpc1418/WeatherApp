//
//  Untitled.swift
//  WeatherApp
//
//  Created by rentamac on 23/01/2026.
//

import SwiftUI

struct DeveloperInfoView: View {
    @State private var rotation: Angle = .degrees(0)

    var body: some View {
        ZStack{
            Color("backgroundColor").ignoresSafeArea()
            VStack{
                Text("Hello, world!")
                    .profileTextStyle(.white)
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .rotationEffect(rotation)
                    .animation(
                        .linear(duration: 4).repeatForever(autoreverses: false),
                        value: rotation
                    )
                    .onAppear {
                        withAnimation {
                            rotation = .degrees(360)
                        }
                    }
                Text("I am Rudraksh Chourey!").bold()
                    .underline()
                    .profileTextStyle(.white)
                Text("I work in encora as a iOS Developer!").bold()
                    .underline()
                    .profileTextStyle(.white)
                Text("SwiftUI Developer with starting in iOS development. Passionate about creating user-friendly and efficient applications!").profileTextStyle(.white)
            }
        }
    }
}

extension View {
    func profileTextStyle(_ color: Color) -> some View {
        self
            .fontDesign(.serif)
            .italic()
            .foregroundStyle(color)
            .multilineTextAlignment(.center)
            .animation(.bouncy, value: color)
    }
}
