//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
	private let url: URL
	private let client: HTTPClient
	private static let OK_200 = 200

	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}

	public init(url: URL, client: HTTPClient) {
		self.url = url
		self.client = client
	}

	public func load(completion: @escaping (FeedLoader.Result) -> Void) {
		client.get(from: url) { [weak self] result in
			guard let self = self else { return }

			switch result {
			case .success(let (data, response)):

				guard
					response.statusCode == RemoteFeedLoader.OK_200,
					let root = try? JSONDecoder().decode(Root.self, from: data)
				else {
					return completion(.failure(Error.invalidData))
				}

				return completion(.success(self.mapRootToFeedImages(root)))
			case .failure:
				return completion(.failure(Error.connectivity))
			}
		}
	}

	// MARK: - Helper

	private func mapRootToFeedImages(_ root: Root) -> [FeedImage] {
		root.items.map { $0.feedImage }
	}
}
