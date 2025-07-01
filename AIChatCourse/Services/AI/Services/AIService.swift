protocol AIService: Sendable {
    func generateImage(input: String) async throws -> UIImage
}
