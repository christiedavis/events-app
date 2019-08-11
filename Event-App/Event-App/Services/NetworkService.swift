//
//  NetworkService.swift
//  Event-App
//
//  Created by Christie Davis on 11/08/19.
//  Copyright © 2019 Christie-Davis. All rights reserved.
//

import UIKit

protocol NetworkServiceProtocol: class {
    func getBlogPostList() -> Promise<[BlogPost]>
    func getAllUsers() -> Promise<[User]>
    func getComments(for postId: Int) -> Promise<[Comment]>
}

class NetworkService: BaseNetworkService {
    let postsPath = "posts"
    let userPath = "users"
    let commentsPath = "comments"
}

extension NetworkService: NetworkServiceProtocol {
    func getBlogPostList() -> Promise<[BlogPost]> {
        return self.request(method: .get, path: self.postsPath, parameters: nil)
    }
    
    func getAllUsers() -> Promise<[User]> {
        return self.request(method: .get, path: self.userPath, parameters: nil)
    }
    
    func getComments(for postId: Int) -> Promise<[Comment]> {
        let path = self.commentsPath + "?postId=" + "\(postId)"
        return self.request(method: .get, path: path, parameters: nil)
    }
}
