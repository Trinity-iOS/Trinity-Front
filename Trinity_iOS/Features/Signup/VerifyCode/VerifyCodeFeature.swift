//
//  VerifyCodeFeature.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/10/25.
//

import ComposableArchitecture
import FirebaseAuth

@Reducer
struct VerifyCodeFeature {
    // SignupField에서 요구하는 필드와 다름 + 자동 스크롤 될 필요없기 때문에 따로 생성
    @ObservableState
    struct State: Equatable {
        let phoneNumber: String
        let verificationID: String
        var pin1 = ""
        var pin2 = ""
        var pin3 = ""
        var pin4 = ""
        var pin5 = ""
        var pin6 = ""
        var submittedCode: String?
        var focusedField: CodeField? = .pin1
        var isCodeValid: Bool = false
        
        var isVerifyingLoading: Bool = false
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case nextButtonTapped
        case delegate(Delegate)
        
        case codeChanged(CodeField, String)
        case codeSumbit
        case verifyCodeButtonTapped
        
        case verificationCompleted
        case verificationFailed(String)
        enum Delegate: Equatable {
            case didTapNext
        }
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case let .codeChanged(field, value):
                let digit = value.last.map { String($0) } ?? ""
                
                switch field {
                case .pin1:
                    state.pin1 = digit
                    state.focusedField = digit.isEmpty ? .pin1 : .pin2
                case .pin2:
                    state.pin2 = digit
                    state.focusedField = digit.isEmpty ? .pin1 : .pin3
                case .pin3:
                    state.pin3 = digit
                    state.focusedField = digit.isEmpty ? .pin2 : .pin4
                case .pin4:
                    state.pin4 = digit
                    state.focusedField = digit.isEmpty ? .pin3 : .pin5
                case .pin5:
                    state.pin5 = digit
                    state.focusedField = digit.isEmpty ? .pin4 : .pin6
                case .pin6:
                    state.pin6 = digit
                    state.focusedField = digit.isEmpty ? .pin5 : nil
                }
                
                return .send(.codeSumbit)
                
            case .codeSumbit:
                let code = state.pin1 + state.pin2 + state.pin3 + state.pin4 + state.pin5 + state.pin6
                if code.count == 6 {
                    state.isCodeValid = true
                    state.submittedCode = code
                } else {
                    state.isCodeValid = false
                }
                return .none
                
            case .verifyCodeButtonTapped:
                state.isVerifyingLoading = true
                
                guard let code = state.submittedCode else { return .none }
                let verificationID = state.verificationID

                return .run { send in
                    let credential = PhoneAuthProvider.provider().credential(
                        withVerificationID: verificationID,
                        verificationCode: code
                    )

                    // signIn → async wrapper
                    let result: AuthDataResult = try await withCheckedThrowingContinuation { continuation in
                        Auth.auth().signIn(with: credential) { authResult, error in
                            if let error {
                                continuation.resume(throwing: error)
                            } else if let authResult {
                                continuation.resume(returning: authResult)
                            }
                        }
                    }

                    // getIDToken → async wrapper
                    let token: String = try await withCheckedThrowingContinuation { continuation in
                        Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                            if let error {
                                continuation.resume(throwing: error)
                            } else if let idToken {
                                continuation.resume(returning: idToken)
                            }
                        }
                    }

                    print(token)

                    await send(.verificationCompleted)
                } catch: { error, send in
                    await send(.verificationFailed(error.localizedDescription))
                }
                
            case .verificationCompleted:
                // 인증 성공 시 다음 화면으로
                state.isVerifyingLoading = false
                return .send(.nextButtonTapped)
                
            case let .verificationFailed(message):
                // 에러 메시지 띄우고, 상태 f 가능
                state.isVerifyingLoading = false
                print("인증 실패: \(message)")
                return .none
                
            case .nextButtonTapped:
                return .send(.delegate(.didTapNext))
                
            case .delegate:
                return .none
            }
        }
    }
}
