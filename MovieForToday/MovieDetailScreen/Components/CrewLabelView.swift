//
//  CrewLabelView.swift
//  MovieForToday
//
//  Created by Alex on 02.01.2024.
//

import SwiftUI

struct CrewLabelView: View {
    let image: Image
    let name: String
    let role: String
    
    var body: some View {
        HStack {
            image
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                        
            VStack(alignment: .leading) {
                Text(name)
                    .foregroundStyle(Color.textColor(.whiteGrey))
                    .font(.custom(.montSemiBold, size: 14))
                    .padding(.bottom, 5)
                
                Text(role)
                    .foregroundStyle(Color.textColor(.grey))
                    .font(.custom(.montRegular, size: 10))
            }
        }
        .padding(.leading)
    }
}

#Preview {
    CrewLabelView(image: Image(.topGunVert), name: "Matt Reeves", role: "Director")
        .background(Color.customMain)
}
