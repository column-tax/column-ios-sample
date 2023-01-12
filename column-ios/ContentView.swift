import SwiftUI

let url = "<put user url from backend here>"

struct ContentView: View {
    @State var activeWebView = false

    var body: some View {
        ZStack {
            Color(UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.0)).edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 0) {
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
                        urlRequest: URLRequest(url: URL(string: url)!),
                        isPresented: self.$activeWebView,
                        moduleEventController: ColumnMessageHandler(eventHandler: self.eventHandler)).edgesIgnoringSafeArea(.all)
                })
            }
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
