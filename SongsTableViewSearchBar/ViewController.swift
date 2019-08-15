//
//  ViewController.swift
//  SongsTableViewSearchBar
//
//  Created by C4Q  on 11/6/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let songs = Song.loveSongs
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    var searchString: String? = nil {
        didSet {
            print(searchString)
            // / call a function on the tableView to reload it's data
            self.tableView.reloadData()
        }
    }
    
    var songSearchResults: [Song] {
        
        get {
            guard let searchString = searchString else {
                return songs
            }
            guard searchString != "" else {
                return songs
            }
            
            if let scopeTitles = searchBarOutlet.scopeButtonTitles {
                
                let currentScopeIndex = searchBarOutlet.selectedScopeButtonIndex
                
                switch scopeTitles[currentScopeIndex] {
                case "Song Title":
                    return songs.filter{ $0.name.lowercased().contains(searchString.lowercased()) }
                case "Artist":
                    return songs.filter{ $0.artist.lowercased().contains(searchString.lowercased()) }
                default:
                    return songs
                }
            }
        return songs
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBarOutlet.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    
}

// TABLE VIEW PROTOCOLS
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") {
            
            cell.textLabel?.text = songSearchResults[indexPath.row].name
            cell.detailTextLabel?.text = songSearchResults[indexPath.row].artist
            
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifier = segue.identifier else {
            fatalError("No identifier on segue")
        }
        
        switch segueIdentifier {
            
        case "SongDetail":
            
            guard let songDetail = segue.destination as? SongDetailViewController else {
                fatalError("Unexpected segue VC")
            }
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
                fatalError("No row was selected")
            }
            
            songDetail.song = songs[selectedIndexPath.row] //[selectedIndexPath.row]
        // we need the section and the row from the static array of all the filtered animals
        default:
            fatalError("Unexpected segue identifier")
        }
    }
    
    
}


// SEARCH BAR PROTOCOLS
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
    
}

