//
//  PostController.swift
//  Post
//
//  Created by Taylor Bills on 2/5/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import Foundation

class PostController {
    
    // MARK: -  Properties
    
    static let baseURL = URL(string: "https://post-c5c9c.firebaseio.com/")!
    var posts: [Post] = []
    
    func fetchPosts(completion: @escaping(_ success: Bool) -> Void) {
        let baseURL = PostController.baseURL
        let getterEndpoint = baseURL.appendingPathExtension("json")
        var request = URLRequest(url: getterEndpoint)
        request.httpMethod = "GET"
        request.httpBody = nil
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("\(error)")
                completion(false)
            }
            guard let data = data else { completion(false); return }
            let jsonDecoder = JSONDecoder()
            do {
                let postsDictionary = try jsonDecoder.decode([String:Post].self, from: data)
                let posts = postsDictionary.flatMap({ (postValues) -> Post in
                    return postValues.value
                })
                let sortedPosts = posts.sorted(by: { $0.timestamp > $1.timestamp} )
                self.posts = sortedPosts
                completion(true)
            } catch let error {
                print("\(error)")
                completion(false)
                return
            }
            
            } .resume()
    }
}
