//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Austin Rude on 9/1/15.
//  Copyright © 2015 Appliest LLC. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let tweet = self.tweet {
            tweetTextLabel.text = tweet.text
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
        }
        
        tweetScreenNameLabel?.text = "\(tweet!.user)"
        
        if let profileImageURL = tweet?.user.profileImageURL {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
                if let imageData = NSData(contentsOfURL: profileImageURL) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tweetImageView?.image = UIImage(data: imageData)
                    })
                }
            })
        }
    }
    
    @IBOutlet weak var tweetImageView: UIImageView!
    
    @IBOutlet weak var tweetScreenNameLabel: UILabel!

    @IBOutlet weak var tweetTextLabel: UILabel!
}
