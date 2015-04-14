//
//  Song.swift
//  SongScribbler
//
//  Created by Charlie Steenhagen on 4/11/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import UIKit

<<<<<<< HEAD
class Song: NSObject, NSCoding {
    var title: String = ""
    var composer: String = ""
    var dateOfCreation = NSDate()
    var measures: [Measure] = []
    
    var dateString: String {
        get {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.stringFromDate(dateOfCreation)
        }
    }
    
    
    // MARK: - Initializers
    
    override init() {
        // Add an empty measure to the measures array
        var emptyMeasure = Measure(lines: [], length: 42)
        measures = [emptyMeasure]
    }
    
    convenience init(title _title: String, composer _composer: String) {
        self.init()
        title = _title
        composer = _composer
    }
    
    convenience init(title _title: String, composer _composer: String, dateOfCreation _dateOfCreation: NSDate, measures _measures: [Measure]) {
        self.init(title: _title, composer: _composer)
        measures = _measures
        dateOfCreation = _dateOfCreation
    }
    
    
    // MARK: - Encoding and Decoding
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.title = decoder.decodeObjectForKey("title") as String
        self.composer = decoder.decodeObjectForKey("composer") as String
        self.dateOfCreation = decoder.decodeObjectForKey("dateOfCreation") as NSDate
        self.measures = decoder.decodeObjectForKey("measures") as [Measure]!
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.composer, forKey: "composer")
        aCoder.encodeObject(self.dateOfCreation, forKey: "dateOfCreation")
        aCoder.encodeObject(self.measures, forKey: "measures")
    }
    
    
    
    
    
//    func convertSongToString() -> String {
//        var theText = ""
//        theText += self.title + "\n\n\n"
//        theText += self.composer + "\n\n\n"
//        theText += self.dateCreated   // Other return characters will be added at start of measure loop
//        
//        for measure in measures {
//            // Separate the measures
//            theText += "\n\n\n"
//            
//            // Process measure
//            theText += measure.length.description + "\n\n"
//            
//            switch measure.barType {
//            case BarType.Standard:
//                theText += "Standard"
//            case BarType.Double:
//                theText += "Double"
//            case BarType.End:
//                theText += "End"
//            case BarType.BeginRepeat:
//                theText += "BeginRepeat"
//            case BarType.EndRepeat:
//                theText += "EndRepeat"
//            case BarType.BeginAndEndRepeat:
//                theText += "BeginAndEndRepeat"
//            default:
//                theText += "None"
//            }
//            theText += "\n\n"
//            
//            switch measure.clef {
//            case Clef.Treble:
//                theText += "Treble"
//            case Clef.Bass:
//                theText += "Bass"
//            default:
//                theText += "None"
//            }
//            theText += "\n"   // Other return character at start of next loop
//            
//            for lyric in measure.lyrics {
//                theText += "\n" + lyric
//            }
//            if (measure.lyrics.isEmpty) {
//                theText += "\n" + "NOLYRICS"
//            }
//            theText += "\n"  // Other return character at start of next loop
//            
//            for line in measure.lines {
//                theText += "\n"
//                theText += line.start.x.description + ","
//                theText += line.start.y.description + ","
//                theText += line.end.x.description + ","
//                theText += line.end.y.description
//            }
//            if (measure.lines.isEmpty) {
//                theText += "\n" + "NOLINES"
//            }
//        }
//        
//        return theText
//    }
//    
//    class func createFromString(text: String) -> Song {
//        // Start by grabbing song properties
//        let songList = text.componentsSeparatedByString("\n\n\n")
//        let songTitle = songList[0]
//        let songComposer = songList[1]
//        let songDate = songList[2]
//        
//        // Next do properties for each measure, followed by lyric and line properties
//        var measureStrings: [String] = []
//        for i in 3...songList.count-1 {
//            measureStrings.append(songList[i])
//        }
//        
//        var measures: [Measure] = []
//        for measureString in measureStrings {
//            let measureList = measureString.componentsSeparatedByString("\n\n")
//            let length = measureList[0].toInt()
//            
//            let barTypeString = measureList[1]
//            var barType = BarType.None
//            switch barTypeString {
//            case "Standard":
//                barType = BarType.Standard
//            case "Double":
//                barType = BarType.Double
//            case "End":
//                barType = BarType.End
//            case "BeginRepeat":
//                barType = BarType.BeginRepeat
//            case "EndRepeat":
//                barType = BarType.EndRepeat
//            case "BeginAndEndRepeat":
//                barType = BarType.BeginAndEndRepeat
//            default:
//                barType = BarType.None
//            }
//            
//            let clefString = measureList[2]
//            var clef = Clef.None
//            switch clefString {
//            case "Treble":
//                clef = Clef.Treble
//            case "Bass":
//                clef = Clef.Bass
//            default:
//                clef = Clef.None
//            }
//            
//            var lyrics = measureList[3].componentsSeparatedByString("\n")
//            if (lyrics.count == 1 && lyrics[0] == "NOLYRICS") {
//                // Set lyrics array to empty if NOLYRICS indicator is present
//                lyrics = []
//            }
//            
//            var lines: [Line] = []
//            var lineStrings = measureList[4].componentsSeparatedByString("\n")
//            if (lineStrings.count == 1 && lineStrings[0] == "NOLINES") {
//                // Do nothing if NOLINES indicator is present. lines array remains empty.
//            } else {
//                for lineString in lineStrings {
//                    let lineComponents = lineString.componentsSeparatedByString(",")
//                    var lineComponentCGFloats: [CGFloat] = []
//                    for component in lineComponents {
//                        if let n = NSNumberFormatter().numberFromString(component) {
//                            lineComponentCGFloats.append(CGFloat(n))
//                        }
//                    }
//                let start = CGPoint(x: lineComponentCGFloats[0], y: lineComponentCGFloats[1])
//                let end = CGPoint(x: lineComponentCGFloats[2], y: lineComponentCGFloats[3])
//                lines.append(Line(start: start, end: end))
//                }
//            }
//            
//            measures.append(Measure(lines: lines, length: length!, barType: barType, clef: clef, lyrics: lyrics))
//        }
//        
//        return Song(title: songTitle, composer: songComposer, dateCreated: songDate, measures: measures)
//    }
=======
class Song {
    var title: String
    var composer: String
    var dateCreated: String
    var measures: [Measure]
    
