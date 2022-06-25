//
//  API_commit.swift
//  GITrack
//
//  Created by Jin younkyum on 2022/06/25.
//

import UIKit

struct userRepo: Codable {
    var name: String
}

struct repoCommit: Codable {
    var commit: Commit
}

struct Commit: Codable {
    var author: Author
}

struct Author: Codable {
    var date: String
}
