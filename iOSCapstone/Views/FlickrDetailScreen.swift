//
//  FlickrDetailScreen.swift
//  iOSCapstone
//
//  Created by Malik Muhammad on 3/24/26.
//

import SwiftUI

struct FlickrDetailScreen: View {
    let flickrItem : FlickrItem
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            AsyncImage(url: URL(string: flickrItem.media.m)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(alignment: .center)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
                    .foregroundStyle(.gray)
            }
            .frame(width: 350)
            .frame(height: 350)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            Text(flickrItem.title).fontWeight(.semibold)
            
            Divider()
            VStack(alignment: .leading, spacing: 10) {
                Text("Author: \(flickrItem.author)").foregroundStyle(.gray)
                Text("Date Taken: \(flickrItem.date_taken)").foregroundStyle(.gray)
                Text("Link: \(flickrItem.link)").foregroundStyle(.blue)
            }.padding(.top, 1)
            
        }
        
    }
}

#Preview {
    FlickrDetailScreen(flickrItem: FlickrItem(title: "2026-03-24_05-51-58", link: "https://www.flickr.com/photos/137514889@N05/55165822462/", media: FlickrMedia(m: "https://live.staticflickr.com/65535/55165822462_f3a690bb7d_m.jpg"), date_taken: "2025-05-09T22:38:41-08:00", description: " <p><a href=\"https://www.flickr.com/people/137514889@N05/\">joanbartl</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/137514889@N05/55165822462/\" title=\"2026-03-24_05-51-58\"><img src=\"https://live.staticflickr.com/65535/55165822462_f3a690bb7d_m.jpg\" width=\"180\" height=\"240\" alt=\"2026-03-24_05-51-58\" /></a></p> ", published: "2026-03-24T21:52:04Z", author: "nobody@flickr.com (\"joanbartl\")", author_id: "137514889@N05", tags: ""))
}
