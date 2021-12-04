// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CrowdinSDK",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(name: "CrowdinSDK", targets: ["CrowdinCore", "CrowdinProvider"])
    ],
    dependencies: [
        .package(url: "https://github.com/serhii-londar/BaseAPI.git", .upToNextMajor(from: "0.2.0")),
        .package(url: "https://github.com/daltoniam/Starscream.git", .upToNextMajor(from: "3.1.0"))
    ],
    targets: [
        .target(name: "CrowdinCore",
                path: "Sources/CrowdinSDK/CrowdinCore",
                exclude: [
//                    "Providers",
//                    "Settings",
//                    "Features",
//                    "CrowdinAPI"
                ],
                resources: [
//                    .process("Resources/Settings/CrowdinLogsVC.storyboard"),
//                    .process("Resources/Settings/Images.xcassets"),
//                    .process("Resources/Settings/SettingsItemCell.xib"),
//                    .process("Resources/Settings/SettingsView.xib")
                ],
                swiftSettings: [
                    .define("CrowdinSDKSPM")
                ]),
        .target(name: "CrowdinProvider",
                dependencies: [
                    "CrowdinCore",
                    "CrowdinAPI"
                ],
                path: "Sources/CrowdinSDK/Providers/Crowdin",
                swiftSettings: [
                    .define("CrowdinSDKSPM")
                ]),
        .target(name: "CrowdinAPI",
                dependencies: [
                    "CrowdinCore",
                    "BaseAPI",
                    "Starscream",
                ],
                path: "Sources/CrowdinSDK/CrowdinAPI",
                swiftSettings: [
                    .define("CrowdinSDKSPM")
                ]),
        .target(name: "CrowdinLogin",
                dependencies: [
                    "CrowdinCore",
                    "CrowdinProvider",
                    "CrowdinAPI",
                    "BaseAPI",
                ],
                path: "Sources/CrowdinSDK/Features/CrowdinLogin",
                swiftSettings: [
                    .define("CrowdinSDKSPM")
                ]),
    ]
)
