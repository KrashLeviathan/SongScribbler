//
//  Measure.swift
//  SongScribbler
//
//  Created by Charlie Steenhagen on 4/11/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import Foundation

<<<<<<< HEAD
class Measure: NSObject, NSCoding {
    
    var barType: BarType = BarType.None
    var lyrics: [String] = []
    var lines: NSMutableArray = NSMutableArray()
    var length: Int = 0
    var clef: Clef = Clef.None
    
    
    // MARK: - Initializers
    
    override init() {}
    
    init(lines _lines: NSMutableArray, length _length: Int) {
=======
class Measure {
    
    var barType: BarType
    var lyrics: [String]
    var lines: [Line]
    var length: Int
    var clef: Clef
    
    init(lines _lines: [Line], length _length: Int) {
>>>>>>> 25aef27ce7e253950356e45b64ad5599ed83708e
        lines = _lines
        length = _length
        barType = BarType.None
        lyrics = []
        clef = Clef.None
    }
    
<<<<<<< HEAD
    init(lines _lines: NSMutableArray, length _length: Int, barType _barType: BarType, clef _clef: Clef, lyrics _lyrics: [String]) {
=======
    init(lines _lines: [Line], length _length: Int, barType _barType: BarType, clef _clef: Clef, lyrics _lyrics: [String]) {
>>>>>>> 25aef27ce7e253950356e45b64ad5599ed83708e
        lines = _lines
        length = _length
        barType = _barType
        lyrics = _lyrics
        clef = _clef
    }
<<<<<<< HEAD
    
    
    // MARK: - Encoding and Decoding
    
    required init(coder decoder: NSCoder) {
        self.barType = BarType(rawValue: decoder.decodeIntegerForKey("barType"))!
        self.lyrics = decoder.decodeObjectForKey("lyrics") as [String]!
        self.lines = decoder.decodeObjectForKey("lines") as NSMutableArray
        self.length = decoder.decodeIntegerForKey("length")
        self.clef = Clef(rawValue: decoder.decodeIntegerForKey("clef"))!
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(barType.rawValue, forKey: "barType")
        aCoder.encodeObject(lyrics, forKey: "lyrics")
        aCoder.encodeObject(lines, forKey: "lines")
        aCoder.encodeInteger(length, forKey: "length")
        aCoder.encodeInteger(clef.rawValue, forKey: "clef")
    }
=======
>>>>>>> 25aef27ce7e253950356e45b64ad5599ed83708e
}
