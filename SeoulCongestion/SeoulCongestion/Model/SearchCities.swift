//
//  SearchCities.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/02/18.
//

import Foundation

struct SearchCities: Codable {
    let livePpltnStts: LivePpltnStts
    let avgRoadData: AvgRoadData
    let sbikeStts: [SbikeStts]?
    let areaNm: String

    enum CodingKeys: String, CodingKey {
        case livePpltnStts = "LIVE_PPLTN_STTS"
        case avgRoadData = "AVG_ROAD_DATA"
        case sbikeStts = "SBIKE_STTS"
        case areaNm = "AREA_NM"
    }
}

struct LivePpltnStts: Codable {
    let areaCongestLvl, areaCongestMsg, areaPpltnMin, areaPpltnMax: String
    let malePpltnRate, femalePpltnRate, ppltnRate0, ppltnRate10: String
    let ppltnRate20, ppltnRate30, ppltnRate40, ppltnRate50: String
    let ppltnRate60, ppltnRate70, resntPpltnRate, nonResntPpltnRate: String
    let replaceYn, ppltnTime, id: String

    enum CodingKeys: String, CodingKey {
        case areaCongestLvl = "AREA_CONGEST_LVL"
        case areaCongestMsg = "AREA_CONGEST_MSG"
        case areaPpltnMin = "AREA_PPLTN_MIN"
        case areaPpltnMax = "AREA_PPLTN_MAX"
        case malePpltnRate = "MALE_PPLTN_RATE"
        case femalePpltnRate = "FEMALE_PPLTN_RATE"
        case ppltnRate0 = "PPLTN_RATE_0"
        case ppltnRate10 = "PPLTN_RATE_10"
        case ppltnRate20 = "PPLTN_RATE_20"
        case ppltnRate30 = "PPLTN_RATE_30"
        case ppltnRate40 = "PPLTN_RATE_40"
        case ppltnRate50 = "PPLTN_RATE_50"
        case ppltnRate60 = "PPLTN_RATE_60"
        case ppltnRate70 = "PPLTN_RATE_70"
        case resntPpltnRate = "RESNT_PPLTN_RATE"
        case nonResntPpltnRate = "NON_RESNT_PPLTN_RATE"
        case replaceYn = "REPLACE_YN"
        case ppltnTime = "PPLTN_TIME"
        case id = "_id"
    }
}

struct AvgRoadData: Codable {
    let roadMsg, roadTrafficIdx, roadTrfficTime, roadTrafficSpd: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case roadMsg = "ROAD_MSG"
        case roadTrafficIdx = "ROAD_TRAFFIC_IDX"
        case roadTrfficTime = "ROAD_TRFFIC_TIME"
        case roadTrafficSpd = "ROAD_TRAFFIC_SPD"
        case id = "_id"
    }
}

struct SbikeStts: Codable {
  let sbikeParkingCnt, sbikeRackCnt, sbikeShared, sbikeSpotID, sbikeSpotNM: String
  
  enum CodingKeys: String, CodingKey {
      case sbikeParkingCnt = "SBIKE_PARKING_CNT"
      case sbikeRackCnt = "SBIKE_RACK_CNT"
      case sbikeShared = "SBIKE_SHARED"
      case sbikeSpotID = "SBIKE_SPOT_ID"
      case sbikeSpotNM = "SBIKE_SPOT_NM"
  }
}
