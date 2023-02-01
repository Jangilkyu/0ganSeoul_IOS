//
//  City.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/01/26.
//

import Foundation

class City: Decodable {
  var areaNm: String?
  var areaCongestLvl: String?
  var areaCongestMsg: String?
  var AreaPpltnMin:  String?
  var areaPpltnMax:  String?
  var malePpltnRate: String?
  var femalePpltnRate: String?
  var roadTrafficIdx: String?
  var roadMSG: String?
  var roadTrafficSPD: String?
}
