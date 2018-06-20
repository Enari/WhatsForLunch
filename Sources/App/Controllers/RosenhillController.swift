import Vapor
import SwiftSoup

/// Controls basic CRUD operations on `Todo`s.
final class RosenhillController {
    let rosenhillURL = "http://www.hors.se/restaurang/restaurang-rosenhill"
    
    func index(_ req: Request) throws -> Future<String> {
        let client = try req.client()
        let html = client.get(rosenhillURL)
        return html.map { response in
            guard let data = response.http.body.data else {
                return "Invalid response from server"
                
            }
            guard let withencoding = String(data: data, encoding: .utf8) else {
                return "Failed to decode reponse form server"
            }
            
            return self.getLunch(from: withencoding)
        }
    }
    
    func getLunch(from html: String) -> String {
        var allLunches = String()
        
        do{
            let doc: Document = try! SwiftSoup.parse(html)
            let body: Element = doc.body()!
            
            let lunchdivs = try body.getElementsByClass("col-xs-10 text-left")
            
            for lunchdiv in lunchdivs {
                let lunch = try lunchdiv.html()
                allLunches += lunch + "\n"
            }
        }
        catch{
            return "Failed to parse the data from server"
        }
        return allLunches
    }
}
