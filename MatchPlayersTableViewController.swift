//
//  MatchPlayersTableViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 13/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RealmSwift
import MGSwipeTableCell

class MatchPlayersTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MGSwipeTableCellDelegate, IndicatorInfoProvider{

    let CellIdentifier = "MatchPlayerCell"
    //var players : Results<MatchUser>!
    var match : Match!
    var changingPicturePlayerIndexRow : Int?
    var dataModel : DataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.view.addGestureRecognizer(longPressRecognizer)
        
        dataModel = DataModel()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return match.players.count
    }
    
    private func hexToInt(hex : String) -> Int {
        return Int(UInt64(hex, radix:16)!)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        
        let player = match.players[indexPath.row]
        
        
        if let playerCell = cell as? PlayerTableViewCell {
            playerCell.picture.isUserInteractionEnabled = true
            playerCell.picture.tag = indexPath.row;
            playerCell.player = player
            
            playerCell.delegate = self
            playerCell.tag = indexPath.row
            if(indexPath.row == 0 && match.players.filter("matchUserId = 1").first?.responseStatusId == MatchEventStatus.None)
            {
                playerCell.showSwipe(.leftToRight, animated: false)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, canSwipe direction: MGSwipeDirection) -> Bool {
        if direction == .rightToLeft {
            return false
        }
        
        return true
    }
    
    func swipeTableCell(_ cell: MGSwipeTableCell, swipeButtonsFor direction: MGSwipeDirection, swipeSettings: MGSwipeSettings, expansionSettings: MGSwipeExpansionSettings) -> [UIView]? {
        
        if direction == MGSwipeDirection.rightToLeft {
            return nil
        }
        
        swipeSettings.transition = MGSwipeTransition.static;
        expansionSettings.buttonIndex = 0;
        swipeSettings.threshold = 0.1
        
        let userId = self.match.players[cell.tag].user.userId
        
        let btn = MGSwipeButton(title: "", icon: resizeImage(image: UIImage(named: MatchEventStatus.statusToIcon(MatchEventStatus.Going))!, targetSize: CGSize(width: 30, height: 30)), backgroundColor: UIColor.white, padding : 15)
        {
            (sender: MGSwipeTableCell!) -> Bool in
            
            self.dataModel.changeResponseStatus(self.match, userId, MatchEventStatus.Going)
            self.tableView.reloadData()
            
            return true
        }
        
        btn.iconTintColor(UIColor(int: hexToInt(hex: MatchEventStatus.statusToColor(statusId: MatchEventStatus.Going))))
        
        
        let btn2 = MGSwipeButton(title: "", icon: resizeImage(image: UIImage(named: MatchEventStatus.statusToIcon(MatchEventStatus.NotGoing))!, targetSize: CGSize(width: 30, height: 30)), backgroundColor: UIColor.white, padding : 15)
        {
            (sender: MGSwipeTableCell!) -> Bool in
            
            self.dataModel.changeResponseStatus(self.match, userId, MatchEventStatus.NotGoing)
            self.tableView.reloadData()
            
            return true
        }
        btn2.iconTintColor(UIColor(int: hexToInt(hex: MatchEventStatus.statusToColor(statusId: MatchEventStatus.NotGoing))))
        
        let btn3 = MGSwipeButton(title: "", icon: resizeImage(image: UIImage(named: MatchEventStatus.statusToIcon(MatchEventStatus.Maybe))!, targetSize: CGSize(width: 30, height: 30)), backgroundColor: UIColor.white, padding : 15)
        {
            (sender: MGSwipeTableCell!) -> Bool in
            
            self.dataModel.changeResponseStatus(self.match, userId, MatchEventStatus.Maybe)
            self.tableView.reloadData()
            
            return true
        }
        btn3.iconTintColor(UIColor(int: hexToInt(hex: MatchEventStatus.statusToColor(statusId: MatchEventStatus.Maybe))))
        
        return [
            btn, btn2, btn3
        ]
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state != UIGestureRecognizerState.began {
            return
        }
        let p = longPressGestureRecognizer.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: p)
        
        if indexPath != nil {
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Send reminder", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Edit rights", style: .default, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Remove from match", style: .destructive, handler: { action in
                //self.players.remove(at: indexPath!.row)
                self.tableView.reloadData()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Members")
    }
}
