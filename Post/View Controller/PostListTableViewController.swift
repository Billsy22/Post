//
//  PostListTableViewController.swift
//  Post
//
//  Created by Taylor Bills on 2/5/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    // MARK: -  Properties
    
    @IBOutlet weak var pullToRefresh: UIRefreshControl!
    
    var postController = PostController()
    
    // MARK: -  Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        reloadTableView()
    }
    
    // MARK: -  Table View Data Source Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postController.posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let post = postController.posts[indexPath.row]
        cell.textLabel?.text = post.text
        cell.detailTextLabel?.text = "\(post.userName), \(post.timestamp)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: -  Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    // MARK: -  Actions
    @IBAction func refreshActivated(_ sender: UIRefreshControl) {
        reloadTableView()
        pullToRefresh.endRefreshing()
    }
    
    
    // MARK: -  Reload TableView
    
    func reloadTableView() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        postController.fetchPosts { (success) in
            if success {
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            } else {
                print("Something brokdid ")
            }
        }

    }
}

