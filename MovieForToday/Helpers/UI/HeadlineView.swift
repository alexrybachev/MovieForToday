//
//  HeadlineView.swift
//  MovieForToday
//
//  Created by Alex on 06.01.2024.
//

import SwiftUI

struct HeadlineView: View {
    let headline: String
    let action: () -> Void
    
    var body: some View {
        HStack() {
            Text(headline)
                .foregroundStyle(Color.textColor(.whiteGrey))
                .font(.custom(.montSemiBold, size: 16))
            
            Spacer()
            
            Button("see_all", action: action)
                .foregroundStyle(Color.primaryColor(.mint))
                .font(.custom(.montMedium, size: 14))
        }
        .padding([.leading, .trailing])
    }
}

#Preview {
    HeadlineView(headline: "Categories", action: {})
        .background(Color.customMain)
}
