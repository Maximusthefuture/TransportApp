//
//  BusStopDetail.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import Foundation


struct TransportStopDetail: Codable {
    let id, name, type: String
//    let wifi: Bool
//    let bench, elevator: JSONNull?
//    let comment, hub: [JSONAny]
//    let photo: JSONNull?
//    let commentTotalCount: Int
    let routePath: [RoutePath]
//    let color, routeNumber: String
//    let isFavorite: Bool
//    let shareURL: String
    let lat, lon: Double
//    let cityShuttle, electrobus: Bool
//    let transportTypes: [String]
//    let routeName, shuttleType: JSONNull?
//    let regional: Bool
//    let debug: [JSONAny]

    enum CodingKeys: String, CodingKey {
//        case id, name, type, wifi, hub, commentTotalCount, routePath, color, routeNumber, isFavorite
//        case shareURL = "shareUrl"
//        case lat, lon, cityShuttle, electrobus, transportTypes, regional
        case id, name, type
        case routePath
        case lat, lon
    }
}

// MARK: - RoutePath
struct RoutePath: Codable {
    let id, routePathID, type, number: String
    let timeArrivalSecond: [Int]
    let timeArrival: [String]
    let lastStopName: String
    let isFifa, weight, byTelemetry: Int
    let color, fontColor: String
    let cityShuttle, electrobus: Bool
    let fixedArrivalTime: JSONNull?
    let tmIDS: [Int]
    let externalForecastTime: [ExternalForecastTime]
//    let externalForecast: [JSONAny]
    let telemetryForecastTime: JSONNull?
    let byTelemetryArray: [Int]
    let routePathIDS, feature: JSONNull?
    let sberShuttle, isFavorite: Bool
//    let messages: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case id
        case routePathID = "routePathId"
        case type, number, timeArrivalSecond, timeArrival, lastStopName, isFifa, weight, byTelemetry, color, fontColor, cityShuttle, electrobus, fixedArrivalTime
        case tmIDS = "tmIds"
        case externalForecastTime, telemetryForecastTime, byTelemetryArray
        case routePathIDS = "routePathIds"
        case feature, sberShuttle, isFavorite
    }
}

// MARK: - ExternalForecastTime
struct ExternalForecastTime: Codable {
    let time, byTelemetry, tmID: Int
    let routePathID: String

    enum CodingKeys: String, CodingKey {
        case time, byTelemetry
        case tmID = "tmId"
        case routePathID = "routePathId"
    }
}
