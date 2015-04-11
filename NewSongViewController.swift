//
//  NewSongViewController.swift
//  SongScribbler
//
//  Created by Charlie Steenhagen on 4/10/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import UIKit

class NewSongViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var composerTextField: UITextField!
    var duplicateSong = false
    var songToDuplicate: Song?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneTapped(sender: AnyObject) {
        if (nameTextField.text.isEmpty || composerTextField.text.isEmpty) {   // Is either field empty?
            // Display an alert explaining why conditions were not met
            let alertController = UIAlertController(title: "Uh oh!", message: "You need to fill in both text fields.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else if (isUniqueFileName(title: nameTextField.text, composer: composerTextField.text)) {
            // If the filename is unique, make the file
            createDocument(title: nameTextField.text, composer: composerTextField.text, sender: sender)
        } else {
            // Display an alert explaining why conditions were not met
            let alertController = UIAlertController(title: "Uh oh!", message: "That song name by that composer already exists! Choose another name or another composer for your song.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func createDocument(title _title: String, composer _composer: String, sender: AnyObject) {
        
        let fileName = "\(_composer) - \(_title).songDocument"
        let url = self.URLForDocuments().URLByAppendingPathComponent(fileName)
        
        if (duplicateSong) {
            // When this is a duplicate of a previous song
            let documentToCreate = SongDocument(fileURL: url, song: songToDuplicate!)
            documentToCreate.saveToURL(url, forSaveOperation: UIDocumentSaveOperation.ForCreating) {
                (success) in
                if success == true {
                    self.performSegueWithIdentifier("segueNewToSongView", sender: documentToCreate)
                }
            }
        } else {
            // When this is a new song
            let documentToCreate = SongDocument(fileURL: url, title: _title, composer: _composer)
            documentToCreate.saveToURL(url, forSaveOperation: UIDocumentSaveOperation.ForCreating) {
                (success) in
                if success == true {
                    self.performSegueWithIdentifier("segueNewToSongView", sender: documentToCreate)
                }
            }
        }
        
    }
    
    func URLForDocuments() -> NSURL {
        return NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as NSURL
    }
    
    func isUniqueFileName(title _title: String, composer _composer: String) -> Bool {
        let fileName = "\(_composer) - \(_title).songDocument"
        var documentURLs = getDocumentURLs()
        for url in documentURLs {
            var urlString = url.lastPathComponent
            if (urlString == fileName) {
                return false
            }
        }
        return true
    }
    
    func getDocumentURLs() -> [NSURL] {
        return NSFileManager.defaultManager().contentsOfDirectoryAtURL(self.URLForDocuments(), includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions(), error: nil) as [NSURL]
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueNewToSongView" {
            let nextViewController = segue.destinationViewController as SongViewController
            let document = sender as? SongDocument
            nextViewController.songDocument = document
            NSLog("prepareForSegue from NewSongViewController")
        }
    }

}