    init(title _title: String, composer _composer: String) {
        title = _title
        composer = _composer
        var emptyMeasure = Measure(lines: [], length: 42)
        measures = [emptyMeasure]
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateCreated = dateFormatter.stringFromDate(NSDate())
    }
    
    init(title _title: String, composer _composer: String, dateCreated _dateCreated: NSDate, measures _measures: [Measure]) {
        title = _title
        composer = _composer
        measures = _measures
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateCreated = dateFormatter.stringFromDate(_dateCreated)
    }
    
    init(title _title: String, composer _composer: String, dateCreated _dateCreated: String, measures _measures: [Measure]) {
        title = _title
        composer = _composer
        measures = _measures
        dateCreated = _dateCreated
    }
    
    func convertSongToString() -> String {
        var theText = ""
        theText += self.title + "\n\n\n"
        theText += self.composer + "\n\n\n"
        theText += self.dateCreated   // Other return characters will be added at start of measure loop
        
        for measure in measures {
            // Separate the measures
            theText += "\n\n\n"
            
            // Process measure
            theText += measure.length.description + "\n\n"
            
            switch measure.barType {
            case BarType.Standard:
                theText += "Standard"
            case BarType.Double:
                theText += "Double"
            case BarType.End:
                theText += "End"
            case BarType.BeginRepeat:
                theText += "BeginRepeat"
            case BarType.EndRepeat:
                theText += "EndRepeat"
            case BarType.BeginAndEndRepeat:
                theText += "BeginAndEndRepeat"
            default:
                theText += "None"
            }
            theText += "\n\n"
            
            switch measure.clef {
            case Clef.Treble:
                theText += "Treble"
            case Clef.Bass:
                theText += "Bass"
            default:
                theText += "None"
            }
            theText += "\n"   // Other return character at start of next loop
            
            for lyric in measure.lyrics {
                theText += "\n" + lyric
            }
            if (measure.lyrics.isEmpty) {
                theText += "\n" + "NOLYRICS"
            }
            theText += "\n"  // Other return character at start of next loop
            
            for line in measure.lines {
                theText += "\n"
                theText += line.start.x.description + ","
                theText += line.start.y.description + ","
                theText += line.end.x.description + ","
                theText += line.end.y.description
            }
            if (measure.lines.isEmpty) {
                theText += "\n" + "NOLINES"
            }
        }
        
        return theText
    }
    
    class func createFromString(text: String) -> Song {
        // Start by grabbing song properties
        let songList = text.componentsSeparatedByString("\n\n\n")
        let songTitle = songList[0]
        let songComposer = songList[1]
        let songDate = songList[2]
        
        // Next do properties for each measure, followed by lyric and line properties
        var measureStrings: [String] = []
        for i in 3...songList.count-1 {
            measureStrings.append(songList[i])
        }
        
        var measures: [Measure] = []
        for measureString in measureStrings {
            let measureList = measureString.componentsSeparatedByString("\n\n")
            let length = measureList[0].toInt()
            
            let barTypeString = measureList[1]
            var barType = BarType.None
            switch barTypeString {
            case "Standard":
                barType = BarType.Standard
            case "Double":
                barType = BarType.Double
            case "End":
                barType = BarType.End
            case "BeginRepeat":
                barType = BarType.BeginRepeat
            case "EndRepeat":
                barType = BarType.EndRepeat
            case "BeginAndEndRepeat":
                barType = BarType.BeginAndEndRepeat
            default:
                barType = BarType.None
            }
            
            let clefString = measureList[2]
            var clef = Clef.None
            switch clefString {
            case "Treble":
                clef = Clef.Treble
            case "Bass":
                clef = Clef.Bass
            default:
                clef = Clef.None
            }
            
            var lyrics = measureList[3].componentsSeparatedByString("\n")
            if (lyrics.count == 1 && lyrics[0] == "NOLYRICS") {
                // Set lyrics array to empty if NOLYRICS indicator is present
                lyrics = []
            }
            
            var lines: [Line] = []
            var lineStrings = measureList[4].componentsSeparatedByString("\n")
            if (lineStrings.count == 1 && lineStrings[0] == "NOLINES") {
                // Do nothing if NOLINES indicator is present. lines array remains empty.
            } else {
                for lineString in lineStrings {
                    let lineComponents = lineString.componentsSeparatedByString(",")
                    var lineComponentCGFloats: [CGFloat] = []
                    for component in lineComponents {
                        if let n = NSNumberFormatter().numberFromString(component) {
                            lineComponentCGFloats.append(CGFloat(n))
                        }
                    }
                let start = CGPoint(x: lineComponentCGFloats[0], y: lineComponentCGFloats[1])
                let end = CGPoint(x: lineComponentCGFloats[2], y: lineComponentCGFloats[3])
                lines.append(Line(start: start, end: end))
                }
            }
            
            measures.append(Measure(lines: lines, length: length!, barType: barType, clef: clef, lyrics: lyrics))
        }
        
        return Song(title: songTitle, composer: songComposer, dateCreated: songDate, measures: measures)
    }
>>>>>>> 25aef27ce7e253950356e45b64ad5599ed83708e
}
