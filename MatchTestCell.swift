//
//  MatchTestCell.swift
//  bThere
//
//  Created by Nejc Lubej on 28/07/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class MatchTestCell: UICollectionViewCell {
    
    @IBOutlet weak var matchName: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var matchStatus: UIImageView!
    
    var match : Match! {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI() {
        
        let formatter = DateFormatter()
        
        if match.isAllDay {
            formatter.dateFormat = "MMM d yyyy"
        }
        else {
            formatter.dateFormat = "MMM d yyyy, HH:mm"
        }
        
        // reset any existing tweet information
        matchName?.text = match.name
        matchDate?.text = formatter.string(from: match.start)
        
        let createdBy = match.createdBy.userId
        if let reponseStatusId = match.players.filter("user.userId == \(createdBy)").first?.responseStatusId {
            
            matchStatus.image = UIImage(named: MatchEventStatus.statusToIcon(reponseStatusId))
            matchStatus.image = matchStatus.image!.withRenderingMode(.alwaysTemplate)
            matchStatus.tintColor = UIColor(int: hexToInt(hex: MatchEventStatus.statusToColor(statusId: reponseStatusId)))
            
            
            if reponseStatusId == MatchEventStatus.None
            {
                matchStatus.tintColor = UIColor.white.withAlphaComponent(0.5)
            }
        }
        //matchStatus.image = UIImage.circle(diameter: matchStatus.frame.size.width, color: UIColor(int: hexToInt(hex: ChallengeStatusColor.statusToColor(statusId: match?.Status))))
    }
    
    
    private func hexToInt(hex : String) -> Int {
        return Int(UInt64(hex, radix:16)!)
    }

}
