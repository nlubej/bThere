//
//  MatchesTableViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 06/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class MatchesTableViewController: UITableViewController {

    let CellIdentifier = "MatchCell"
    var matches = [SportGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Matches"
        matches = getMatches()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //tabBarController?.tabBar.isHidden = false
        //tabBarController?.tabBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //tabBarController?.tabBar.isHidden = true
        //tabBarController?.tabBar.h = true

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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return matches.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matches[section].groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        let match = matches[indexPath.section].groups[indexPath.row]
        
        if let cellMatch = cell as? MatchTableViewCell {
            cellMatch.match = match
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return matches[section].sportName
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MatchDetailSeque2", sender: self)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
