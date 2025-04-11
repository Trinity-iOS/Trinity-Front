//
//  LoginFeature.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 3/31/25.
//

import ComposableArchitecture
import SwiftUI
import AuthenticationServices

@Reducer
struct LoginFeature {
    @ObservableState
    struct State: Equatable {
        var user: AppleCredential?
        var isLoginLoading: Bool = false
        var loginError: String?
    }
    
    enum Action: Equatable {
        case appleLoginSucceeded(AppleCredential)
        case appleLoginFailed(String)
        case appleLoginCancelled
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case loginSucceeded
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .appleLoginSucceeded(credential):
                state.user = credential
                state.isLoginLoading = false
                
                // 로그인 성공 시 부모에게 알려줌
                return .send(.delegate(.loginSucceeded))
                
            case let .appleLoginFailed(errorMessage):
                state.loginError = errorMessage
                state.isLoginLoading = false
                return .none
                
            case .appleLoginCancelled:
                state.isLoginLoading = false
                return .none
                
            case .delegate:
                return .none  // 부모에서 처리됨
            }
        }
    }
}
