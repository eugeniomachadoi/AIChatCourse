import Foundation
import SwiftUI

struct UserModel {
    let userId: String
    let dateCreated: Date?
    let didCompleteOnboarding: Bool?
    let profileColorHex: String?

    init(
        userId: String,
        dateCreated: Date?,
        didCompleteOnboarding: Bool?,
        profileColorHex: String?
    ) {
        self.userId = userId
        self.dateCreated = dateCreated
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }

    var profileColorCalculated: Color {
        guard let profileColorHex else {
            return .accent
        }

        return Color(hex: profileColorHex)
    }

    static var mock: Self {
        mocks[0]
    }

    static var mocks: [Self] {
        let now = Date()
        return [
            UserModel(
                userId: "1",
                dateCreated: now,
                didCompleteOnboarding: true,
                profileColorHex: "#33C1FF"
            ),
            UserModel(
                userId: "user_002",
                dateCreated: now.addingTimeInterval(days: -1),
                didCompleteOnboarding: false,
                profileColorHex: "#FF5733"
            ),
            UserModel(
                userId: "user_003",
                dateCreated: nil,
                didCompleteOnboarding: nil,
                profileColorHex: nil
            ),
            UserModel(
                userId: "user_004",
                dateCreated: now.addingTimeInterval(days: -7),
                didCompleteOnboarding: true,
                profileColorHex: "#28A745"
            ),
            UserModel(
                userId: "user_005",
                dateCreated: now.addingTimeInterval(days: -365),
                didCompleteOnboarding: false,
                profileColorHex: "#6F42C1"
            )
        ]
    }
}
