//
//  MatchTableViewCell.swift
//  bThere
//
//  Created by Nejc Lubej on 06/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    struct ChallengeStatusColor
    {
        static let Going = "76D457"
        static let NotGoing = "FA6666"
        static let DoNotKnow = "F0EE81"
        static let NotYetChecekd = "B8B8B8"
    
        static func statusToColor(statusId : Int?) -> String {
            switch statusId! {
            case 1:
                return ChallengeStatusColor.NotYetChecekd
            case 2:
                return ChallengeStatusColor.Going
            case 3:
                return ChallengeStatusColor.NotGoing
            case 4:
                return ChallengeStatusColor.DoNotKnow
            default:
                return ChallengeStatusColor.NotYetChecekd
            }
        }
       
    }
    
    @IBOutlet weak var matchName: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var matchStatus: UIImageView!
    
    var match : Match? {
        didSet{
            updateUI()
        }
    }
    
    private func updateUI() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy, HH:mm"
        // reset any existing tweet information
        matchName?.text = match?.Name
        matchDate?.text = formatter.string(from: (match?.Start)!)
        
        matchStatus.image = UIImage.circle(diameter: matchStatus.frame.size.width, color: UIColor(int: hexToInt(hex: ChallengeStatusColor.statusToColor(statusId: match?.Status))))
    }
    
    
    private func hexToInt(hex : String) -> Int {
        return Int(UInt64(hex, radix:16)!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension UIImage {
    class func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        ctx.setFillColor(color.cgColor)
        ctx.fillEllipse(in: rect)
        ctx.restoreGState()
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return img
    }
}

extension UIColor {
    convenience init(int : Int) {
        let blue = CGFloat(int & 0xFF)
        let green = CGFloat((int >> 8) & 0xFF)
        let red = CGFloat((int >> 16) & 0xFF)
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)
    }
}

