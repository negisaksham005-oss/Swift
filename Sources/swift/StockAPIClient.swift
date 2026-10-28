import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class StockAPIClient {
    // ... rest of your code stays exactly the same ...
    // Note: In production, API keys should be stored securely, not hardcoded.
   private let apiKey = "dbb2p9hr01qrv06o2a30dbb2p9hr01qrv06o2a3g" // Replace this text with your actual key
    private let baseURL = "https://finnhub.io/api/v1"
    
    func fetchQuote(for symbol: String) async throws -> StockQuote {
        let urlString = "\(baseURL)/quote?symbol=\(symbol.uppercased())&token=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(StockQuote.self, from: data)
    }
}