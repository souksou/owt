//
//  HomeViewController.swift
//  owt-tiny-mvvm
//
//  Created by Souksouvanh Thomas on 30/05/2019.
//  Copyright © 2019 th. All rights reserved.
//

import UIKit
import RealmSwift



class HomeViewController: UIViewController {
    
    private var viewModel = HomeViewModel(networkingService: TinyUrlApi())
    private var tinyUrls: [TinyUrl]?

    private var searchViewController: UISearchController?
    @IBOutlet var tableView: UITableView!
    @IBOutlet var emptyLabel: UILabel!
    
    let dateFormatter: DateFormatter = {
        var df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy, HH:mm"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        tableView.register(TinyUrlTableViewCell.self, forCellReuseIdentifier: "Cell")
        let nib = UINib(nibName: "TinyUrlTableViewCell", bundle:nil)
        tableView.register(nib, forCellReuseIdentifier: "TinyUrlTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: .zero)
        
        self.setupNavController()
        self.setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.ready()
    }
    
    private func setupViewModel() {
        viewModel.isRefreshing = { loading in
            UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        }
        viewModel.didUpdateTiny = { [weak self] tinyUrls in
            guard let strongSelf = self else { return }
            
            if tinyUrls.count == 0 {
                strongSelf.tableView.isHidden  = true
                strongSelf.emptyLabel.isHidden = false
            } else {
                strongSelf.tableView.isHidden  = false
                strongSelf.emptyLabel.isHidden = true
            }
            strongSelf.tinyUrls = tinyUrls
            strongSelf.tableView.reloadData()
        }
    }
    
    func setupNavController() {
        self.navigationController?.navigationBar.prefersLargeTitles = false               
        
        self.searchViewController = UISearchController(searchResultsController: nil)
        self.searchViewController?.searchResultsUpdater = self
        self.searchViewController?.searchBar.delegate   = self
        self.searchViewController?.searchBar.tintColor  = .white
        self.searchViewController?.dimsBackgroundDuringPresentation = false
        
        let textFieldInsideSearchBar = self.searchViewController?.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        textFieldInsideSearchBar?.tintColor = .white
        
        navigationItem.searchController = self.searchViewController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tinyUrls?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = tinyUrls else { return TinyUrlTableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TinyUrlTableViewCell", for: indexPath)
        if let tinyCell = cell as? TinyUrlTableViewCell   {
            tinyCell.orignalUrl.text   = data[indexPath.row].originalUrl
            tinyCell.transformUrl.text = data[indexPath.row].urlTransform
            tinyCell.dateLabel.text    =  self.dateFormatter.string(from: data[indexPath.row].dateCreate!)
        }
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            guard let data = tinyUrls else { return }
            viewModel.deleteUrl(data[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = tinyUrls else { return }  
        if let url = URL(string: data[indexPath.row].urlTransform) {
            UIApplication.shared.open(url)
        }
    }
}

extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
       viewModel.didChangeQuery(searchController.searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.ready()
    }
}

