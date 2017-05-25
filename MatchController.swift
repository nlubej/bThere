//
//  MatchController.swift
//  bThere
//
//  Created by Nejc Lubej on 21/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MatchCell"
private var matches = [SportGroup]()

class MatchController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Matches"
        matches = getMatches()
        
        //self.collectionView!.register(MatchCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    public func getMatches() -> [SportGroup]{
        return [SportGroup(name: "Basketball", groupArray:
            [Match(name: "Senior Basketball match", start: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, status: MatchEventStatus.Going),
             Match(name: "Junior practice", start: Calendar.current.date(byAdding: .day, value: 6, to: Date())!, status: MatchEventStatus.Going),
             Match(name: "Dribble Practice", start: Calendar.current.date(byAdding: .day, value: 7, to: Date())!, status: MatchEventStatus.NotGoing),
             Match(name: "Game for finals", start: Calendar.current.date(byAdding: .day, value: 10, to: Date())!, status: MatchEventStatus.None),
             Match(name: "Final game!!", start: Calendar.current.date(byAdding: .day, value: 24, to: Date())!, status: MatchEventStatus.Going)]),
                
                SportGroup(name: "Football", groupArray:
                    [Match(name: "Ronaldo tricks practice", start: Calendar.current.date(byAdding: .day, value: 27, to: Date())!, status: MatchEventStatus.Going),
                     Match(name: "Match of the legends", start: Calendar.current.date(byAdding: .day, value: 44, to: Date())!, status: MatchEventStatus.Maybe)]),
                
                SportGroup(name: "Rugby", groupArray:
                    [Match(name: "Bones Crushing Game", start: Calendar.current.date(byAdding: .day, value: 27, to: Date())!, status: MatchEventStatus.Going)]),
                
                SportGroup(name: "Table tennis", groupArray:
                    [Match(name: "Epic Game", start: Calendar.current.date(byAdding: .day, value: 27, to: Date())!, status: MatchEventStatus.Maybe)])]
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return matches.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return matches[section].groups.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let match = matches[indexPath.section].groups[indexPath.row]
        
        if let cellMatch = cell as? MatchCell {
            cellMatch.match = match
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
