//
//  MatchPlayersTableViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 13/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MatchPlayersTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, IndicatorInfoProvider{

    let CellIdentifier = "MatchPlayerCell"
    var players = [MatchPlayer]()
    var changingPicturePlayerIndexRow : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        players = DataModel.getMatchPlayers()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        
        let player = players[indexPath.row]
        
        
        if let playerCell = cell as? PlayerTableViewCell {
            playerCell.picture.isUserInteractionEnabled = true
            playerCell.picture.tag = indexPath.row;
            playerCell.player = player
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            playerCell.picture.addGestureRecognizer(tapGestureRecognizer)
            
            
            let tapped:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("TappedOnImage:")))
            tapped.numberOfTapsRequired = 1
            cell.imageView?.addGestureRecognizer(tapped)
            
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
            
              let player = players[changingPicturePlayerIndexRow!]
               player.picture = image
//            picture.layer.cornerRadius = picture.frame.size.width / 2;
//            picture.clipsToBounds = true;
//            
//            picture.contentMode = .scaleAspectFill
//            picture.image = image
            
            tableView.reloadData()
            self.dismiss(animated: true, completion: nil);
            
        }
        

    
    func TappedOnImage(sender:UITapGestureRecognizer){
        print(sender.view?.tag ?? "")
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Members")
    }
}
