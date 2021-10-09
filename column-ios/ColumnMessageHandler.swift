import Foundation
import WebKit

class ColumnMessageHandler: NSObject, WKScriptMessageHandler {
    var eventHandler: (_ event: String,_ payload: NSDictionary) -> Void
    
    init(eventHandler: @escaping (String, NSDictionary) -> Void) {
        self.eventHandler = eventHandler
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("received message: '\(message.name)' payload: \(message.body)")
        if let messageDict = message.body as? NSDictionary {
            eventHandler(message.name, messageDict)
        } else {
            let fallbackDict: NSDictionary = NSDictionary()
            eventHandler(message.name, fallbackDict)
        }
    }
}
