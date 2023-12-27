//
//  LogIn View.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/27/23.
//

import SwiftUI

struct LogIn_View: View {
    @State var name: String
    @State var mail: String
    var body: some View {
        ZStack {
            Color((PrimaryColor.softDark.rawValue))
                .ignoresSafeArea()
            VStack(alignment: .center, spacing: 20) {
                Spacer()
                FullName(name: name)
                Email(mail: mail)
                
                Spacer().frame(height: 170)
                
                CustomButton(text: "Registration", color: Color.black, action: {print(#function)})
                    .padding(.horizontal, 16)
                CustomButton(text: "Login", color: Color(PrimaryColor.mint.rawValue), action: {print(#function)})
                    .padding(.horizontal, 16)
            }
            .padding()
        }
    }
}

#Preview {
    LogIn_View(name: "", mail: "")
}
