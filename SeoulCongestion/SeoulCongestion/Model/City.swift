//
//  City.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/01/26.
//

import Foundation

struct City: Codable {
  let areaNM: String?
  let LIVE_PPLTN_STTS: LIVE_PPLTN_STTS?
  let AVG_ROAD_DATA: AVG_ROAD_DATA?
  
  enum CodingKeys: String, CodingKey {
    case areaNM = "AREA_NM"
    case LIVE_PPLTN_STTS
    case AVG_ROAD_DATA
  }
}

struct LIVE_PPLTN_STTS: Codable {
  let areaCongestLvl: String?
  let areaCongestMSG: String?
  let areaPpltnMAX: String?
  let areaPpltnMIN: String?
  let femalePpltnRATE: String?
  let malePpltnRATE: String?
  let nonResntPpltnRATE: String?
  let ppltnRATE_0: String?
  let ppltnRATE_10: String?
  let ppltnRATE_20: String?
  let ppltnRATE_30: String?
  let ppltnRATE_40: String?
  let ppltnRATE_50: String?
  let ppltnRATE_60: String?
  let ppltnRATE_70: String?
  let ppltnTIME: String?
  let replaceYN: String?
  let resntPpltnRATE: String?
  
  enum CodingKeys: String, CodingKey {
    case areaCongestLvl = "AREA_CONGEST_LVL"
    case areaCongestMSG = "AREA_CONGEST_MSG"
    case areaPpltnMAX = "AREA_PPLTN_MAX"
    case areaPpltnMIN = "AREA_PPLTN_MIN"
    case femalePpltnRATE = "FEMALE_PPLTN_RATE"
    case malePpltnRATE = "MALE_PPLTN_RATE"
    case nonResntPpltnRATE = "NON_RESNT_PPLTN_RATE"
    case ppltnRATE_0 = "PPLTN_RATE_0"
    case ppltnRATE_10 = "PPLTN_RATE_10"
    case ppltnRATE_20 = "PPLTN_RATE_20"
    case ppltnRATE_30 = "PPLTN_RATE_30"
    case ppltnRATE_40 = "PPLTN_RATE_40"
    case ppltnRATE_50 = "PPLTN_RATE_50"
    case ppltnRATE_60 = "PPLTN_RATE_60"
    case ppltnRATE_70 = "PPLTN_RATE_70"
    case ppltnTIME = "PPLTN_TIME"
    case replaceYN = "REPLACE_YN"
    case resntPpltnRATE = "RESNT_PPLTN_RATE"
  }
}

struct AVG_ROAD_DATA: Codable {
  let roadMSG: String?
  let roadTrafficIDX: String?
  let roadTrafficSPD: String?
  let roadTrafficTIME: String?
  
  enum CodingKeys: String, CodingKey {
    case roadMSG = "ROAD_MSG"
    case roadTrafficIDX = "ROAD_TRAFFIC_IDX"
    case roadTrafficSPD = "ROAD_TRAFFIC_SPD"
    case roadTrafficTIME = "ROAD_TRFFIC_TIME"

  }
}
