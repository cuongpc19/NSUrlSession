//
//  UrlSession.swift
//  demoNSUrlsession
//
//  Created by AgribankCard on 3/18/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import Foundation
import UIKit
typealias CompletionHandler = () -> Void
class MySessionDelegate:NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate, URLSessionDownloadDelegate, URLSessionStreamDelegate {
    var completionHandlers: [String: CompletionHandler] = [:]
    var match = Match()
    func createSession() {
        // Creating session configurations
        let defaultConfiguration = URLSessionConfiguration.default
        //Fetching data
        let sessionWithoutADelegate = URLSession(configuration: defaultConfiguration)
                if let url = URL(string: "http://api.football-data.org/v1/teams/66/fixtures") {
            let backgroundDownloadTask = sessionWithoutADelegate.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data,let response = response {
                    print(response)
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        if let dictionary = json as? [String: Any] {
                            for (key, value) in dictionary {
                                if key == "fixtures" {
                                    if let fixture = value as? [Any] {
                                        if let firstObject = fixture.first as? [String: Any]{
                                            
                                            for (key1, value1) in firstObject {
                                                print("key1: \(key1) ")
                                                switch key1 {
                                                    case "date":
                                                        if let matchDate = value1 as? String {
                                                            self.match?.date = matchDate
                                                        }
                                                    case "homeTeamName":
                                                        if let matchHomeTeam = value1 as? String {
                                                            self.match?.homeTeam = matchHomeTeam
                                                        }
                                                    case "awayTeamName":
                                                        if let matchAwayTeam = value1 as? String {
                                                            self.match?.awayTeam = matchAwayTeam
                                                        }
                                                    case "result":
                                                        if let result = value1 as? [String: String] {
                                                            self.match?.goalsHomeTeam = result["goalsHomeTeam"]
                                                            self.match?.goalsAwayTeam = result["goalsAwayTeam"]
                                                        }
                                                    default:
                                                     print("default: \(key1)")
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
            //resume
            backgroundDownloadTask.resume()
        }

    } //end function
    
     func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        if let completionHandler = appDelegate.backgroundSessionCompletionHandler {
            appDelegate.backgroundSessionCompletionHandler = nil
            completionHandler()
        }
    }


    
    

}


