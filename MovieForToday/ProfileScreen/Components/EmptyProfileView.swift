//
//  EmptyProfileView.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 1/5/24.
//

import SwiftUI

struct EmptyProfileView: View {
    var body: some View {
        ZStack {
            Color((PrimaryColor.softDark.rawValue))
                .ignoresSafeArea()
        }
    }
}

#Preview {
    EmptyProfileView()
}
