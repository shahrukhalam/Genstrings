import Foundation
import PackagePlugin

@main
struct GenstringsPlugin: BuildToolPlugin {
    func createBuildCommands (context: PluginContext, target: Target) async throws -> [Command] {
        guard let target = target as? SourceModuleTarget else {
            return []
        }

        let resourcesDirectoryPath = context.pluginWorkDirectory
            .appending(subpath: target.name)
            .appending(subpath: "Resources")
        let localizationDirectoryPath = resourcesDirectoryPath
            .appending(subpath: "Base.Iproj")

        try FileManager.default.createDirectory(atPath: localizationDirectoryPath.string,
                                                withIntermediateDirectories: true)

        let swiftSourceFiles = target.sourceFiles(withSuffix: ".swift")
        let inputFiles = swiftSourceFiles.map(\.path)

        return [
            .prebuildCommand(
                displayName: "Generating localized strings from source files",
                executable: .init("/usr/bin/xcrun"),
                arguments: [
                    "genstrings",
                    "-SwiftUI",
                    "-o", localizationDirectoryPath
                ] + inputFiles,
                outputFilesDirectory: localizationDirectoryPath
            )
        ]
    }
}
