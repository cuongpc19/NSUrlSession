//
//  ListTableVC.swift
//  demoNSUrlsession
//
//  Created by AgribankCard on 3/18/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit
import Foundation
class ListTableVC: UITableViewController,URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate, URLSessionStreamDelegate  {
    let preferencesName = "cuongpc19@gmail.com"
    private let preferencesPassword = "2729797ede74414ab9e7d02d83fd618c"
    var matchs = [Match()]
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://api.football-data.org/v1/teams/66/fixtures")
        let defaultConfiguration = URLSessionConfiguration.default
        let mySession = URLSession(configuration: defaultConfiguration, delegate: self, delegateQueue: nil)
        var request = URLRequest(url: url!)
        request.addValue(self.preferencesPassword, forHTTPHeaderField: "X-Auth-Token")
        
        let backgroundTask = mySession.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data,let response = response {
                //print(response)
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                    if let dictionary = json as? [String: Any] {
                        for (key, value) in dictionary {
                            print("key : \(key), value : \(value)")
                            if key == "fixtures" {
                                
                                if let fixture = value as? [Any] {
                                    for object in fixture {
                                        if let firstObject = object as? [String: Any]{
                                            let match = Match()
                                            for (key1, value1) in firstObject {
                                                
                                                switch key1 {
                                                case "date":
                                                    if let matchDate = value1 as? String {
                                                        match?.date = matchDate
                                                    }
                                                case "homeTeamName":
                                                    if let matchHomeTeam = value1 as? String {
                                                        match?.homeTeam = matchHomeTeam
                                                    }
                                                case "awayTeamName":
                                                    if let matchAwayTeam = value1 as? String {
                                                        match?.awayTeam = matchAwayTeam
                                                    }
                                                case "result":
                                                    //print("value1 : \(value1)")
                                                    if let result = value1 as? [String: Any] {
                                                        for (key2,value2) in result {
                                                            if let goal = value2 as? NSNumber {
                                                                if key2 == "goalsHomeTeam"
                                                                {
                                                                    match?.goalsHomeTeam = goal.stringValue
                                                                }
                                                                else {
                                                                    match?.goalsAwayTeam = goal.stringValue
                                                                }                                                                                                                          }
                                                        }                                                                                                  }
                                                    case "date":
                                                        if let dateMatch = value1 as? String {
                                                            match?.date = dateMatch
                                                        }
                                                default: ()
                                                    
                                                }
                                            }
                                            self.matchs.append(match)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                } //end if let json
            }
        })
        backgroundTask.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matchs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else {
            fatalError("error")
        }
        
        

        // Configure the cell...
        
        cell.homeTeam.text =  matchs[indexPath.row]?.homeTeam
        cell.awayTeam.text = matchs[indexPath.row]?.awayTeam
        cell.goalHome.text = matchs[indexPath.row]?.goalsHomeTeam
        cell.goalAway.text = matchs[indexPath.row]?.goalsAwayTeam
        cell.dateMatch.text = matchs[indexPath.row]?.date
        
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
