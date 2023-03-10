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
// Created by Leif.
//  AuthNetworking+Default.swift
//

import Disk
import Foundation
import Network

private enum AuthNetworkingError: LocalizedError {
    case noData
    case validation(reason: String)

    var errorDescription: String? {
        switch self {
        case .noData:                   return "\(#fileID): No Data"
        case let .validation(reason):   return "\(#fileID): Validation: \(reason)"
        }
    }
}

extension AuthNetworking {
    var tokenFileName: String { "base.token" }

    var authURL: URL {
        URL(string: "AUTH_URL")! // TODO: (base-Template) Change AUTH_URL to valid URL
    }

    var token: String? {
        get {
            do {
                return try Disk.in(filename: tokenFileName)
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }

        set {
            do {
                guard let newValue = newValue else {
                    try Disk.delete(filename: tokenFileName)
                    return
                }

                try Disk.out(newValue, filename: tokenFileName)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    mutating func register(
        name: String,
        email: String,
        password: String,
        confirmationPassword: String
    ) async throws -> RegisterResponse {
        let payload = RegisterPayload(
            name: name,
            email: email,
            password: password,
            confirmationPassword: confirmationPassword
        )

        // Check Validation
        try payload.validate()

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        let dataResponse = try await Network.post(
            url: authURL.appendingPathComponent("register"),
            body: try encoder.encode(payload)
        )

        // Check Response
        let httpResponse = dataResponse.response as? HTTPURLResponse

        guard httpResponse?.statusCode == 200 else {
            throw AuthNetworkingError.validation(
                reason: "Status code was not 200, but was: '\(httpResponse?.statusCode ?? -1)'"
            )
        }

        guard let data = dataResponse.data else {
            throw AuthNetworkingError.noData
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let registerResponse = try decoder.decode(RegisterResponse.self, from: data)

        // Save the token
        token = registerResponse.token

        return registerResponse
    }
}