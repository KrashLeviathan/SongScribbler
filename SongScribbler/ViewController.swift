//
//  ViewController.swift
//  SongScribbler
//
//  Created by Charlie Steenhagen on 4/10/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var composerTextField: UITextField!
    var firstRun = true
    var song: Song?

    override func viewDidLoad() {
        super.viewDidLoad()
        firstRun = firstRunActions()
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // If this is the first run, the Duplicate button is not available
    // and if it's not the first run, it will load the last song that
    // was being worked on. Uses NSUserDefaults to store whether or not
    // it was the first run, and for storing the last open song.
    func firstRunActions() -> Bool {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let isFirstRun = defaults.boolForKey("FirstRun") as Bool? {
            // Load the last song that was worked on
            if let lastSong = defaults.objectForKey("LastSong") as? Song {
                song = lastSong
            }
            return false
        } else {
            // Runs any additional actions here if this is the first run
            defaults.setBool(false, forKey: "FirstRun")
            return true
        }
    }
    
    func configureView() {
        if let songTitle = song?.title {
            titleTextField.text = songTitle
        }
        if let songComposer = song?.composer {
            composerTextField.text = songComposer
        }
    }
    
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
        let alertController = UIAlertController(title: "Warning!", message: "Are you sure you want to delete this song?", preferredStyle: .Alert)
        var respondNo = UIAlertAction(title: "No way!", style: .Cancel) {
            UIAlertAction in
            NSLog("They chose no.")
        }
        var respondYes = UIAlertAction(title: "Yes", style: .Destructive) {
            UIAlertAction in
            NSLog("They chose yes.")
        }
        alertController.addAction(respondYes)
        alertController.addAction(respondNo)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueDuplicateToNew" {
            let nextViewController = segue.destinationViewController as NewSongViewController
            nextViewController.songToDuplicate = sender as? Song
            nextViewController.duplicateSong = true
        }
    }

}

