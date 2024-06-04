# Column Module Sample iOS App

See the full documentation here: https://docs.columntax.com/

> [!NOTE]
> We recommend use of our iOS SDK rather than using this sample app. See our [Mobile SDK Guide](https://docs.columntax.com/reference/mobile-sdk-guide) for more details.

## Getting Started

1. Open the project in XCode
1. Build & run the app
1. Once your app is up and running, create a new user via the [initialize tax filing endpoint](https://docs.columntax.com/reference/express-initialize-tax-filing)
1. Pass the `user_url` for the new user to the webview by replacing
the url placeholder in [ContentView.swift](https://github.com/column-tax/column-ios-sample/blob/main/column-ios/ContentView.swift#L3).
