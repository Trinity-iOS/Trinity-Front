//
//  VerifyCodeView.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/10/25.
//

import SwiftUI
import ComposableArchitecture
import Combine

struct VerifyCodeView: View {
    @Bindable var store: StoreOf<VerifyCodeFeature>
    @FocusState private var focusedField: CodeField?
    
    var body: some View {
        SignupBaseView<SignupField, _>(
            focusedField: nil,
            progress: 0.25,
            title: "Verification\ncode",
            subTitle: "Enter the verification code\nsent to your phone",
            buttonTitle: store.isVerifyingLoading ? "Verifying..." : "Continue",
            style: store.isCodeValid && !store.isVerifyingLoading ? .black : .ivoryDis,
            action: {
                store.send(.verifyCodeButtonTapped)
            },
            backbutton: false,
            content: {
                contentView
            }
        )
        .onChange(of: store.focusedField) { new in
            focusedField = new
        }
        .hideKeyboardOnTap()
        .navigationBarHidden(true)
        .disabled(store.isVerifyingLoading)
    }
    
    private var contentView: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                    .frame(height: geometry.size.height * 0.1)
                HStack(spacing: 24) {
                    Spacer()
                        .frame(width: 40)
                    
                    codeField(.pin1, text: $store.pin1)
                    codeField(.pin2, text: $store.pin2)
                    codeField(.pin3, text: $store.pin3)
                    codeField(.pin4, text: $store.pin4)
                    codeField(.pin5, text: $store.pin5)
                    codeField(.pin6, text: $store.pin6)
                    
                    Spacer()
                        .frame(width: 40)
                }
                Spacer()
            }
        }
    }
    
    private func codeField(_ field: CodeField, text: Binding<String>) -> some View {
        TextField("", text: text)
            .font(Fonts.mediumText)
            .foregroundStyle(Colors.mainPrimary)
            .background(
                VStack {
                    Spacer()
                    
                    Rectangle()
                        .fill(text.wrappedValue.isEmpty ? Colors.iconDisabled : Colors.mainPrimary)
                        .frame(height: 2)
                }
            )
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(text.wrappedValue)) {
                if $0.count > 1 {
                    text.wrappedValue = String($0.prefix(1))
                }
            }
            .focused($focusedField, equals: field)
            .onChange(of: text.wrappedValue) {
                store.send(.codeChanged(field, $0))
            }
    }
}
