//
//  FlickrModel.swift
//  iOSCapstone
//
//  Created by Malik Muhammad on 3/24/26.
//

import Foundation

struct FlickrModel : Decodable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    var items: [FlickrItem]
    
}

struct FlickrItem: Decodable, Identifiable {
    let title: String
    let link: String
    let media: FlickrMedia
    let date_taken: String
    let description: String
    let published: String
    let author: String
    let author_id: String
    let tags: String
    let id = UUID()
}

struct FlickrMedia: Decodable {
    let m: String
}
