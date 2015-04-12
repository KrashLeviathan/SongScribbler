//
//  SongViewController.swift
//  SongScribbler
//
//  Created by Charlie Steenhagen on 4/10/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import UIKit

class SongViewController: UIViewController {
    
    @IBOutlet weak var drawView: DrawView!
    var songDocument: SongDocument? {
        didSet {
            self.configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        if let document: SongDocument = self.songDocument {
            
        }
    }

    
    
    // MARK: - Scroll Button methods
    
    @IBAction func touchDownLeft(sender: AnyObject) {
        drawView.scroll(-15)
    }
    @IBAction func touchUpLeft(sender: AnyObject) {
        drawView.scroll(-15)
    }
    @IBAction func touchUpOutsideLeft(sender: AnyObject) {
        self.touchUpLeft(sender)
    }
    
    @IBAction func touchDownRight(sender: AnyObject) {
        drawView.scroll(15)
    }
    @IBAction func touchUpRight(sender: AnyObject) {
        drawView.scroll(15)
    }
    @IBAction func touchUpOutsideRight(sender: AnyObject) {
        self.touchUpRight(sender)
    }
    
    
    // MARK: - Measure Button
    
    @IBAction func tappedMeasure(sender: AnyObject) {
        var barLocation: Int = Int(drawView.rightMostPoint + CGFloat(40))
        if (drawView.barLocations.last != barLocation) {
            drawView.barLocations.append(barLocation)
            drawView.currentMeasureIndex++
        }
        drawView.setNeedsDisplay()
    }
    
    
    // MARK: - Settings Button
    
    @IBAction func settings(sender: AnyObject) {
        if let document: SongDocument = self.songDocument {
            document.saveToURL(document.fileURL, forSaveOperation: UIDocumentSaveOperation.ForOverwriting) {
                (success) in
                self.dismissViewControllerAnimated(true, completion: nil)
                return
            }
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    
    
    
    // MARK: - Sample Code for Document App
    
//    func textViewDidChange(textView: UITextView!) {
//        if let document: SongDocument = self.songDocument {
//            document.songAsText = self.textView.text
//            document.updateChangeCount(UIDocumentChangeKind.Done)
//        }
//    }

}
