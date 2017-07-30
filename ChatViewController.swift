//
//  ChatViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 25/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, IndicatorInfoProvider {
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var chatContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let emptyString = "Start writing a comment..."
    var dataModel : DataModel!
    var match : Match!
    
    @IBAction func sendCommentBtn(_ sender: UIButton) {
        if commentTextView.text != emptyString {
            
            dataModel.insertComment(match, comment: commentTextView.text)

            commentTextView.text = "";
            tableView.reloadData()
            
            view.endEditing(true)
            let indexPath = IndexPath(row: match.comments.count - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    let CellIdentifier = "ChatCell"
    //var comments : Results<MatchComment>?
    var changingPicturePlayerIndexRow : Int?
    var parentNavigationController : UINavigationController?
    var bottomConstraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataModel = DataModel()
        //comments = dataModel.getComments()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        commentTextView.delegate = self
        bottomConstraint = NSLayoutConstraint(item: chatContainer, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        
        commentTextView.text = emptyString
        commentTextView.textColor = .lightGray
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.tableView.addGestureRecognizer(longPressRecognizer)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state != UIGestureRecognizerState.began {
            return
        }
        let p = longPressGestureRecognizer.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: p)
        
        if indexPath != nil {
            
            //TODO remove
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
//                
//                self.comments.remove(at: indexPath!.row)
//                self.tableView.reloadData()
//                
//                
//            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //    func handleLongPress(_ gestureReconizer: UILongPressGestureRecognizer) {
    //        if gestureReconizer.state != UIGestureRecognizerState.ended {
    //            return
    //        }
    //
    //        let p = gestureReconizer.location(in: self.tableView)
    //        let indexPath = self.tableView.indexPathForRow(at: p)
    //
    //        if let index = indexPath {
    //            //var cell = tableView.cellForItem(at: index)
    //            // do stuff with your cell, for example print the indexPath
    //            print(index.row)
    //        } else {
    //            print("Could not find index path")
    //        }
    //    }
    
    func handleKeyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            bottomConstraint?.constant = isKeyboardShowing ? -(keyboardFrame?.height)! : 0
            
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: UIViewAnimationOptions.curveEaseIn,
                           animations: {
                            
                            self.view.layoutIfNeeded()
                            
            }, completion: { (completed) in
                
            })
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return match.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        let comment = match.comments[indexPath.row]
        
        
        if let chatCell = cell as? ChatTableViewCell {
            chatCell.comment = comment
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == emptyString)
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = emptyString
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Chat")
    }
}
