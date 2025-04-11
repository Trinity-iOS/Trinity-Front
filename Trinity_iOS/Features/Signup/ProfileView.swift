//
//  ProfileView.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/10/25.
//

import SwiftUI
import ComposableArchitecture

struct ProfileView: View {
    @Bindable var store: StoreOf<ProfileFeature>

    var body: some View {
        VStack(spacing: 20) {
            Button("프로필이에용") {
                store.send(.nextButtonTapped)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal)
        }
        .padding()
        .navigationBarHidden(true)
    }
}
