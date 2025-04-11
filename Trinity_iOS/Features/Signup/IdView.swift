//
//  IdView.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/10/25.
//

import SwiftUI
import ComposableArchitecture

struct IdView: View {
    @Bindable var store: StoreOf<IdFeature>

    var body: some View {
        VStack(spacing: 20) {
            Button("아이디에용") {
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
