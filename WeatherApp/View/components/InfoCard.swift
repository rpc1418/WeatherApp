//
//  InfoCard.swift
//  WeatherApp
//
//  Created by rentamac on 28/01/2026.
//

import SwiftUI



struct InfoCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack (alignment: .leading){
            Text(title)
                .font(.title2)
                .foregroundStyle(.gray)
                .bold()
                .multilineTextAlignment(.leading)
            Text(value)
                .font(.title)
                .bold()
                .foregroundStyle(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)

        .background(.gray.opacity(0.3))
        .cornerRadius(10)
    }
}

