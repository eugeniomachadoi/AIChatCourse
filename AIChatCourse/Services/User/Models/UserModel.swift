import Foundation
import SwiftUI

struct UserModel: Codable {
    let userId: String
    let email: String?
    let isAnonymous: Bool?
    let creationDate: Date?
    let creationVersion: String?
    let lastSignInDate: Date?
    let didCompleteOnboarding: Bool?
    let profileColorHex: String?

    init(
        userId: String,
        email: String? = nil,
        isAnonymous: Bool? = nil,
        creationDate: Date? = nil,
        creationVersion: String? = nil,
        lastSignInDate: Date? = nil,
        didCompleteOnboarding: Bool? = nil,
        profileColorHex: String? = nil
    ) {
        self.userId = userId
        self.email = email
        self.isAnonymous = isAnonymous
        self.creationDate = creationDate
        self.creationVersion = creationVersion
        self.lastSignInDate = lastSignInDate
        self.didCompleteOnboarding = didCompleteOnboarding
        self.profileColorHex = profileColorHex
    }

    init(auth: UserAuthInfo, creationVersion: String?) {
        self.init(
            userId: auth.uid,
            email: auth.email,
            isAnonymous: auth.isAnonymous,
            creationDate: auth.creationDate,
            creationVersion: creationVersion,
            lastSignInDate: auth.lastSignInDate
        )
    }

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email
        case isAnonymous = "is_anonymous"
        case creationDate = "creation_date"
        case creationVersion = "creation_version"
        case lastSignInDate = "last_sign_in_date"
        case didCompleteOnboarding = "did_complete_onboarding"
        case profileColorHex = "profile_color_hex"
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
                creationDate: now,
                didCompleteOnboarding: true,
                profileColorHex: "#33C1FF"
            ),
            UserModel(
                userId: "user_002",
                creationDate: now.addingTimeInterval(days: -1),
                didCompleteOnboarding: false,
                profileColorHex: "#FF5733"
            ),
            UserModel(
                userId: "user_003",
                creationDate: nil,
                didCompleteOnboarding: nil,
                profileColorHex: nil
            ),
            UserModel(
                userId: "user_004",
                creationDate: now.addingTimeInterval(days: -7),
                didCompleteOnboarding: true,
                profileColorHex: "#28A745"
            ),
            UserModel(
                userId: "user_005",
                creationDate: now.addingTimeInterval(days: -365),
                didCompleteOnboarding: false,
                profileColorHex: "#6F42C1"
            )
        ]
    }
}
