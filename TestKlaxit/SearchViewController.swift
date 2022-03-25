//
//  SearchViewController.swift
//  TestKlaxit
//
//  Created by Pierre Corsenac on 24/03/2022.
//

import UIKit

class SearchResults: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = Geo(type: "", version: "", features: [], attribution: "", licence: "", query: "", limit: 0)
    
    public let itemTableView: UITableView = {
        let itemTableView = UITableView(frame: .zero, style: .grouped)
        itemTableView.backgroundColor = .black
        itemTableView.register(GeoTableCell.self, forCellReuseIdentifier: GeoTableCell.identifier)
        
        return itemTableView
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(itemTableView)
        
        itemTableView.delegate = self
        itemTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        itemTableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let feature = data.features {
            return feature.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GeoTableCell.identifier, for: indexPath) as? GeoTableCell else {return UITableViewCell()}
        
        if let features = data.features {
            cell.configure(item: features[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
}

class SearchViewController: UIViewController, UISearchResultsUpdating, UINavigationControllerDelegate, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: SearchResults())
    private let apiCaller = Service()
    private var data = [Geo]()
    private var url = "https://api-adresse.data.gouv.fr/search/?q="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationController?.delegate = self
        searchController.searchBar.delegate = self
        self.navigationController?.navigationBar.tintColor = .tintColor

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchController.searchBar.text = searchText
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        let resultsVC = searchController.searchResultsController as! SearchResults
        
        let query = text.convertToQuery(string: text)
        let searchURL = url + query
        apiCaller.fetchGeoData(url: searchURL) { result in
            resultsVC.data = result
            DispatchQueue.main.async {
                resultsVC.itemTableView.reloadData()
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? ProfileViewController)?.homeAddress.text = searchController.searchBar.text
    }
    
}
