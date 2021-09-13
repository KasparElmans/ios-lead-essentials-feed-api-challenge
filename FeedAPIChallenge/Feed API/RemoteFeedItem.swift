//
//  RemoteFeedItem.swift
//  FeedAPIChallenge
//
//  Created by Kaspar Elmans on 13/09/2021.
//  Copyright © 2021 Essential Developer Ltd. All rights reserved.
//

import Foundation

struct Root: Decodable {
	let items: [RemoteFeedItem]
}

struct RemoteFeedItem: Decodable {
	let id: UUID
	let description: String?
	let location: String?
	let image: URL

	enum CodingKeys: String, CodingKey {
		case id = "image_id"
		case description = "image_desc"
		case location = "image_loc"
		case image = "image_url"
	}

	var feedImage: FeedImage {
		.init(
			id: id,
			description: description,
			location: location,
			url: image
		)
	}
}
