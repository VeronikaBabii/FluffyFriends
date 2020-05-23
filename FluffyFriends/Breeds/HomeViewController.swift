//
//  HomeViewController.swift
//  FluffyFriends
//
//  Created by Veronika Babii on 05.05.2020.
//  Copyright © 2020 Veronika Babii. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cats = [Cat]()
    
    var allBreeds = [String]()
    var searchBreed = [String]()
    
    var searching = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchBreed.count
        } else {
            return cats.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        // put not here
        allBreeds.append(cats[indexPath.row].name.capitalized)
        
        if (searching) {
            cell.textLabel?.text = searchBreed[indexPath.row]
        } else {
            cell.textLabel?.text = cats[indexPath.row].name.capitalized
        }
        
        return cell
    }
    
    // which row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // change VC
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    // pass the data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CatViewController {
            destination.cat = cats[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func downloadJSON(completed: @escaping () -> () ) {
        
        let url = URL(string: "https://api.thecatapi.com/v1/breeds")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do {
                    self.cats = try JSONDecoder().decode([Cat].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("JSON Error")
                }
            }
        }.resume()
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // filter array of breeds
        print(allBreeds)
        searchBreed = allBreeds.filter({$0.prefix(searchText.count) == searchText})
        searching = true
        tableView.reloadData()
    }
}
