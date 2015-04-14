//
//  ViewController.swift
//  SongScribbler
//
//  Created by Charlie Steenhagen on 4/10/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var dateCreatedLabel: UILabel!
    @IBOutlet weak var measureCountLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var composerTextField: UITextField!
    var firstRun = true
    var song: Song?

    override func viewDidLoad() {
        super.viewDidLoad()
        firstRun = firstRunActions()
        configureView()
    }
    
    override func viewDidAppear(animated: Bool) {
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // If this is the first run, the Duplicate/Delete buttons are not available
    // and if it's not the first run, it will load the last song that
    // was being worked on. Uses NSUserDefaults to store whether or not
    // it was the first run, and for storing the last open song.
    func firstRunActions() -> Bool {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let isFirstRun = defaults.objectForKey("FirstRun") as Bool? {
            // Load the path of the last song that was worked on
            if let lastSongURL = defaults.URLForKey("LastSong") {
                let documentToOpen = SongDocument(fileURL: lastSongURL)
                documentToOpen.openWithCompletionHandler() {
                    (success) in
                    if success == true {
                        self.song = documentToOpen.song!
                    }
                }
            }
            return isFirstRun
        } else {
            // Runs any additional actions here if this is the first run
            defaults.setBool(true, forKey: "FirstRun")
            return true
        }
    }
    
    func configureView() {
        if let theSong = song {
            titleTextField.text = theSong.title
            composerTextField.text = theSong.composer
            measureCountLabel.text = "Measure Count: \(theSong.measures.count.description)"
            dateCreatedLabel.text = "Date Created: \(theSong.dateCreated)"
            doneButton.hidden = false
        } else {
            measureCountLabel.text = ""
            dateCreatedLabel.text = ""
            doneButton.hidden = true
        }
    }
    
    
    // MARK: - Button Actions
    
    @IBAction func tappedDuplicate(sender: AnyObject) {
        // If this is the first run, the duplicate button is disabled.
        if (firstRun) {
            let alertController = UIAlertController(title: "Whoops!", message: "There is no song to duplicate! Try creating a new song.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            self.performSegueWithIdentifier("segueDuplicateToNew", sender: song)
        }
    }
    
    @IBAction func tappedDelete(sender: AnyObject) {
        // If this is the first run, the delete button is disabled.
        if (firstRun) {
            let alertController = UIAlertController(title: "Whoops!", message: "There is no song to delete! Try creating a new song.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Warning!", message: "Are you sure you want to delete this song?", preferredStyle: .Alert)
            var respondNo = UIAlertAction(title: "No way!", style: .Cancel) {
                UIAlertAction in
                //User chose NOT to delete
            }
            var respondYes = UIAlertAction(title: "Yes", style: .Destructive) {
                UIAlertAction in
                //User chose to delete
            }
            alertController.addAction(respondYes)
            alertController.addAction(respondNo)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedDone(sender: AnyObject) {
        self.performSegueWithIdentifier("segueSettingsToSong", sender: song)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueDuplicateToNew" {
            let nextViewController = segue.destinationViewController as NewSongViewController
            nextViewController.songToDuplicate = sender as? Song
            nextViewController.duplicateSong = true
        } else if segue.identifier == "segueSettingsToSong" {
            let nextViewController = segue.destinationViewController as SongViewController
//            nextViewController.songDocument = 
        }
    }
    
    @IBAction func unwindToSettingsView(segue: UIStoryboardSegue) {
        // Coming back from the SongViewController
    }
    
    
    // MARK: - TextField Methods
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

}

