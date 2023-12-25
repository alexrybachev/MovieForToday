//
//  ProfileView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color((PrimaryColor.softDark.rawValue))
                    .ignoresSafeArea()
                VStack(spacing: 14)  {
                    HeaderView(profileImage: "margot", name: "Margot", mail: "margo@gmail.com")
                    General()
                    More()
                    Spacer()
                }
            }
        }
        .background(Color(PrimaryColor.softDark.rawValue))
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfileView()
}
