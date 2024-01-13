//
//  DetailTextView.swift
//  MovieForToday
//
//  Created by Alex on 11.01.2024.
//

import SwiftUI

struct DetailTextView: View {
    let descriptionMovie: String
    let headlineTextSize: CGFloat
    let subheadlineTextSize: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
//            Text("story_line")
//                .foregroundStyle(.textWhiteGrey)
//                .font(.custom(.montSemiBold, size: headlineTextSize))
            
            Text(descriptionMovie)
                .foregroundStyle(.textWhiteGrey)
                .font(.custom(.montRegular, size: subheadlineTextSize))
                .padding(.bottom)
            
//            Text("cast_and_crew")
//                .foregroundStyle(.textWhiteGrey)
//                .font(.custom(.montSemiBold, size: headlineTextSize))
        }
        .padding()
    }
}

#Preview {
    DetailTextView(
        descriptionMovie: "For the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk. More", 
        headlineTextSize: 16,
        subheadlineTextSize: 14
    )
        .background(.customMain)
}
