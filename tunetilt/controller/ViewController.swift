//
//  ViewController.swift
//  tunetilt
//
//  Created by Jonathan Moallem on 15/5/18.
//  Copyright © 2018 Blinking Light Studios. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Sequences1.plist")
//    var Thenote = [String : Array<Any>]()
//    var a = [AnyObject]()
    var db: Firestore!
    var newNote = [Song]()
    var storage = SongsStorage()
    override func viewDidLoad() {
        super.viewDidLoad()
        readNotes()
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func readNotes(){
        db = Firestore.firestore()
        db.collection("sequences").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let id = document.documentID
                        if let note = document.data()["notes"] as? [String]{
                            if let name = document.data()["name"] as? String {
                            let newItem = Song()
                                print(id)
                            newItem.id = id
                            newItem.notes = note
                            newItem.name = name
                            self.newNote.append(newItem)
                            self.storage.saveData(theNote: self.newNote)
                            }
                        }   
                }
            }
        }
    }


}

