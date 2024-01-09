//
//  ProfileView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State var profileImage: String?
    @AppStorage("showSignIn") var showSignInView = false
    
    @StateObject private var viewModel = SignInViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color((PrimaryColor.softDark.rawValue))
                    .ignoresSafeArea()
                
                VStack(spacing: 14)  {
                    if !showSignInView {
                        
                        HeaderView(
                            profileImage: profileImage, name: viewModel.currentUser?.name ?? "",
                            mail: viewModel.currentUser?.email ?? "")
                        
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
                    } else {
                        EmptyProfileView()
                    }
                }
            }
        }
        .background(Color(PrimaryColor.softDark.rawValue))
        .navigationTitle("Profile")
        .onAppear() {
            if Auth.auth().currentUser != nil {
                Task {
                    do {
                        try await viewModel.fetchUser()
                        self.showSignInView = false
                    } catch {
                        print("Error fetching user data: \(error.localizedDescription)")
                    }
                }
            }
        }
        .onChange(of: showSignInView) { showSignInView in
            if !showSignInView {
                Task {
                    do {
                        try await viewModel.fetchUser()
                    } catch {
                        
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showSignInView)  {
            NavigationView {
                LogInView(showSignInView: $showSignInView)
            }
        }
    }
    
    
}

#Preview {
    ProfileView(profileImage: "margot")
}
