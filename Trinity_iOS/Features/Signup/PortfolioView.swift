//
//  PortfolioView.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/10/25.
//

import SwiftUI
import ComposableArchitecture

struct PortfolioView: View {
    @Bindable var store: StoreOf<PortfolioFeature>

    var body: some View {
        VStack(spacing: 20) {
            Button("포트폴리온데요") {
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
