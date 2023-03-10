//
//  base template generated by OpenBytes on 12/21/22.
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
//  RegisterFields.swift
//

import SwiftUI

struct RegisterFields: View {
    @Binding var username: String
    @Binding var email: String
    @Binding var password: String
    @Binding var passwordConfirmation: String

    @FocusState var focused: Bool

    var body: some View {
        TextField(text: $username) { Text("Username") }
            .focused($focused)
        TextField(text: $email) { Text("Email") }
            .focused($focused)
        SecureField(text: $password) { Text("Password") }
            .focused($focused)
        SecureField(text: $passwordConfirmation) { Text("Confirm Password") }
            .focused($focused)
    }
}

struct RegisterFields_Previews: PreviewProvider {
    static var previews: some View {
        RegisterFields(
            username: .constant(""),
            email: .constant(""),
            password: .constant(""),
            passwordConfirmation: .constant("")
        )
    }
}
