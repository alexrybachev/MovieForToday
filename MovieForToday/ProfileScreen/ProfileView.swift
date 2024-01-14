//
//  ProfileView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @AppStorage("showSignIn") var showSignInView = false
    @AppStorage("isAuthorisation") var isAuthorisation = false
    @StateObject var errorMessage = ErrorMessage()
    
    @StateObject private var viewModel = SignInViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    Color((PrimaryColor.mainDark.rawValue))
                        .ignoresSafeArea()
                    
                    VStack(spacing: 14)  {
                        
                        HeaderView(
                            profileImage: viewModel.profileImage, isAuthorisation: $isAuthorisation, name: viewModel.currentUser?.name ?? "",
                            mail: viewModel.currentUser?.email ?? "")
                        
                        if isAuthorisation {
                            WishlistProfile()
                        }
                        
                        General()
                        
                        More()
                        
                        CustomButton(text: isAuthorisation ? "Log Out" : "LogIn", color: Color.black, action: {
                            Task {
                                if isAuthorisation {
                                    do {
                                        try FirebaseManager.shared.signOut()
                                        isAuthorisation = false
                                    } catch {
                                        self.errorMessage.error = error.localizedDescription
                                    }
                                } else {
                                    self.showSignInView = true
                                    viewModel.currentUser = nil
                                }
                            }
                        })
                        .padding(.horizontal, 16)
                    }
                    
                    .padding(.bottom, 70)
                }
            }
            .background(Color(PrimaryColor.mainDark.rawValue))
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear() {
                if Auth.auth().currentUser != nil {
                    Task {
                        do {
                            try await viewModel.fetchUser()
                            self.isAuthorisation = true
                        } catch {
                            print("Error fetching user data: \(error.localizedDescription)")
                            self.errorMessage.error = error.localizedDescription
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
                            self.errorMessage.error = error.localizedDescription
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $showSignInView) {
                LogInView(showSignInView: $showSignInView, isAuthorisation: $isAuthorisation)
            }
        }
    }
    
}

#Preview {
    ProfileView()
}
