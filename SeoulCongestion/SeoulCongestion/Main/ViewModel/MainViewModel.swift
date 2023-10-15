//
//  MainViewModel.swift
//  SeoulCongestion
//
//  Created by jangilkyu on 2023/10/15.
//

import Foundation

class MainViewModel {
    var seoulCities: SeoulCities?
    var resHandler: ResHandler?
    var restProcessor: RestProcessor
    
    /// 전체보기
    var viewAll: [City] = []
    /// 고궁 · 문화유산
    var culturalheritage: [City] = []
    /// 공원
    var park: [City] = []
    /// 관광특구
    var tourismSpecialZone: [City] = []
    /// 발달상권
    var centralBusinessDistrict: [City] = []
    /// 인구밀집지역
    var denselyPopulatedArea: [City] = []
    
    init(restProcessor: RestProcessor) {
        self.restProcessor = restProcessor
    }
    
    func getCitiesAPIInfo() {
        restProcessor.makeRequest(
        toURL: EndPoint.seoulCitiesData.url,
        withHttpMethod: .get,
        usage: .seoulCitiesData
      )
    }
    
    /// 도시 검색
    func getCitiesSearchAPI(_ searchCity: String) {
        restProcessor.urlQueryParameters.add(
          value: searchCity,
          forKey: "searchId"
        )
        
        restProcessor.makeRequest(
          toURL: EndPoint.search.url,
          withHttpMethod: .get,
          usage: .search
        )
    }
    
    func categorizeCities() {
        guard let seoulCities = seoulCities?.getCity() else { return }
        viewAll = seoulCities
        for data in seoulCities {
            if data.Category == "고궁·문화유산" {
                culturalheritage.append(data)
            } else if data.Category == "공원" {
                park.append(data)
            } else if data.Category == "관광특구" {
                tourismSpecialZone.append(data)
            } else if data.Category == "발달상권" {
                centralBusinessDistrict.append(data)
            } else if data.Category == "인구밀집지역" {
                denselyPopulatedArea.append(data)
            }
        }
    }
}
