//
//  PosterLabelView.swift
//  MovieForToday
//
//  Created by Alex on 09.01.2024.
//

import SwiftUI

struct PosterLabelView: View {
    let title: String
    let subtitle: String
    let spacing: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Text(title)
                .foregroundStyle(.textWhiteGrey)
                .font(.custom(.montSemiBold, size: 16))
            
            Text(subtitle)
                .foregroundStyle(.textWhiteGrey)
                .font(.custom(.montMedium, size: 12))
        }
    }
}

#Preview {
    PosterLabelView(
        title: "Top Gun",
        subtitle: "Action",
        spacing: 16
    )
    .background(.customMain)
}
