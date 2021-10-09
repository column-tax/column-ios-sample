import SwiftUI
import WebKit

struct ColumnModuleView: UIViewRepresentable {
    let urlRequest: URLRequest
    @Binding var isPresented: Bool
    var moduleEventController: ColumnMessageHandler

    func updateUIView(_ uiView: ColumnWebView, context: Context) {
        uiView.load(urlRequest)
    }

    public func closeView() -> Void {
        self.isPresented = false
    }

    func makeUIView(context: Context) -> ColumnWebView  {
        let columnWebView = ColumnWebView()
        columnWebView.configuration.userContentController.add(moduleEventController, name: "column-on-close")
        return columnWebView
    }
}
