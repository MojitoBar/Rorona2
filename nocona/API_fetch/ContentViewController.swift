//
//  hospitalViewController.swift
//  nocona
//
//  Created by judongseok on 2021/05/22.
//

import UIKit
import Foundation

struct CountInfo {
    var current: String?
    var total: String?
}

// Fetch Data
class FetchCount: NSObject, XMLParserDelegate{

    // API 호출 URL
    let API_URL = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?"
    
    // 필수 항목
    // 페이지 번호
    let pageNo = 1
    // 한 페이지 결과 수
    let numOfRows = 1
    
    // 시작 날짜, 끝 날짜
    var startCreateDt: String = ""
    var endCreateDt: String = ""
    
    // API 토큰
    let API_token = "uayfwbYBxsFuvCYnGnrgQJkG3uBgvepWIDzebW%2Few9ARj2XhpbOFCeAz6B5X4XJB8b6%2BvyNW%2FWqgs4QTl%2Ffz0A%3D%3D"
    
    var countInfo: [CountInfo] = []
    private var ncountInfo: CountInfo? = nil
    private var textBuffer: String = ""
    
    override init() {
        super.init()
        
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = "yyyyMMdd"
        endCreateDt = formatter_year.string(from: Date())
        
        startCreateDt = String(Int(endCreateDt)! - 1)
        
        let xmlParser = XMLParser(contentsOf: URL(string: "\(API_URL)serviceKey=\(API_token)&pageNo=\(pageNo)&numOfRows=\(numOfRows)&startCreateDt=\(startCreateDt)&endCreateDt=\(endCreateDt)")!)
        xmlParser!.delegate = self
        xmlParser!.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            ncountInfo = CountInfo()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "item":
            if let countinfo = ncountInfo{
                countInfo.append(countinfo)
            }
        case "decideCnt":
            ncountInfo?.total = textBuffer
            textBuffer = ""
        default:
            textBuffer = ""
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
            textBuffer += string
        }
        
        // Called when a CDATA block is found
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        guard let string = String(data: CDATABlock, encoding: .utf8) else {
            print("CDATA contains non-textual data, ignored")
            return
        }
        textBuffer += string
    }
    
    // For debugging
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
        print("on:", parser.lineNumber, "at:", parser.columnNumber)
    }
}
