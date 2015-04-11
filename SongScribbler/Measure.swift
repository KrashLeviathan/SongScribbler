//
//  Measure.swift
//  SongScribbler
//
//  Created by Charlie Steenhagen on 4/11/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import Foundation

class Measure {
    
    var barType: BarType
    var lyrics: [String]
    var lines: [Line]
    var length: Int
    var clef: Clef
    
    init(lines _lines: [Line], length _length: Int) {
        lines = _lines
        length = _length
        barType = BarType.None
        lyrics = []
        clef = Clef.None
    }
    
    init(lines _lines: [Line], length _length: Int, barType _barType: BarType, clef _clef: Clef, lyrics _lyrics: [String]) {
        lines = _lines
        length = _length
        barType = _barType
        lyrics = _lyrics
        clef = _clef
    }
}
