//
//  LoginView.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 3/31/25.
//

import ComposableArchitecture
import SwiftUI
import Lottie
import AuthenticationServices

struct LoginView: View {
  @Bindable var store: StoreOf<LoginFeature>
    
  var body: some View {
    GeometryReader { geometry in
      VStack {
        Spacer()
          .frame(height: geometry.size.height * 0.32)

        LottieView(jsonName: "Logo Animation Image", loopMode: .playOnce)
          .frame(width: 180, height: 127)

        Spacer()

        if store.isLoginLoading {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .frame(height: 50)
        } else {
          appleLoginButton(store: store)
        }

        Spacer()
          .frame(height: geometry.size.height * 0.12)
      }
      .background(Colors.mainPrimary)
    }
  }

  private func appleLoginButton(store: StoreOf<LoginFeature>) -> some View {
    SignInWithAppleButton(
      .signIn,
      onRequest: { request in
        request.requestedScopes = [.fullName, .email]
      },
      onCompletion: { result in
        switch result {
        case .success(let authorization):
          if let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
             let identityTokenData = credential.identityToken,
             let identityToken = String(data: identityTokenData, encoding: .utf8) {
            
            let appleCredential = AppleCredential(
              userID: credential.user,
              email: credential.email,
              fullName: credential.fullName,
              identityToken: identityToken
            )
            
            store.send(.appleLoginSucceeded(appleCredential))
          }

        case .failure(let error):
          let nsError = error as NSError
          if nsError.code == ASAuthorizationError.canceled.rawValue {
            store.send(.appleLoginCancelled)
          } else {
            store.send(.appleLoginFailed(error.localizedDescription))
          }
        }
      }
    )
    .signInWithAppleButtonStyle(.white)
    .frame(height: 56)
    .cornerRadius(10)
    .padding(.horizontal, 40)
  }
}
