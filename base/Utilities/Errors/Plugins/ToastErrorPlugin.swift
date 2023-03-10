//
//  base template generated by OpenBytes on 2/16/23.
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
//  ToastErrorPlugin.swift
//

import Plugin
import Scribe

struct ToastErrorPlugin: ImmutablePlugin {
    func handle(value: Error) async throws {
        baseScribe.shared.error(
            Scribe.Message(stringLiteral: value.localizedDescription)
        )

        #if DEBUG
        Navigation.path.toast(
            title: "Error",
            message: value.localizedDescription,
            style: .error
        )
        #else
        Navigation.path.toast(
            title: "Error",
            message: "Encountered an error, please try again.",
            style: .error
        )
        #endif
    }
}
