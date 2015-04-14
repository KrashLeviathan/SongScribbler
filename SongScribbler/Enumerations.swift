//
//  Enumerations.swift
//  iOSDocuments
//
//  Created by Charlie Steenhagen on 4/11/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import Foundation

enum Clef: Int {
    case None = 0
    case Treble = 1
    case Bass = 2
}
enum BarType: Int {
    case None = 0
    case Standard = 1
    case Double = 2
    case End = 3
    case BeginRepeat = 4
    case EndRepeat = 5
    case BeginAndEndRepeat = 6
}