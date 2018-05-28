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
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.numbers.count
        default:
            return self.letters.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let spacer = tableView.reorder.spacerCell(for: indexPath) {
            return spacer
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "numbersCell", for:indexPath)
        if (indexPath.section == 0) {
            cell.textLabel?.text = self.numbers[indexPath.row]
        } else {
            cell.textLabel?.text = self.letters[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "numbers"
        case 1:
            return "letters"
        default:
            return "damn"
        }
    }
    func tableView(_ tableView: UITableView, reorderRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var sourceArray:[String] = (sourceIndexPath.section == 0) ? self.numbers : self.letters
        var destinationArray:[String] = (destinationIndexPath.section == 0) ? self.numbers : self.letters
        
        var item = sourceArray.remove(at: sourceIndexPath.row)
        destinationArray.insert(item, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canReorderRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row == 3) {
            return false
        }
        return true
    }
}

