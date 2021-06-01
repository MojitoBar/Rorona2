# Rorona

Rorona developed with SwiftUI

공공데이터 포털의 openAPI 사용

### ScreenShots
<img src="https://github.com/MojitoBar/Rorona2/blob/master/screenshot.gif" width="250"/>


### Skill
XMLParser를 이용한 api 데이터 가져오기
```swift
class FetchData: NSObject, XMLParserDelegate{
    // 코로나 선별 진료소를 담을 배열
    var hospitals: [Hospital] = []
    private var nHospital: Hospital? = nil
    private var textBuffer: String = ""
    
    override init() {
        super.init()
        let xmlParser = XMLParser(contentsOf: URL(string: API_URL)
        xmlParser!.delegate = self
        xmlParser!.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    // xml 태그가 item일 때 해당 블럭을 Hospital객체 하나를 선언
        if elementName == "item" {
            nHospital = Hospital()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    // switch 문으로 태그별로 알맞은 값을 넣어줌
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
```
