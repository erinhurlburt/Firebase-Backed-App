//
//  Contact.swift
//  Blog
//
//  Created by Lee on 4/3/22.
//

import Foundation
import SwiftUI

struct Contact: Codable, Identifiable {
    var id: String = UUID().uuidString
    var name: String?
}
