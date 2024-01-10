//
//  GeneralDetailVIew.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 1/10/24.
//

import SwiftUI

struct NotificationVIew: View {
    @StateObject private var viewModel = SignInViewModel()
    var body: some View {
        ZStack {
            Color((PrimaryColor.mainDark.rawValue))
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("Messages Notifications")
                            .font(Font.custom(CustomFont.montSemiBold, size: 12))
                            .foregroundColor(Color(TextColors.grey.rawValue))
                            .padding(.leading, 16)
                            .padding(.top, 24)
                        Spacer()
                    }
                    HStack() {
                        Text("Show Notifications")
                            .font(Font.custom(CustomFont.montSemiBold, size: 15))
                            .foregroundColor(.white)
                        Toggle(isOn: $viewModel.showNotification) {
                           //add notification
                        }
                        .padding(.leading, 0)
                        .toggleStyle(SwitchToggleStyle(tint: Color(PrimaryColor.mint.rawValue)))
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 18)
                    .padding(.top, 26)
                    
                    Divider().background(.gray)
                        .padding(.horizontal, 16)
                        .opacity(0.3)
                    
                    HStack {
                        Text("Exceptions")
                            .font(Font.custom(CustomFont.montSemiBold, size: 15))
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                    .padding(.top, 16)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 1.0)
                        .opacity(0.3)
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                Spacer()
            }
        }
        .navigationTitle("Notification")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        NotificationVIew()
    }
}
