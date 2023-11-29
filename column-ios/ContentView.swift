import SwiftUI

let defaultUserUrl = "<user url>"

struct ContentView: View {
    @State private var inputText: String = ""
    @State var activeWebView = false

    var body: some View {
        ZStack {
            Color(UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.0)).edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 20) {
                Text("CT iOS Tester")
                    .foregroundColor(.white)
                    .font(.title)

                // Single-line text input
                TextField("Paste Column Tax URL here", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    self.activeWebView = true
                }) {
                    Text("Open Column")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding()
                        .border(Color(.white), width: 5)
                }.sheet(isPresented: $activeWebView, content: {
                    ColumnModuleView(
                        urlRequest: URLRequest(url: URL(string: getUrlText())!),
                        isPresented: self.$activeWebView,
                        moduleEventController: ColumnMessageHandler(eventHandler: self.eventHandler)).edgesIgnoringSafeArea(.all)
                })
            }
        }
    }

    func getUrlText() -> String {
        if (self.inputText.isEmpty) {
            return defaultUserUrl;
        } else {
            return self.inputText;
        }
    }

    func eventHandler(_ event: String, payload: NSDictionary) {
        switch event {
        case "column-on-close":
            activeWebView = false
        case "column-on-user-event":
            print("Received user event: '\(event)'")
        default:
            print("Unrecognized event: '\(event)'")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
