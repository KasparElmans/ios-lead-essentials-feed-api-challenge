//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
	private let url: URL
	private let client: HTTPClient

	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}

	public init(url: URL, client: HTTPClient) {
		self.url = url
		self.client = client
	}

	public func load(completion: @escaping (FeedLoader.Result) -> Void) {
		client.get(from: url) { result in

			switch result {
			case .success(let response):
				let data = response.0
				let response = response.1

				guard response.statusCode == 200 else {
					return completion(.failure(Error.invalidData))
				}

				guard data.count > 0 else {
					return completion(.success([]))
				}

				// TODO: map data to the model
				return completion(.success([]))
			case .failure:
				return completion(.failure(Error.connectivity))
			}
		}
	}
}
