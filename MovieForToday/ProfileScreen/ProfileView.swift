//
//  ProfileView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct ProfileView: View {
    var profileImage: String
    @Binding var name: String
    @Binding var mail: String
    var body: some View {
        NavigationView {
            ZStack {
                Color((PrimaryColor.softDark.rawValue))
                    .ignoresSafeArea()
                VStack(spacing: 14)  {
                    HeaderView(profileImage: profileImage, name: name, mail: mail)
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
    ProfileView(profileImage: "margot", name: .constant("Margot"), mail: .constant("margo@gmail.com"))
}
