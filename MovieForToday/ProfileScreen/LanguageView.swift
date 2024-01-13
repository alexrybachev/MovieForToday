//
//  LanguageView.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 1/11/24.
//

import SwiftUI

struct LanguageView: View {
    @AppStorage("isEnglishSelected") private var isEnglishSelected = false
    @AppStorage("isRussianSelected") private var isRussianSelected = true
    
    var body: some View {
        ZStack {
            Color((PrimaryColor.mainDark.rawValue))
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("Suggested Languages")
                            .font(Font.custom(CustomFont.montSemiBold, size: 12))
                            .foregroundColor(.gray)
                            .padding(.leading, 16)
                            .padding(.top, 24)
                        Spacer()

                    }
                    HStack() {
                        Button {
                            isEnglishSelected.toggle()
                            isRussianSelected.toggle()
                        } label: {
                            HStack {
                                Text("English")
                                    .font(Font.custom(CustomFont.montSemiBold, size: 15))
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName:  isEnglishSelected ? "checkmark" : "")
                                    .foregroundColor(Color.primaryColor(.mint))
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 18)
                    .padding(.top, 26)
                    
                    Divider().background(.gray)
                        .padding(.horizontal, 16)
                        .opacity(0.2)
                    
                    HStack {
                        Button {
                            isEnglishSelected.toggle()
                            isRussianSelected.toggle()
                        } label: {
                            HStack {
                                Text("Russian")
                                    .font(Font.custom(CustomFont.montSemiBold, size: 15))
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: isRussianSelected ? "checkmark" : "")
                                    .foregroundColor(Color.primaryColor(.mint))
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                    .padding(.top, 16)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray, lineWidth: 1.0)
                        .opacity(0.2)
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
    LanguageView()
}
