//
//  SwiftUIView.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/25/23.
//

import SwiftUI

struct NavigationSettings<Destination: View>: View {
    var imageIcon: String
    var textNavigation: String
    var destination: Destination
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(imageIcon)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 10)
                Text(textNavigation)
                    .font(Font.custom(CustomFont.montMedium, size: 14))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
                    Image("rightArrow")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
        }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.customMain)
    }
}

#Preview {
    NavigationSettings(imageIcon: "notification", textNavigation: "Notification", destination: EmptyView())
}
