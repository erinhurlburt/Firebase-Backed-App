//
//  Article.swift
//  Blog
//
//  Created by Erin Hurlburt on 4/3/22.
//

import Foundation

struct Article: Hashable, Codable, Identifiable {
    var id: String
    var title: String
    var date: Date
    var author: String
    var link: String
    var body: String
    var mealType: String
}

