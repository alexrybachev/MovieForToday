//
//  EditProfile.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/26/23.
//

import SwiftUI
import FirebaseAuth

struct EditProfile: View {
    @Environment(\.presentationMode) var rootView
    @Binding var profileImage: UIImage?
    @State var name: String
    @State var mail: String
    @StateObject private var viewModel = SignInViewModel()
    @State private var isPresentAlert = false
    @State private var isImagePicker = false
    
    var body: some View {
        VStack {
            ZStack {
                Color((PrimaryColor.mainDark.rawValue))
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    Button {
                        isImagePicker.toggle()
                    } label: {
                        ZStack {
                            image(image: profileImage)
                                .resizable()
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                                .frame(width: 74, height: 74)
                            Image("editProfileAvatar")
                                .offset(x: 20, y: 20)
                                .frame(width: 32, height: 32)
                        }
                    }
                    
                    Text(name)
                        .foregroundStyle(.white)
                        .font(.custom(.montSemiBold, size: 14))
                    
                    Text(verbatim: mail)
                        .foregroundStyle(.textGrey)
                        .font(.custom(.montMedium, size: 14))
                        .padding(.top, -8)
                    
                    CustomTextField(value: $name, titleBorder: "Full Name", offsetNameX: -128, offsetNameY: -28, placeHolder: "Enter your full name")
                        .padding(.top, 40)
                    
                    CustomTextField(value: $mail, titleBorder: "@Mail", offsetNameX: -140, offsetNameY: -28, placeHolder: "Enter your @mail")
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    CustomButton(text: "Save changes", color: Color(PrimaryColor.mint.rawValue), action: {
                        Task {
                            do {
                                //                                try await FirebaseManager.shared.updateEmail(email: mail)
                                isPresentAlert = true
                                try await FirebaseManager.shared.updateName(name: name)
                                print("Change mail and password")
                            } catch let error {
                                throw error
                            }
                        }
                    })
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                    .alert(isPresented: $isPresentAlert, content: {
                        Alert(title: Text("The user name was be changed to - \(name)"), dismissButton: .default(Text("Ok")) {
                            isPresentAlert = false
                            rootView.wrappedValue.dismiss()
                        })
                    })
                    .sheet(isPresented: $isImagePicker) {
                        ImagePicker(image: $profileImage)
                    }
                }
                
                .padding(.top, 20)
            }
            .foregroundColor(.white)
        }
        .navigationTitle("Edit Profile")
    }
    func image(image: UIImage?) -> Image {
        if let profileImage = image {
            return Image(uiImage: profileImage)
        } else {
            return  Image(uiImage: UIImage(named: "margot")!)
        }
    }
}

#Preview {
    EditProfile( profileImage: .constant(UIImage(named: "margo")), name: "Margo", mail: "margo@gmail.com")
}
