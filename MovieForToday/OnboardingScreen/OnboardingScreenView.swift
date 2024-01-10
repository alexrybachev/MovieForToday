//
//  OnboardingScreenView.swift
//  MovieForToday
//
//  Created by Мирсаит Сабирзянов on 03.01.2024.
//

import SwiftUI

struct OnboardingScreenView: View {
    
    @StateObject var vm = OnboardingViewModel()
    @AppStorage("isOnboarding") var isOnboarding = false

    var body: some View {
        TabView(selection: $vm.currentStep) {
            ForEach(vm.source.indices, id: \.self) { it in
                VStack {
                    Image(vm.source[it].image)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .padding(.top, 0)
                        .clipShape(.rect(cornerRadius: 10))
                        .shadow(radius: 10)
                        .padding(10)
                    
                    Text(vm.source[it].title)
                        .font(.custom(.montSemiBold, size: 23))                                .bold()
                        .foregroundStyle(.white)
                    
                    Text(vm.source[it].description)
                        .font(.custom(.montSemiBold, size: 16))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .padding(.top, 16)
                    
                    Spacer()


                    HStack {
                        ForEach(vm.source.indices, id: \.self) { it in
                            if it == vm.currentStep{
                                Rectangle()
                                    .frame(width: 20, height: 10)
                                    .cornerRadius(10)
                                    .foregroundColor(Color.customMint)
                            }
                            else{
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(Color.customMintDark)
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            if vm.stepHandler() {
                                isOnboarding.toggle()
                            }
                        } label: {
                            Image(vm.source[it].buttonImage)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .scaledToFit()
                                .padding(10)
                        }
                    }
                    .padding(.horizontal, 25)
                }
                .tag(it)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    
    }
}

#Preview {
    OnboardingScreenView()
}
