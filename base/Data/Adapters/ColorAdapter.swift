//
//  base template generated by OpenBytes on 1/2/23.
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
//  ColorAdapter.swift
//

import SwiftUI

enum ColorAdapter: Adaptable {
    static func device(from: NetworkColor) throws -> Color {
        Color(
            red: from.red,
            green: from.green,
            blue: from.blue,
            opacity: from.alpha
        )
    }
}
