//
//  ProfileView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI

struct ProfileView: View {
    @State var profileImage: String?
    @State var name: String?
    @State var mail: String
    @State var showSignInView: Bool = false
    @StateObject private var viewModel = SignInViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color((PrimaryColor.softDark.rawValue))
                    .ignoresSafeArea()
                VStack(spacing: 14)  {
                    HeaderView(
                        profileImage: $profileImage, name: $name,
                                mail: $mail)
                    General()
                    More()
                    Spacer()
                    CustomButton(text: "Log Out", color: Color.black, action: {
                        Task {
                            do {
                                try FirebaseManager.shared.signOut()
                                 self.showSignInView = true
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    })
                    .padding(.horizontal, 16)
                }
            }
        }
        .background(Color(PrimaryColor.softDark.rawValue))
        .navigationTitle("Profile")
        .onAppear() {
            let authUser = try?  FirebaseManager.shared.getAuthenticatedUser()
            self.showSignInView = (authUser == nil) ? true : false
        }
        .fullScreenCover(isPresented: $showSignInView)  {
            NavigationView {
                LogInView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    ProfileView(profileImage: "margot", name: "Margot", mail: "margo@gmail.com")
}
