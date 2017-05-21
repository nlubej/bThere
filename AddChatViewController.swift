//
//  AddChatViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 17/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class AddChatViewController: UIViewController, UITextViewDelegate, HalfModalPresentable {

    @IBOutlet weak var comment: UITextView!
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        if let delegate = self.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = false
        }
        
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func donebuttonTapped(_ sender: Any) {
        if let delegate = self.transitioningDelegate as? HalfModalTransitioningDelegate {
            delegate.interactiveDismiss = true
        }
        
        dismiss(animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //let myUITextView = UITextView.init()
        comment.delegate = self
        comment.text = "Start writing a comment"
        comment.textColor = .lightGray
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Start writing a comment")
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
            textView.text = "Start writing a comment"
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
