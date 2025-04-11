//
//  PhoneNumberView.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/8/25.
//

import SwiftUI
import ComposableArchitecture

struct PhoneNumberView: View {
    @Bindable var store: StoreOf<PhoneNumberFeature>
    @FocusState private var focusedField: SignupField?
    
    var body: some View {
        SignupBaseView<SignupField, _>(
            focusedField: $focusedField,
            progress: 0.25,
            title: "Let's\nGet Started",
            subTitle: "We will send you\n4 digits verification code.",
            buttonTitle: store.isSendLoading ? "Sending...": "Continue",
            style: store.isContinueButtonValid && !store.isSendLoading ? .black : .ivoryDis,
            action: {
                store.send(.sendVerificationCode)
            },
            backbutton: false,
            content: {
                contentView
            }
        )
        // dismiss Keyboard
        .hideKeyboardOnTap()
        .navigationBarHidden(true)
        .sheet(isPresented: $store.isPickerPresented) {
            CountryPickerView(store: store)
        }
        .onChange(of: store.shouldPresentPhoneAuth) { formatted in
            guard let phoneNumber = formatted else { return }

            OverlayPresenter.presentPhoneAuth(phoneNumber: phoneNumber) { verificationID in
                store.send(.verificationIDReceived(verificationID))
            }

            store.shouldPresentPhoneAuth = nil
        }
        .disabled(store.isSendLoading)
    }
    
    private var contentView: some View {
        VStack {
            subTitle

            Spacer()
                .frame(height: 12)
            
            phoneNumberView
            
            Spacer()
        }
        .padding(.horizontal, 24)
    }
    
    private var subTitle: some View {
        HStack {
            Text("Mobile Number")
                .font(Fonts.baseViewTextFieldTitle)
            Spacer()
        }
    }
    
    private var phoneNumberView: some View {
        HStack {
            Spacer()
                .frame(width: 20)
            
            countrySelectButton
            
            Spacer()
            
            divider
            
            Spacer()
            
            countryCodeView
            
            Spacer()
            
            phoneNumberTextField
            
            Spacer()
                .frame(width: 20)
        }
        .overlay(
            Rectangle()
                .stroke(
                    (focusedField == .phone) || (store.isPickerPresented) ? Colors.borderAct : Colors.borderDefault, lineWidth: 1)
        )
        .frame(height: 52)
    }
    
    private var countrySelectButton: some View {
        Button(
            action: { store.send(.countryPickerTapped) }
        ) { HStack {
            Text("\(store.selectedCountry.flag)")
                .font(Fonts.regularText)
            
            Image("bottomArrowButton")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 8)
        }
        }
    }
    
    private var divider: some View {
        Rectangle()
            .fill(Colors.borderDefault)
            .frame(width: 1)
            .padding(.vertical, 14)
    }
    
    private var countryCodeView: some View {
        Text("\(store.selectedCountry.code)")
            .font(Fonts.regularText)
            .foregroundStyle(Colors.borderAct)
    }
    
    private var phoneNumberTextField: some View {
        TextField("Ex.01012345678", text: $store.phoneNumber)
            .foregroundStyle(Colors.borderAct)
            .keyboardType(.numberPad)
            .focused($focusedField, equals: .phone)
            .onChange(of: store.phoneNumber) { newValue in
                if newValue.count > 12 {
                    store.phoneNumber = String(newValue.prefix(12))
                }
            }
    }
}
