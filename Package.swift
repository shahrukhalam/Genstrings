// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Genstrings",
    products: [
        .library(
            name: "Genstrings",
            targets: ["Genstrings"]
        ),
    ],
    targets: [
        .target(
            name: "Genstrings",
            plugins: [
                "GenstringsPlugin"
            ]
        ),
        .plugin(
            name: "GenstringsPlugin",
            capability: .buildTool()
        )
    ]
)
