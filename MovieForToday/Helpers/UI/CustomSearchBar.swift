//
//  CustomSearchBar.swift
//  MovieForToday
//
//  Created by Alex on 06.01.2024.
//

import SwiftUI


struct CustomSearchBar: View {
    @FocusState private var isFocused: Bool
    @Binding var searchText: String
    @Binding var isSearch: Bool
    
    let placeholderText: LocalizedStringKey
    let action: (String) -> Void
    
    var body: some View {
        HStack {
            HStack {
                Image(.search)
                    .colorMultiply(.textGrey)
                
                TextField(placeholderText, text: $searchText)
                    .foregroundStyle(Color.textWhiteGrey)
                    .focused($isFocused)
                    .onChange(of: isFocused) { newValue in
                        withAnimation {
                            isSearch = newValue
                        }
                    }
                    .onSubmit {
                        print("search text: ", searchText)
                        action(searchText)
                        print("status search bar:", isSearch)
                    }
            }
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .font(.montMedium14)
            .background(.customSoftDark)
            .clipShape(.rect(cornerRadius: 24))
            
            if isSearch && !searchText.isEmpty {
                Button {
                    withAnimation {
                        searchText = ""
                        isFocused = false
                    }
//                    action()
                } label: {
                    Text("cancel")
                        .font(.custom(.montMedium, size: 14))
                        .foregroundStyle(.textWhiteGrey)
                }
                .transition(.opacity)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.customMain.ignoresSafeArea()
        VStack {
            CustomSearchBar(
                searchText: .constant(""),
                isSearch: .constant(true),
                placeholderText: "search_a_title..",
                action: { _ in}
            )
            Spacer()
        }
    }
}
