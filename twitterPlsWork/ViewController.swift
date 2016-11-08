//
//  ViewController.swift
//  twitterPlsWork
//
//  Created by student3 on 10/27/16.
//  Copyright © 2016 John Hersey High School. All rights reserved.
//

import UIKit
import TwitterKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                                              message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
            
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
        
        // Add a button to the center of the view to show the timeline
        let button = UIButton(type: .system)
        button.setTitle("Show Timeline", for: .normal)
        button.sizeToFit()
        button.center = view.center
        button.addTarget(self, action: #selector(showTimeline), for: [.touchUpInside])
        view.addSubview(button)
        
        
    }
    
    func showTimeline() {
        // Create an API client and data source to fetch Tweets for the timeline
        let client = TWTRAPIClient()
        //TODO: Replace with your collection id or a different data source
        let dataSource = TWTRCollectionTimelineDataSource(collectionID: "539487832448843776", apiClient: client)
        // Create the timeline view controller
        let timelineViewControlller = TWTRTimelineViewController(dataSource: dataSource)
        // Create done button to dismiss the view controller
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissTimeline))
        timelineViewControlller.navigationItem.leftBarButtonItem = button
        
        // Create a navigation controller to hold the
        let navigationController = UINavigationController(rootViewController: timelineViewControlller)
        showDetailViewController(navigationController, sender: self)
    }
    func dismissTimeline() {
        dismiss(animated: true, completion: nil)
    }
    
}

