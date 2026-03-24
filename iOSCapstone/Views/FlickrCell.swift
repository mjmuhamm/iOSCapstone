//
//  FlickrCell.swift
//  iOSCapstone
//
//  Created by Malik Muhammad on 3/24/26.
//

import SwiftUI

struct FlickrCell: View {
    let flickrItem : FlickrItem

    var body: some View {
        NavigationLink {
            FlickrDetailScreen(flickrItem: flickrItem)
        } label: {
            VStack(alignment: .center, spacing: 12) {
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
                .frame(width: 320)
                .frame(height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .background(RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.background)
            )
        }
    }
}

#Preview {
    FlickrCell(flickrItem: FlickrItem(title: "2026-03-24_05-51-58", link: "https://www.flickr.com/photos/137514889@N05/55165822462/", media: FlickrMedia(m: "https://live.staticflickr.com/65535/55165822462_f3a690bb7d_m.jpg"), date_taken: "2025-05-09T22:38:41-08:00", description: " <p><a href=\"https://www.flickr.com/people/137514889@N05/\">joanbartl</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/137514889@N05/55165822462/\" title=\"2026-03-24_05-51-58\"><img src=\"https://live.staticflickr.com/65535/55165822462_f3a690bb7d_m.jpg\" width=\"180\" height=\"240\" alt=\"2026-03-24_05-51-58\" /></a></p> ", published: "2026-03-24T21:52:04Z", author: "nobody@flickr.com (\"joanbartl\")", author_id: "137514889@N05", tags: ""))
}

private extension FlickrItem {
    var cleanedTitle: String {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? "Untitled Photo" : trimmed
    }

    var authorName: String {
        guard let start = author.range(of: "(\""),
              let end = author.range(of: "\")") else {
            return author
        }

        return String(author[start.upperBound..<end.lowerBound])
    }

    var formattedPublishedDate: String {
        let inputFormatter = ISO8601DateFormatter()
        guard let date = inputFormatter.date(from: published) else {
            return "Recent"
        }

        return date.formatted(.dateTime.month(.abbreviated).day())
    }

    var formattedTags: String {
        tags
            .split(separator: " ")
            .prefix(3)
            .map { "#\($0)" }
            .joined(separator: " ")
    }
}
