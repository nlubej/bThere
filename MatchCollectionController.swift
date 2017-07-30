//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by Nejc Lubej on 20/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit
import Foundation
import XLPagerTabStrip

class MatchCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let CellIdentifier = "MatchCell"
    private var matches  =  [MatchWithHeader]()
    private var matchSections : [MatchSection]!
    private var selectedMatch : Match?
    private var reloadViewOnAppear = false
    private var dataModel : DataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Matches"
        
        dataModel = DataModel(true)
        loadData()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        collectionView!.collectionViewLayout = layout
        
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    private func loadData() {
        matches.removeAll()
        let sortedMatches =  dataModel.getMatches().sorted(by: ["sportId"])
        var sportId = 0
        for match in sortedMatches {
            if sportId != match.sportId {
                matches.append(MatchWithHeader(_headerName: SportConst.getDescription(sportId: match.sportId), _match: match))
            }
            
            matches.append(MatchWithHeader(_headerName: "", _match: match))
            
            
            sportId = match.sportId
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if reloadViewOnAppear {
            collectionView?.reloadData()
            reloadViewOnAppear = false
        }
    }
    
    public func reloadData() {
        loadData()
        collectionView?.reloadData()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return matches.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let match = matches[indexPath.row]
        
        if match.isHeader {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! SportHeaderCell
            
            cell.sportDescription?.text = match.headerName
            return cell
            
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MatchTestCell
            
            cell.match = match.match
            
            return cell
        }
    }
    
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state != UIGestureRecognizerState.began {
            return
        }
        let p = longPressGestureRecognizer.location(in: self.collectionView)
        let indexPath = self.collectionView?.indexPathForItem(at: p)
        if indexPath != nil {
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            if matches[indexPath!.row].isHeader {
                return
            }
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                self.dataModel.deleteMatch(match: self.matches[indexPath!.row].match)
                
                //if self.matches.count == 0 {
               //    self.matchSections.remove(at: indexPath!.section)
                    
                //}
                
                self.reloadData()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if matches[indexPath.row].isHeader {
            return
        }
        selectedMatch = matches[indexPath.row].match
        
        performSegue(withIdentifier: "MatchDetailSeque2", sender: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if matches[indexPath.row].isHeader {
            return CGSize(width: view.frame.width, height: 40)
        }
        return CGSize(width: view.frame.width, height: 60)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MatchDetailSeque2" {
            if let toViewController = segue.destination.contentViewControler as? ParentViewController {
                toViewController.match = selectedMatch
                reloadViewOnAppear = true
            }
        }
    }
}

