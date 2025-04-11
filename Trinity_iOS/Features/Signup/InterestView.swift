//
//  InterestView.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/10/25.
//

import SwiftUI
import ComposableArchitecture

struct InterestView: View {
    @Bindable var store: StoreOf<InterestFeature>

    var body: some View {
        VStack(spacing: 20) {
            Button("인터레스트해요") {
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
