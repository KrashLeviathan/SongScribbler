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
        // TODO: Update conditions to make sure filename (song name) is not already chosen
        if (false) {
            createDocument(sender)
        } else {
            // Display an alert explaining why conditions were not met
            let alertController = UIAlertController(title: "Uh oh!", message: "That song name already exists! Choose another name for your song.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func createDocument(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ssZZZ"
        
        let dateString = dateFormatter.stringFromDate(NSDate())
        
        let fileName = "Document \(dateString).songDocument"
        
        let url = self.URLForDocuments().URLByAppendingPathComponent(fileName)
        
        let documentToCreate = SongDocument(fileURL: url)
        documentToCreate.saveToURL(url, forSaveOperation: UIDocumentSaveOperation.ForCreating) {
            (success) in
            if success == true {
                self.performSegueWithIdentifier("segueToSongView", sender: documentToCreate)
            }
        }
    }
    
    func URLForDocuments() -> NSURL {
        return NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as NSURL
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
