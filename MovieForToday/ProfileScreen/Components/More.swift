//
//  More.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/25/23.
//

import SwiftUI

struct More: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("More")
                    .padding()
                    .font(Font.custom(CustomFont.montSemiBold, size: 18))
                    .foregroundColor(.white)
                    .padding(.leading, 16)
                Spacer()
            }
            
            NavigationSettings(imageIcon: "shield", textNavigation: "Legal and Policies", destination: PrivacyPolicy())
        
            Divider().background(.gray)
                .padding(.horizontal, 16)
                .opacity(0.3)
            NavigationSettings(imageIcon: "alert", textNavigation: "About Us", destination: EmptyView())
        }
        .background(Color.customMain)
        .cornerRadius(16)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 1.0)
                .opacity(0.2)
        }
        .padding(.horizontal, 24)
    }
}


#Preview {
    More()
}
