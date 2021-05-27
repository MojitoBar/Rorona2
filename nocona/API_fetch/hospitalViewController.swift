//
//  hospitalViewController.swift
//  nocona
//
//  Created by judongseok on 2021/05/22.
//

import UIKit
import Foundation

// Fetch Data
class FetchData: NSObject, XMLParserDelegate{

    // API 호출 URL
    let API_URL = "http://apis.data.go.kr/B551182/pubReliefHospService/getpubReliefHospList?"
    
    // 필수 항목
    // 페이지 번호
    let pageNo = 1
    // 한 페이지 결과 수
    let numOfRows = 30
    // 구분 코드 A0: 국민안심병원, 97: 코로나 검사 실시 기관, 99: 코로나 선별진료소 운영기관
    let spclAdmTyCd = 99
    // API 토큰
    let API_token = "uayfwbYBxsFuvCYnGnrgQJkG3uBgvepWIDzebW%2Few9ARj2XhpbOFCeAz6B5X4XJB8b6%2BvyNW%2FWqgs4QTl%2Ffz0A%3D%3D"
    
    var hospitals: [Hospital] = []
    private var nHospital: Hospital? = nil
    private var textBuffer: String = ""
    
    override init() {
        super.init()
        let xmlParser = XMLParser(contentsOf: URL(string: "\(API_URL)serviceKey=\(API_token)&pageNo=\(pageNo)&numOfRows=\(numOfRows)&spclAdmTyCd=\(spclAdmTyCd)")!)
        xmlParser!.delegate = self
        xmlParser!.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            nHospital = Hospital()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "item":
            if let hospital = nHospital{
                hospitals.append(hospital)
            }
        case "adtFrDd":
            nHospital?.adtFrDd = textBuffer
            textBuffer = ""
        case "sgguNm":
            nHospital?.sgguNm = textBuffer
            textBuffer = ""
        case "sidoNm":
            nHospital?.sidoNm = textBuffer
            textBuffer = ""
        case "spclAdmTyCd":
            nHospital?.spclAdmTyCd = textBuffer
            textBuffer = ""
        case "telno":
            nHospital?.telno = textBuffer
            textBuffer = ""
        case "yadmNm":
            nHospital?.yadmNm = textBuffer
            textBuffer = ""
        default:
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
