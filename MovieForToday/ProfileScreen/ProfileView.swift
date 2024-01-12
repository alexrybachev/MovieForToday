//
//  ProfileView.swift
//  MovieForToday
//
//  Created by Aleksandr Rybachev on 23.12.2023.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
//    @State var profileImage: UIImage?
    @AppStorage("showSignIn") var showSignInView = false
    
    @StateObject private var viewModel = SignInViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    Color((PrimaryColor.mainDark.rawValue))
                        .ignoresSafeArea()
                    
                    VStack(spacing: 14)  {
                        if !showSignInView {
                            
                            HeaderView(
                                profileImage: viewModel.profileImage, name: viewModel.currentUser?.name ?? "",
                                mail: viewModel.currentUser?.email ?? "")
                            
                            WishlistProfile()

                            General()
                            
                            More()
                            
//                            Spacer()
                            
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
    
    
}

#Preview {
    ProfileView()
}
