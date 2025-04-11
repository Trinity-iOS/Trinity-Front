//
//  SignupFeature.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/8/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct SignupFeature {
    @ObservableState
    struct State {
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case path(StackActionOf<Path>)
        case startSignup
        case push(to: Path.State)
    }
    
    @Reducer
    enum Path {
        case phoneNumber(PhoneNumberFeature)
        case verifyCode(VerifyCodeFeature)
        case id(IdFeature)
        case profile(ProfileFeature)
        case interest(InterestFeature)
        case portfolio(PortfolioFeature)
        case description(DescriptionFeature)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .startSignup:
                return .send(
                    .push(to: .phoneNumber(PhoneNumberFeature.State())
                    )
                )
                
            case let .push(to: destination):
                state.path.append(destination)
                return .none
            
            // Delegate
            case let .path(.element(id: _, action: .phoneNumber(.delegate(.didTapNext(phoneNumber, verificationID))))):
                return .send(
                    .push(to: .verifyCode(
                        VerifyCodeFeature.State(
                            phoneNumber: phoneNumber, verificationID: verificationID
                        )
                    ))
                )
            
            case .path(.element(id: _, action: .verifyCode(.delegate(.didTapNext)))):
                return .send(
                    .push(to: .id(IdFeature.State())
                    )
                )
            
            case .path(.element(id: _, action: .id(.delegate(.didTapNext)))):
                return .send(
                    .push(to: .profile(ProfileFeature.State())
                    )
                )
                
            case .path(.element(id: _, action: .profile(.delegate(.didTapNext)))):
                return .send(
                    .push(to: .interest(InterestFeature.State())
                    )
                )
            
            case .path(.element(id: _, action: .interest(.delegate(.didTapNext)))):
                return .send(
                    .push(to: .portfolio(PortfolioFeature.State())
                    )
                )
            
            case .path(.element(id: _, action: .portfolio(.delegate(.didTapNext)))):
                return .send(
                    .push(to: .description(DescriptionFeature.State())
                    )
                )
                
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
