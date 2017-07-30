//
//  MatchesTableViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 06/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit
import RealmSwift

class MatchesTableViewController: UITableViewController {
    
    private let CellIdentifier = "MatchCell"
    private var matches :  Results<Match>!
    private var matchSections : [MatchSection]!
    private var selectedMatch : Match?
    private var reloadViewOnAppear = false
    private var dataModel : DataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Matches"
        
        dataModel = DataModel(true)
        loadData()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.view.addGestureRecognizer(longPressRecognizer)

    }
    
    private func loadData() {
        matches =  dataModel.getMatches().sorted(by: ["sportId"])
        
        matchSections = Array(Set(matches!.map{ (match : Match) -> MatchSection in
            return MatchSection(sportId: match.sportId, name: SportConst.getDescription(sportId: match.sportId))
        }))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if reloadViewOnAppear {
            tableView.reloadData()
            reloadViewOnAppear = false
        }
    }
    
    public func reloadData() {
        loadData()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return matchSections!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sportId = matchSections[section].sportId!
        return (matches?.filter("sportId == \(String(describing: sportId))").count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        
        let sportId = matchSections?[indexPath.section].sportId
        
       
            let match = matches?.filter("sportId = \(sportId ?? 0)")[indexPath.row]
        
            if let cellMatch = cell as? MatchTableViewCell {
                cellMatch.match = match
            }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return matchSections?[section].name
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sportId = matchSections![indexPath.section].sportId!
        selectedMatch = matches?.filter("sportId = \(String(describing: sportId))")[indexPath.row]
        
        performSegue(withIdentifier: "MatchDetailSeque22", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state != UIGestureRecognizerState.began {
            return
        }
        let p = longPressGestureRecognizer.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: p)
        
        if indexPath != nil {
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            let sportId = matchSections![indexPath!.section].sportId!
            let sectionMatches = matches.filter("sportId == \(sportId)")
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                self.dataModel.deleteMatch(match: sectionMatches[indexPath!.row])
                
                if sectionMatches.count == 0 {
                    self.matchSections.remove(at: indexPath!.section)
                    
                }
                
                self.tableView.reloadData()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MatchDetailSeque22" {
            if let toViewController = segue.destination.contentViewControler as? ParentViewController {
                toViewController.match = selectedMatch
                reloadViewOnAppear = true
            }
        }
    }
}
