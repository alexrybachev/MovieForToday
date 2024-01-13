//
//  PrivacyPolicy.swift
//  MovieForToday
//
//  Created by Daniil Kulikovskiy on 12/26/23.
//

import SwiftUI

struct PrivacyPolicy: View {
    var body: some View {
        ZStack {
            Color.customMain
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Tearms")
                        .font(.custom(.montSemiBold, size: 14))
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.")
                        .padding(.top, 6)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.")
                    
                    Text("Changes to the Service and/or Terms:")
                        .font(.custom(.montSemiBold, size: 14))
                        .padding(.top, 20)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.")
                        .padding(.top, 6)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames.")
                    Spacer()
                }
                .font(.custom(.montMedium, size: 14))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
        }
        .navigationTitle("Privcy Policy")
    }
}

#Preview {
    PrivacyPolicy()
}
