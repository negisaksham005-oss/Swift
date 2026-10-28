import Testing
@testable import swift // Ensure this matches your package module name

@Test func testStockFetch() async throws {
    let client = StockAPIClient()
    let quote = try await client.fetchQuote(for: "AAPL") // Apple Inc. ticker
    
    #expect(quote.currentPrice > 0, "Current price should be greater than zero.")
    #expect(quote.highPrice >= quote.lowPrice, "High price must be greater than or equal to low price.")
}

@Test func testPortfolioPersistence() throws {
    let manager = PortfolioManager()
    let testSymbols = ["TSLA", "AMZN", "NVDA"]
    
    // 1. Save the test data
    try manager.save(symbols: testSymbols)
    
    // 2. Load the data back from the disk
    let loadedSymbols = try manager.load()
    
    // 3. Verify the loaded data matches exactly what was saved
    #expect(loadedSymbols == testSymbols, "The loaded symbols should exactly match the saved symbols.")
}