//
//  TableViewController.swift
//  SongScribbler
//
//  Created by Charlie Steenhagen on 4/10/15.
//  Copyright (c) 2015 Krash Leviathan. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    @IBOutlet weak var tableViewTitle: UINavigationItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var documentURLs: [NSURL] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        if let font = UIFont(name: "AppleSDGothicNeo-Thin.ttf", size: 17) {
//            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font]
//            cancelButton.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return documentURLs.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        let URL = documentURLs[indexPath.row]
        let fileNameElements = decomposeFileName(fileName: URL.lastPathComponent)
        cell.textLabel.text = fileNameElements.title
        cell.detailTextLabel?.text = fileNameElements.composer
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let URL = documentURLs[indexPath.row]
        let documentToOpen = SongDocument(fileURL: URL)
        documentToOpen.openWithCompletionHandler() {
            (success) in
            if success == true {
                self.performSegueWithIdentifier("segueOpenToSongView", sender: documentToOpen)
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueOpenToSongView" {
            let nextViewController = segue.destinationViewController as SongViewController
            let document = sender as? SongDocument
            nextViewController.songDocument = document
            NSLog("prepareForSegue from TableViewController")
        }
    }

    
    // MARK: - Custom Methods
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func URLForDocuments() -> NSURL {
        return NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as NSURL
    }
    
    func updateFileList() {
        documentURLs = NSFileManager.defaultManager().contentsOfDirectoryAtURL(self.URLForDocuments(), includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions(), error: nil) as [NSURL]
        //TODO: - Will this (below) be needed in the final deployment? Right now, it removed .DS_Store, which is a file in every Finder folder
//        if (!documentURLs.isEmpty) {
//            documentURLs.removeAtIndex(0)
//        }
        
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.updateFileList()
    }
    
    func decomposeFileName(fileName _fileName: String) -> (composer: String, title: String) {
        // Drop the file extension
        let newString = _fileName.componentsSeparatedByString(".")[0]
        
        // Separate composer and title
        let smallArray = newString.componentsSeparatedByString(" - ")
        
        return (smallArray[0], smallArray[1])
    }

}
