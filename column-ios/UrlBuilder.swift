import Foundation

class UrlBuilder {
    func createUrlForWebView(token: String) -> String {
        let params: NSMutableDictionary = NSMutableDictionary()
        params.setValue(token, forKey: "token")
        let jsonData = try? JSONSerialization.data(withJSONObject: params, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        let base64Params = (jsonString!.data(using: .utf8)?.base64EncodedString())!
        // Sandbox URL: "https://app-sandbox.columnapi.com/sdk?params="
        // Production URL: "https://app.columnapi.com/sdk?params="
        let urlString = "https://app-sandbox.columnapi.com/sdk?params=" + base64Params
        let percentEncodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return percentEncodedUrlString!
    }
}
