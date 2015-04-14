//
//  SampleDocument.swift
//  iOSDocuments
//
//  Created by Karasch, Nathan J on 4/10/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import UIKit

class SongDocument: UIDocument {
    var song: Song?
<<<<<<< HEAD
=======
    var songAsText = "Title\n\n\nComposer\n\n\n2015-04-11\n\n\n42\n\nNone\n\nNone\n\nEmpty\n\n1.0,2.0,3.0,4.0"
>>>>>>> 25aef27ce7e253950356e45b64ad5599ed83708e
    
    // Called when a document is opened.
    override func loadFromContents(contents: AnyObject, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        
<<<<<<< HEAD
        if let data = contents as? NSData {
            if data.length > 0 {
                song = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Song
            }
        }
        
=======
        // Load the data as a text document
        songAsText = ""
        if let data = contents as? NSData {
            
            if data.length > 0 {
                // Attempt to decode the data into text; if it's successful
                // store it in self.text
                if let theText = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    songAsText = theText
                }
            }
        }
        
        // Convert the text document to data model objects
        song = Song.createFromString(songAsText)
        
>>>>>>> 25aef27ce7e253950356e45b64ad5599ed83708e
        return true
    }
    
    // Called when the system needs a snapshot of the current state of
    // the document, for autosaving.
    override func contentsForType(typeName: String, error outError: NSErrorPointer) -> AnyObject? {
<<<<<<< HEAD
        return NSKeyedArchiver.archivedDataWithRootObject(song!)
    }
    
//    // Original method
//    override init(fileURL: NSURL) {
//        super.init(fileURL: fileURL)
//    }
//    
//    // Called when a new song is created
//    init(fileURL: NSURL, title _title: String, composer _composer: String) {
//        super.init(fileURL: fileURL)
//        song = Song(title: _title, composer: _composer)
//        songAsText = song!.convertSongToString()
//    }
//    
//    // Called when a song is duplicated
//    init(fileURL: NSURL, song _song: Song) {
//        super.init(fileURL: fileURL)
//        song = _song
//        songAsText = song!.convertSongToString()
//    }
    
}

//class SongDocument: UIDocument {
//    var song: Song?
//    var songAsText = "Title\n\n\nComposer\n\n\n2015-04-11\n\n\n42\n\nNone\n\nNone\n\nEmpty\n\n1.0,2.0,3.0,4.0"
//    
//    // Called when a document is opened.
//    override func loadFromContents(contents: AnyObject, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
//        
//        // Load the data as a text document
//        songAsText = ""
//        if let data = contents as? NSData {
//            
//            if data.length > 0 {
//                // Attempt to decode the data into text; if it's successful
//                // store it in self.text
//                if let theText = NSString(data: data, encoding: NSUTF8StringEncoding) {
//                    songAsText = theText
//                }
//            }
//        }
//        
//        // Convert the text document to data model objects
//        song = Song.createFromString(songAsText)
//        
//        return true
//    }
//    
//    // Called when the system needs a snapshot of the current state of
//    // the document, for autosaving.
//    override func contentsForType(typeName: String, error outError: NSErrorPointer) -> AnyObject? {
//        return self.songAsText.dataUsingEncoding(NSUTF8StringEncoding)
//    }
//    
//    // Original method
//    override init(fileURL: NSURL) {
//        super.init(fileURL: fileURL)
//    }
//    
//    // Called when a new song is created
//    init(fileURL: NSURL, title _title: String, composer _composer: String) {
//        super.init(fileURL: fileURL)
//        song = Song(title: _title, composer: _composer)
//        songAsText = song!.convertSongToString()
//    }
//    
//    // Called when a song is duplicated
//    init(fileURL: NSURL, song _song: Song) {
//        super.init(fileURL: fileURL)
//        song = _song
//        songAsText = song!.convertSongToString()
//    }
//    
//}
=======
        return self.songAsText.dataUsingEncoding(NSUTF8StringEncoding)
    }
    
    // Original method
    override init(fileURL: NSURL) {
        super.init(fileURL: fileURL)
    }
    
    // Called when a new song is created
    init(fileURL: NSURL, title _title: String, composer _composer: String) {
        super.init(fileURL: fileURL)
        song = Song(title: _title, composer: _composer)
        songAsText = song!.convertSongToString()
    }
    
    // Called when a song is duplicated
    init(fileURL: NSURL, song _song: Song) {
        super.init(fileURL: fileURL)
        song = _song
        songAsText = song!.convertSongToString()
    }
    
}
>>>>>>> 25aef27ce7e253950356e45b64ad5599ed83708e
