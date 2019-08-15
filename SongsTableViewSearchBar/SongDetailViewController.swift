//
//  SongDetailViewController.swift
//  SongsTableViewSearchBar
//
//  Created by Alexander George Legaspi on 8/15/19.
//  Copyright © 2019 C4Q . All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController {

    var song: Song!

    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        artistName.text = song.artist
        songTitle.text = song.name
        songImage.image = UIImage(named: "loveSongs")
        
    }

}
