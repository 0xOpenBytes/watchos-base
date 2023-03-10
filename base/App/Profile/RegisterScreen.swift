//
//  base template generated by OpenBytes on 12/18/22.
//  Copyright (c) 2023 OpenBytes
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the conditions found at the following link:
//  https://github.com/0xOpenBytes/watchos-BASE/blob/main/LICENSE
//
// Created by Rob Maltese.
//  RegisterScreen.swift
//

import SwiftUI

struct RegisterScreen: View {
    @ObservedObject var registerViewModel: RegisterViewModel

    @FocusState var isFocused: Bool

    init(
        registerViewModel: RegisterViewModel = RegisterViewModel(
            registerNetworking: ProductionRegisterService()
        )
    ) {
        self.registerViewModel = registerViewModel
        self.isFocused = false
    }

    var body: some View {
        VStack {
            Spacer()

            RegisterFields(
                username: $registerViewModel.username,
                email: $registerViewModel.email,
                password: $registerViewModel.password,
                passwordConfirmation: $registerViewModel.confirmationPassword,
                focused: _isFocused
            )
            .padding(.horizontal, 6)

            Button(
                action: {
                    registerViewModel.registerUser()
                },
                label: {
                    Text("Register")
                        .padding(.vertical)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(
                                    registerViewModel.areFieldsValidated ? Color.gray : Color.blue
                                )
                        )
                        .padding([.horizontal, .top])
                }
            )
            .disabled(registerViewModel.areFieldsValidated)

            Spacer()
        }
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen(
            registerViewModel: RegisterViewModel(
                registerNetworking: SuccessMockRegisterService()
            )
        )
    }
}
