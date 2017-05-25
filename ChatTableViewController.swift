//
//  ChatTableViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 13/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ChatTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, IndicatorInfoProvider {
    
    
    @IBAction func addChatEntry(_ sender: UIStoryboardSegue) {
        if let data = sender.source as? AddChatViewController {
            print(data.comment.text ?? "nothing")
            
            if !(data.comment.text?.isEmpty)! {
                //                chatEntries.append(CommentEntry(name: "Nejc Lubej", start: Date(), text: data.comment.text!, profilePic: UIImage(named: "MembersIcon-App-60x60")))
                //                    self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func cancelNewChatEntry(_ sender: UIStoryboardSegue) {
        
    }
    
    let CellIdentifier = "ChatCell"
    var comments = [CommentEntry]()
    var changingPicturePlayerIndexRow : Int?
    var parentNavigationController : UINavigationController?
    
    
    var messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view;
        
    }()
    
    var inputTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Write a message..."
        return textField
        
    }()
    
    var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return button
    }()
    
    var bottomConstraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comments = DataModel.getComments()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.addSubview(messageInputContainerView)
        self.tableView.addContraintsWithFormat("H:|[v0]|", views: messageInputContainerView)
        self.tableView.addContraintsWithFormat("V:[v0(48)]|", views: messageInputContainerView)
        
        
        bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: self.tableView, attribute: .bottom, multiplier: 1, constant: 0)
        tableView.addConstraint(bottomConstraint!)
        
        //view.addSubview(sendButton)
        
        setupInputController()
        
        //self.navigationController?.navigationBar.backgroundColor = UIColor(int: 16250871)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        
    }
    
    func setupInputController() {
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addContraintsWithFormat("H:|-8-[v0]|", views: inputTextField)
        messageInputContainerView.addContraintsWithFormat("V:|[v0]|", views: inputTextField)
        
    }
    
    func handleKeyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo{
            let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue
            
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            bottomConstraint?.constant = isKeyboardShowing ? -(keyboardFrame?.height)! : 0
            bottomConstraint?.constant = -(keyboardFrame?.height)!
            
            
            //            UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            //
            //                self.view.layoutIfNeeded()
            //
            //            }, completion: { (completed) in
            //
            //            })
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        
        let comment = comments[indexPath.row]
        
        
        if let chatCell = cell as? ChatTableViewCell {
            chatCell.comment = comment
            //chatCell.profilePicture.tag = indexPath.row;
            
            //
            //            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            //            chatCell.profilePicture.addGestureRecognizer(tapGestureRecognizer)
            //
            //
            //            let tapped:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("TappedOnImage:")))
            //            tapped.numberOfTapsRequired = 1
            //            cell.imageView?.addGestureRecognizer(tapped)
            
            //            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            //            chatCell.picture.addGestureRecognizer(tapGestureRecognizer)
            //
            //
            //            let tapped:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("TappedOnImage:")))
            //            tapped.numberOfTapsRequired = 1
            //            cell.imageView?.addGestureRecognizer(tapped)
            
        }
        
        return cell
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            let image = tapGestureRecognizer.view as! UIImageView
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = true
            changingPicturePlayerIndexRow = image.tag
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = (info[UIImagePickerControllerEditedImage] as? UIImage) ?? (info[UIImagePickerControllerOriginalImage] as? UIImage)
        
        let chat = comments[changingPicturePlayerIndexRow!]
        chat.user.picture = image
        //            picture.layer.cornerRadius = picture.frame.size.width / 2;
        //            picture.clipsToBounds = true;
        //
        //            picture.contentMode = .scaleAspectFill
        //            picture.image = image
        
        tableView.reloadData()
        self.dismiss(animated: true, completion: nil);
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Chat")
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

