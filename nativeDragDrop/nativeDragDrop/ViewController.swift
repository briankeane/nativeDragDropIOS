//
//  ViewController.swift
//  nativeDragDrop
//
//  Created by Brian D Keane on 5/23/18.
//  Copyright © 2018 Brian D Keane. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewReorderDelegate {
    
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
        self.numbersTableView.reorder.delegate = self
        self.numbersTableView.reorder.autoScrollEnabled = false
        
        
        self.lettersTableView.delegate = self
        self.lettersTableView.dataSource = self
        self.lettersTableView.reorder.delegate = self
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
        if let spacer = tableView.reorder.spacerCell(for: indexPath) {
            return spacer
        }
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
    
    func tableView(_ tableView: UITableView, reorderRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        puts("reordering")
    }
    
    func tableView(_ tableView: UITableView, canReorderRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row == 3) {
            return false
        }
        return true
    }
}

