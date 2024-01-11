//
//  HeadlineView.swift
//  MovieForToday
//
//  Created by Alex on 06.01.2024.
//

import SwiftUI

struct HeadlineView: View {
    let headline: LocalizedStringKey
    let action: () -> Void
    
    var body: some View {
        HStack() {
            Text(headline)
                .foregroundStyle(.textWhiteGrey)
                .font(.custom(.montSemiBold, size: 16))
            
            Spacer()
            
            Button("see_all", action: action)
                .foregroundStyle(.customMint)
                .font(.custom(.montMedium, size: 14))
        }
        .padding([.leading, .trailing])
    }
}

#Preview {
    HeadlineView(headline: "categories", action: {})
        .background(.customMain)
}
