//
//  Response.swift
//  Woltrestaurants
//
//  Created by Nick Semin on 18.01.2023.
//

import Foundation

// MARK: - Response
/// Struct to decode all data from the JSON
struct Response: Codable {
    let created: Created
    let expiresInSeconds: Int
    let filtering: ResponseFiltering
    let name, pageTitle: String
    let sections: [Section]
    let showLargeTitle, showMap: Bool
    let sorting: ResponseSorting
    let trackID: String

    enum CodingKeys: String, CodingKey {
        case created
        case expiresInSeconds = "expires_in_seconds"
        case filtering, name
        case pageTitle = "page_title"
        case sections
        case showLargeTitle = "show_large_title"
        case showMap = "show_map"
        case sorting
        case trackID = "track_id"
    }
}

// MARK: - Created
struct Created: Codable {
    let date: Int

    enum CodingKeys: String, CodingKey {
        case date = "$date"
    }
}

// MARK: - ResponseFiltering
struct ResponseFiltering: Codable {
    let filters: [SortableElement]
}

// MARK: - SortableElement
struct SortableElement: Codable {
    let id, name, type: String
    let values: [Value]?
}

// MARK: - Value
struct Value: Codable {
    let id, name: String
}

// MARK: - Section
struct Section: Codable {
    let items: [Item]
    let link: Link?
    let name, template, title: String
}

// MARK: - Item
struct Item: Codable {
    let description: String?
    let image: Image
    let link: Link
    let quantity: Int?
    let quantityStr: String?
    let template: String
    let title, trackID: String
    let filtering: ItemFiltering?
    let sorting: ItemSorting?
    let venue: Venue?
    let overlay: String?

    enum CodingKeys: String, CodingKey {
        case description, image, link, quantity
        case quantityStr = "quantity_str"
        case template, title
        case trackID = "track_id"
        case filtering, sorting, venue, overlay
    }
}

// MARK: - ItemFiltering
struct ItemFiltering: Codable {
    let filters: [PurpleFilter]
}

// MARK: - PurpleFilter
struct PurpleFilter: Codable {
    let id: String
    let values: [String]
}

// MARK: - Image
struct Image: Codable {
    let blurhash: String
    let url: String
}

// MARK: - Link
struct Link: Codable {
    let target: String
    let targetSort: String
    let targetTitle, title: String
    let type: String
    let venueMainimageBlurhash: String?

    enum CodingKeys: String, CodingKey {
        case target
        case targetSort = "target_sort"
        case targetTitle = "target_title"
        case title, type
        case venueMainimageBlurhash = "venue_mainimage_blurhash"
    }
}

// MARK: - ItemSorting
struct ItemSorting: Codable {
    let sortables: [Sortable]
}

// MARK: - Sortable
struct Sortable: Codable {
    let id: String
    let value: Int
}

// MARK: - Venue
struct Venue: Codable {
    let address: String
    let badges: [Badge]
    let city: String
    let country: String
    let currency: String
    let delivers: Bool
    let deliveryPrice: String
    let deliveryPriceHighlight: Bool
    let deliveryPriceInt, estimate: Int
    let estimateRange: String
    let franchise, id: String
    let location: [Double]
    let name: String
    let online: Bool
    let priceRange: Int
    let productLine: String?
    let rating: Rating?
    let shortDescription: String
    let showWoltPlus: Bool
    let slug: String
    let tags: [String]
    let icwDuctLine: String?

    enum CodingKeys: String, CodingKey {
        case address, badges, city, country, currency, delivers
        case deliveryPrice = "delivery_price"
        case deliveryPriceHighlight = "delivery_price_highlight"
        case deliveryPriceInt = "delivery_price_int"
        case estimate
        case estimateRange = "estimate_range"
        case franchise, id, location, name, online
        case priceRange = "price_range"
        case productLine = "product_line"
        case rating
        case shortDescription = "short_description"
        case showWoltPlus = "show_wolt_plus"
        case slug, tags
        case icwDuctLine = "icw-duct_line"
    }
}

// MARK: - Badge
struct Badge: Codable {
    let text: String
    let variant: String
}

// MARK: - Rating
struct Rating: Codable {
    let rating: Int
    let score: Double
}

// MARK: - ResponseSorting
struct ResponseSorting: Codable {
    let sortables: [SortableElement]
}
