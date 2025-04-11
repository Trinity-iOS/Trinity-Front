//
//  PhoneNumberFeature.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/8/25.
//

import ComposableArchitecture
import FirebaseAuth
import FirebaseCore

@Reducer
struct PhoneNumberFeature {
    @ObservableState
    struct State: Equatable {
        var selectedCountry: Country = Country.default
        var phoneNumber: String = ""
        var verificationID: String? = nil
        var isContinueButtonValid: Bool {
            !phoneNumber.isEmpty && phoneNumber.count >= selectedCountry.minimumLength
        }
        var isPickerPresented: Bool = false
        var shouldPresentPhoneAuth: String? = nil
        var isSendLoading: Bool = false
    }
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case countryPickerTapped
        case countrySelected(Country)
        case dismissPicker
        case sendVerificationCode
        case verificationIDReceived(String)
        case errorReceived(String)
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case didTapNext(phoneNumber: String, verificationID: String)
        }
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .countryPickerTapped:
                state.isPickerPresented = true
                return .none
                
            case .dismissPicker:
                state.isPickerPresented = false
                return .none
                
            case let .countrySelected(country):
                state.selectedCountry = country
                state.isPickerPresented = false
                return .none
                
            case .sendVerificationCode:
                state.isSendLoading = true
                state.shouldPresentPhoneAuth = PhoneNumberFormatter.formatted(
                    for: state.selectedCountry,
                    rawNumber: state.phoneNumber
                )
                return .none
                
            case let .verificationIDReceived(id):
                state.verificationID = id
                return .send(.delegate(.didTapNext(
                    phoneNumber: state.phoneNumber,
                    verificationID: id
                )))
                
            case let .errorReceived(message):
                state.isSendLoading = false
                print(message)
                return .none
                
            case .delegate:
                return .none
            }
        }
    }
}
