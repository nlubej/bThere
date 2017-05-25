//
//  ViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 11/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit
import XMSegmentedControl

@IBDesignable
class ViewController: UIViewController, XMSegmentedControlDelegate, UITextViewDelegate {
   // @IBOutlet weak var segmentedControl3: XMSegmentedControl!
    
    var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
    
    private var shadowImageView: UIImageView?
    
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var membersContainer: UIView!
    @IBOutlet weak var chatContainer: UIView!
    @IBOutlet weak var infoContainer: UIView!
//    @IBOutlet weak var textView: UITextView!
    
    /// Tells the delegate that a specific segment is now selected.
    func xmSegmentedControl(_ xmSegmentedControl: XMSegmentedControl, selectedSegment: Int) {
        //updateView(selectedSegment)
        switch selectedSegment {
        case 0:
            membersContainer.alpha = 1
            chatView.alpha = 0
            //chatContainer.alpha = 0
            infoContainer.alpha = 0
        case 1:
            membersContainer.alpha = 0
            chatView.alpha = 1
           // chatContainer.alpha = 1
            infoContainer.alpha = 0
        case 2:
            membersContainer.alpha = 0
            chatView.alpha = 0
          //  chatContainer.alpha = 0
            infoContainer.alpha = 1

        default:
            membersContainer.alpha = 1
            chatView.alpha = 0
            chatContainer.alpha = 0
            infoContainer.alpha = 0
        }
    }
    
    var bottomConstraint: NSLayoutConstraint?
    
//    var messageInputContainerView: UIView = {
//         let view = UIView()
//        view.backgroundColor = UIColor.red
//        return view;
//        
//    }()
//    
//    var inputTextField : UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Write a message..."
//        return textField
//        
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let icons2:[UIImage] = [UIImage(named: "MembersIcon-App-60x60")!, UIImage(named: "MessagesIcon-App-60x60")!, UIImage(named: "InfoIcon-App-60x60")!]
        let segmentedControl5 = XMSegmentedControl(frame: CGRect(x: 0, y: 55, width: self.view.frame.width, height: 50), segmentIcon: icons2, selectedItemHighlightStyle: XMSelectedItemHighlightStyle.bottomEdge)
        segmentedControl5.backgroundColor = UIColor(int: 16250871)
        segmentedControl5.highlightColor = (self.navigationController?.navigationBar.tintColor) ?? UIColor.lightGray
        segmentedControl5.tint = UIColor.lightGray
        segmentedControl5.highlightTint = UIColor.black
        segmentedControl5.delegate = self
        segmentedControl5.edgeHighlightHeight = 1.5
        self.view.addSubview(segmentedControl5)
    
        //self.view.addSubview(messageInputContainerView)
        //self.view.addContraintsWithFormat("H:|[v0]|", views: messageInputContainerView)
        //self.view.addContraintsWithFormat("V:[v0(798)]|", views: messageInputContainerView)
        
        
//        bottomConstraint = NSLayoutConstraint(item: , attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 100)
//        view.addConstraint(bottomConstraint!)
        
       // setupInputController()
//        self.view.addConstraint(NSLayoutConstraint(item: messageInputContainerView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: messageInputContainerView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0))
//        self.view.addConstraint(NSLayoutConstraint(item: messageInputContainerView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
        
        
        
        

//        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.someAction))
//        navigationItem.rightBarButtonItem = button
        self.navigationController?.navigationBar.backgroundColor = UIColor(int: 16250871)
                NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//
//        NSNotification.addObserver(self, selector: #selector(handleKeyboardNotification) name: UIKeyboard)
    }
    
   
    
    func handleKeyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo{
            let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue
            
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            bottomConstraint?.constant = isKeyboardShowing ? -(keyboardFrame?.height)! : 0
            //bottomConstraint?.constant = -(keyboardFrame?.height)!

            
//            UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
//                
//                self.view.layoutIfNeeded()
//                
//            }, completion: { (completed) in
//                
//            })
        }
        
    
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0{
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }


//    @IBAction func addCommentBarButtonClicked(_ sender: UIBarButtonItem) {
//        
//        self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: segue.destination)
//        
//        segue.destination.modalPresentationStyle = .custom
//        segue.destination.transitioningDelegate = self.halfModalTransitioningDelegate
//    }
//    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        self.halfModalTransitioningDelegate = HalfModalTransitioningDelegate(viewController: self, presentingViewController: segue.destination)
        
        segue.destination.modalPresentationStyle = .custom
        segue.destination.transitioningDelegate = self.halfModalTransitioningDelegate
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Write a message...")
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
            textView.text = "Write a message..."
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if shadowImageView == nil {
            shadowImageView = findShadowImage(under: navigationController!.navigationBar)
        }
        shadowImageView?.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        shadowImageView?.isHidden = false
    }
    
    private func findShadowImage(under view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1 {
            return (view as! UIImageView)
        }
        
        for subview in view.subviews {
            if let imageView = findShadowImage(under: subview) {
                return imageView
            }
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
       // if xmSegmentedControl == segmentedControl {
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



