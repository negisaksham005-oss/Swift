#if canImport(SwiftUI)
import SwiftUI

struct StockListView: View {
    // @State keeps the UI updated when this dictionary changes
    @State private var stockData: [String: StockQuote] = [:]
    
    // A sample list of stock tickers to display
    let symbols = ["AAPL", "MSFT", "GOOGL", "TSLA", "AMZN"]
    let apiClient = StockAPIClient()

    var body: some View {
        NavigationStack {
            List(symbols, id: \.self) { symbol in
                HStack {
                    Text(symbol)
                        .font(.headline)
                    
                    Spacer()
                    
                    // Display the price if we have data, otherwise show a loading spinner
                    if let quote = stockData[symbol] {
                        VStack(alignment: .trailing) {
                            Text("$\(String(format: "%.2f", quote.currentPrice))")
                                .bold()
                            
                            // Calculate and display price change
                            let priceChange = quote.currentPrice - quote.previousClose
                            Text("\(priceChange > 0 ? "+" : "")\(String(format: "%.2f", priceChange))")
                                .font(.caption)
                                .foregroundColor(priceChange >= 0 ? .green : .red)
                        }
                    } else {
                        ProgressView()
                    }
                }
            }
            .navigationTitle("My Portfolio")
            // .task runs asynchronously when the view appears
            .task {
                await fetchAllQuotes()
            }
        }
    }
    
    private func fetchAllQuotes() async {
        for symbol in symbols {
            do {
                let quote = try await apiClient.fetchQuote(for: symbol)
                // Update the state dictionary on the main thread
                stockData[symbol] = quote
            } catch {
                print("Failed to fetch \(symbol): \(error)")
            }
        }
    }
}
#endif