//
//  ContentView.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 3/29/25.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {
    @Bindable var store: StoreOf<AppFeature>
    
    var body: some View {
        Group {
            IfLetStore(
                store.scope(state: \.destination?.login, action: \.destination.login),
                then: LoginView.init
            )
            IfLetStore(
                store.scope(state: \.destination?.signup, action: \.destination.signup),
                then: SignupView.init
            )
        }
        .onAppear {
            store.send(.didLaunchApp)
        }
    }
}
