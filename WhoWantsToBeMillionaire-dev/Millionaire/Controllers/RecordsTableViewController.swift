//
//  RecordsTableViewController.swift
//  WhoWantsToBeMillionaire
//
//  Created by user on 27.03.2022.
//

import UIKit

class RecordsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        data = Game.shared.resultGamesSessions
    }
    
    var data: [Result] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = dateFormatter.string(from: data[indexPath.row].date)
        cell.detailTextLabel?.text = String(data[indexPath.row].resultScore) + "%"

        return cell
    }
}
