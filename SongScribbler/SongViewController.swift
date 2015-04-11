//
//  SongViewController.swift
//  SongScribbler
//
//  Created by Charlie Steenhagen on 4/10/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import UIKit

class SongViewController: UIViewController {
    
    var song: SongDocument? {
        didSet {
            self.configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        self.navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    
    // MARK: - Sample Code for Document App
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func done(sender: AnyObject) {
        if let document: SongDocument = self.song {
            document.saveToURL(document.fileURL, forSaveOperation: UIDocumentSaveOperation.ForOverwriting) {
                (success) in
                self.navigationController?.popViewControllerAnimated(true)
                return
            }
        }
    }
    
    func configureView() {
        if let document: SongDocument = self.song {
            self.textView?.text = document.songAsText
        }
    }
    
    func textViewDidChange(textView: UITextView!) {
        if let document: SongDocument = self.song {
            document.songAsText = self.textView.text
            document.updateChangeCount(UIDocumentChangeKind.Done)
        }
    }

}
