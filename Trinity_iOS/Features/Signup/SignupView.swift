//
//  SignupView.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/9/25.
//

import ComposableArchitecture
import SwiftUI

struct SignupView: View {
    @Bindable var store: StoreOf<SignupFeature>

    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            Color.clear
                .allowsHitTesting(false) 
                .onAppear {
                    store.send(.startSignup)
                }
        } destination: { store in
            switch store.case {
            case .verifyCode(let store):
                VerifyCodeView(store: store)
            case .phoneNumber(let store):
                PhoneNumberView(store: store)
            case .id(let store):
                IdView(store: store)
            case .profile(let store):
                ProfileView(store: store)
            case .interest(let store):
                InterestView(store: store)
            case .portfolio(let store):
                PortfolioView(store: store)
            case .description(let store):
                DescriptionView(store: store)
            }
        }
    }
}
