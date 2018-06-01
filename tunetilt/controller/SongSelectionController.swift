//
//  ViewController.swift
//  tunetilt
//
//  Created by Jonathan Moallem on 15/5/18.
//  Copyright © 2018 Blinking Light Studios. All rights reserved.
//

import UIKit

class SongSelectionController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var song = [Song]()
    var sequenceObject = Song()
    var valueToPass = [String]()
    var idToPass = String()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Sequences.plist")
    
    let storage = SongsStorage()
    // Outlet fields
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

loadData()
        print("Song name is ()")
        // Set up the table view for callbacks
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return song.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Setup the cell as reusable
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
      
        // Get and set the labels
        let songName: UILabel = cell.viewWithTag(3) as! UILabel
        let difficulty: UILabel = cell.viewWithTag(1) as! UILabel
//        let playButton: UIButton = cell.viewWithTag(2) as! UIButton
        let item = song[indexPath.row]
        let show = item.notes.joined(separator: " ")
            songName.text = "\(show)"
        
        difficulty.text = "Hard"
//        playButton.setTitle("Play", for: UIControlState())
        
            // Make the background colour alternate
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.1)
        }
        else {
            cell.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sequenceObject.notes = song[indexPath.row].notes
        sequenceObject.id = song[indexPath.row].id
        sequenceObject.name = song[indexPath.row].name
        
        performSegue(withIdentifier: "GamePlay", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let GameController = segue.destination as? GameController else { return }
        GameController.song = sequenceObject
    }
    

    
    func loadData() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                song = try decoder.decode([Song].self, from: data)
            }
            catch{
                print("This is \(error)")
            }
        }
    }

}

