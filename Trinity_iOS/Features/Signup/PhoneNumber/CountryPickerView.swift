//
//  CountryPickerView.swift
//  Trinity_iOS
//
//  Created by Park Seyoung on 4/10/25.
//

import ComposableArchitecture
import SwiftUI

struct CountryPickerView: View {
    @Bindable var store: StoreOf<PhoneNumberFeature>

    let countries = [
        Country(name: "South Korea", code: "+82", flag: "🇰🇷", minimumLength: 9),
        Country(name: "United States", code: "+1", flag: "🇺🇸", minimumLength: 10),
        Country(name: "Japan", code: "+81", flag: "🇯🇵", minimumLength: 10)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
            
                Button("Done") {
                    store.send(.dismissPicker)
                }
                .padding()
            }
            
            Picker("Select Country", selection: $store.selectedCountry) {
                ForEach(countries) { country in
                    Text("\(country.flag) \(country.name) \(country.code)")
                        .tag(country)
                }
            }
            .pickerStyle(.wheel)
            .clipped()
            
            Spacer()
        }
        .presentationDetents([.height(240)])
    }
}
