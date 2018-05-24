//
//  ViewController.swift
//  nativeDragDrop
//
//  Created by Brian D Keane on 5/23/18.
//  Copyright © 2018 Brian D Keane. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        print("perform drop with")
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        var draggedItem = ""
        switch tableView {
        case self.numbersTableView:
            draggedItem = self.numbers[indexPath.row]
        case self.lettersTableView:
            draggedItem = self.letters[indexPath.row]
        default:
            break
        }
        let itemProvider = NSItemProvider(object: draggedItem as NSItemProviderWriting)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, dragSessionAllowsMoveOperation session: UIDragSession) -> Bool {
        print("drag session allows move")
        return true
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    

    
    
    
    
    @IBOutlet weak var numbersTableView: UITableView!
    @IBOutlet weak var lettersTableView: UITableView!
    
    var numbers:[String] = ["0","1","2","3","4","5","6","7","8","9","10"]
    var letters:[String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableViews()
    }
    
    func setupTableViews() {
        self.numbersTableView.delegate = self
        self.numbersTableView.dataSource = self
        self.numbersTableView.dragDelegate = self
        self.numbersTableView.dropDelegate = self
        self.numbersTableView.dragInteractionEnabled = true
        
        
        self.lettersTableView.delegate = self
        self.lettersTableView.dataSource = self
        self.lettersTableView.dragDelegate = self
        self.lettersTableView.dropDelegate = self
        self.lettersTableView.dragInteractionEnabled = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.numbersTableView:
            return self.numbers.count
        case self.lettersTableView:
            return self.letters.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellTitle = ""
        var identifier = ""
        switch tableView {
        case self.numbersTableView:
            cellTitle = self.numbers[indexPath.row]
            identifier = "numbersCell"
        case self.lettersTableView:
            cellTitle = self.letters[indexPath.row]
            identifier = "lettersCell"
        default:
            break
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for:indexPath)
        cell.textLabel?.text = cellTitle
        return cell
    }
}

