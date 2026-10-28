#if canImport(SwiftUI)
import SwiftUI

@main
struct PortfolioApp: App {
    var body: some Scene {
        WindowGroup {
            StockListView()
        }
    }
}
#endif