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
    
    
    var messageInputContainerView: UIView {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
    var inputTextField: UITextField  {
        let textField = UITextField()
        textField.placeholder = "Enter text.."
        
        return textField
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comments = DataModel.getComments()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
       
        
       // messageInputContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       // messageInputContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        ///messageInputContainerView.heightAnchor.constraint(equalToConstant: 148).isActive = true
      //  messageInputContainerView.widthAnchor.constraint(equalToConstant: 148).isActive = true
//view.addSubview(messageInputContainerView)

//        let titleConstraints: [NSLayoutConstraint] = [
//            NSLayoutConstraint(item: messageInputContainerView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0),
//            NSLayoutConstraint(item: messageInputContainerView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0),
//            NSLayoutConstraint(item: messageInputContainerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 48),
//            NSLayoutConstraint(item: messageInputContainerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 48)
  //      ]
//
//        view.addConstraints(titleConstraints)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Chat")
    }
}
