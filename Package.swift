// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "WhatsForLunch",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0-rc.2"),
        
        // A framework for parsing HTML
        .package(url: "https://github.com/Enari/SwiftSoup.git", from: "1.5.10"),
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "SwiftSoup"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

