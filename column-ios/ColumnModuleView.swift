import SwiftUI
import WebKit

class NavigationDelegate: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let allowedDomains = [
            "localhost",
            "columnapi.com",
            "env.bz"
        ];

        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }

        guard let host = url.host else {
            decisionHandler(.allow)
            return
        }

        let searchParams = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        )?.queryItems;

        let isExternalLink = searchParams?.filter { param in
            param.name == "columntax-external-link" && param.value == "true"
        }.count ?? 0 > 0

        let isAllowedInWebview = allowedDomains.filter { domain in
            host == domain || host.hasSuffix(domain)
        }.count > 0

        if !isExternalLink && isAllowedInWebview {
            decisionHandler(.allow)
            return
        }

        decisionHandler(.cancel)
        UIApplication.shared.open(url)
    }
}

struct ColumnModuleView: UIViewRepresentable {
    let urlRequest: URLRequest
    @Binding var isPresented: Bool
    var moduleEventController: ColumnMessageHandler

    var navigationDelegate: WKNavigationDelegate = NavigationDelegate()

    func updateUIView(_ uiView: ColumnWebView, context: Context) {
        uiView.load(urlRequest)
    }

    public func closeView() -> Void {
        self.isPresented = false
    }

    func makeUIView(context: Context) -> ColumnWebView  {
        let columnWebView = ColumnWebView()
        columnWebView.configuration.userContentController.add(moduleEventController, name: "column-on-close")
        columnWebView.configuration.userContentController.add(moduleEventController, name: "column-on-user-event")
        columnWebView.navigationDelegate = self.navigationDelegate;
        return columnWebView
    }
}
