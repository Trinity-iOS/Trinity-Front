//
//  DescriptionView.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/10/25.
//

import SwiftUI
import ComposableArchitecture

struct DescriptionView: View {
    @Bindable var store: StoreOf<DescriptionFeature>

    var body: some View {
        VStack(spacing: 20) {
            Button("디스크립션이지롱") {
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
