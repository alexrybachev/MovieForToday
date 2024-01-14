//
//  AboutUsView.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 1/12/24.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        ZStack {
            
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("Teamlead")
                            .padding()
                            .font(Font.custom(CustomFont.montSemiBold, size: 18))
                            .foregroundColor(.white)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    Divider().background(.gray)
                        .padding(.horizontal, 16)
                        .opacity(0.2)
                    HStack {
                        Text("Team")
                            .padding()
                            .font(Font.custom(.montSemiBold, size: 18))
                            .foregroundColor(.white)
                            .padding(.leading, 16)
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    AboutUsView()
}
