//
//  HeadlineView.swift
//  MovieForToday
//
//  Created by Alex on 06.01.2024.
//

import SwiftUI

struct HeadlineView: View {
    let headline: LocalizedStringKey
    var isAddButton = true
    let action: () -> Void
    
    var body: some View {
        HStack() {
            Text(headline)
                .foregroundStyle(Color.textWhiteGrey)
                .font(.custom(.montSemiBold, size: 16))
            
            Spacer()
            
            if isAddButton {
                Button("see_all", action: action)
                    .foregroundStyle(Color.customMint)
                    .font(.custom(.montMedium, size: 14))
            }
        }
        .padding([.leading, .trailing])
    }
}

#Preview("true") {
    HeadlineView(headline: "categories", isAddButton: true, action: {})
        .background(Color.customMain)
}

#Preview("false") {
    HeadlineView(headline: "categories", isAddButton: false, action: {})
        .background(Color.customMain)
}
