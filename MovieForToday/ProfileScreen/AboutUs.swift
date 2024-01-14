//
//  AboutUs.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 1/14/24.
//

import SwiftUI

struct AboutUs: View {
    
    var developers: [String : String] = [
        "ilya": "Ilia Shapovalov",
        "deny": "Daniil Kulikovskiy",
        "alex": "Alex Zhulai",
        "mirsait": "Mirsait Sabirzyanov",
        "andrey": "Andrey Bo",
    ]
    
    var body: some View {
        ZStack() {
            Color(.customMain)
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Teamlead")
                            .font(Font.custom(.montSemiBold, size: 18))
                            .foregroundColor(.white)
                            .padding(.leading, 32)
                            .padding(.top, 12)
                            .padding(.bottom, 6)
                        Spacer()
                    }
                    
                    HStack {
                        Image("sashateamlead")
                            .resizable()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                            .frame(width: 65, height: 65)
                            .padding(.leading, 26)
                        Text("Alex Rybachev")
                            .foregroundStyle(.white)
                            .padding(.leading, 22)
                            .font(Font.custom(.montMedium, size: 18))
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .cornerRadius(16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1.0)
                            .opacity(0.2)
                    }
                    
                    HStack {
                        Text("Developers")
                            .font(Font.custom(.montSemiBold, size: 18))
                            .foregroundColor(.white)
                            .padding(.leading, 32)
                            .padding(.top, 12)
                            .padding(.bottom, 6)
                        Spacer()
                    }
                    
                    ForEach(developers.sorted(by: <), id: \.key) { image, name in
                        HStack {
                            Image(image)
                                .resizable()
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
                                .frame(width: 65, height: 65)
                                .padding(.leading, 26)
                            Text(name)
                                .foregroundStyle(.white)
                                .padding(.leading, 22)
                                .font(Font.custom(.montMedium, size: 18))
                            Spacer()
                        }
                    }
                    .padding(.vertical, 10)
                    .cornerRadius(16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray, lineWidth: 1.0)
                            .opacity(0.2)
                    }
                    HStack(alignment: .center) {
                        Spacer()
                        Text("No testers were harmed during development. MIT License.")
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                CustomBackButton()
            }
        }
    }
}


#Preview {
    AboutUs()
}
