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
    var songAsText = "TestSong\n\n\nNathan\n\n\n2015-04-11\n\n\n42\n\nNone\n\nNone\n\nEmpty\n\n1.0,2.0,3.0,4.0"
    
    // Called when a document is opened.
    override func loadFromContents(contents: AnyObject, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        
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
        
        return true
    }
    
    // Called when the system needs a snapshot of the current state of
    // the document, for autosaving.
    override func contentsForType(typeName: String, error outError: NSErrorPointer) -> AnyObject? {
        return self.songAsText.dataUsingEncoding(NSUTF8StringEncoding)
    }
    
}
