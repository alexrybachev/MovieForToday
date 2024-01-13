//
//  SwitchCategoriesButton.swift
//  MovieForToday
//
//  Created by Alex on 05.01.2024.
//

import SwiftUI

struct SwitchCategoriesButton: View {
    
    @Binding var selectedTag: Int
    var id: Int
    
    let genre: String
    let action: () -> Void
    
    var body: some View {
        Text(genre.capitalized)
            .padding([.top, .bottom], 8)
            .padding([.leading, .trailing], 12)
            .foregroundStyle(id == selectedTag ? Color.customMint : Color.textWhiteGrey)
            .if(id == selectedTag) { $0.background(.customSoftDark) }
            .font(.custom(.montMedium, size: 12))
            .clipShape(.rect(cornerRadius: 8))
            .onTapGesture {
                selectedTag = id
                action()
            }
    }
}

#Preview {
    SwitchCategoriesButton(
        selectedTag: .constant(1),
        id: 1,
        genre: "action",
        action: {}
    )
    .background(Color.customMain)
}
