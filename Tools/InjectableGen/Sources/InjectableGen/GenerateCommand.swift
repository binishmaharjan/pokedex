//
//  File.swift
//  
//
//  Created by hirano masaki on 2020/06/04.
//

import Foundation
import SourceKittenFramework
import ArgumentParser

public struct GenerateCommand: ParsableCommand {

    @Argument(help: "path to source root directory")
    public var baseURL: URL
    
    @Option(name: .shortAndLong, help: "exclusive paths")
    public var exclusivePaths: [String]
    
    @Option(name: .shortAndLong, help: "output path for injectable file")
    public var injectableFileURL: URL
    
    @Option(name: .shortAndLong, help: "output path for dummy injectable file")
    public var dummyInjectableFileURL: URL
    
    public init() {
        
    }
    
    public func run() throws {
        let fileLoader = FileLoader(
            directoryURL: baseURL,
            exclusivePaths: exclusivePaths
        )
        
        let files = fileLoader.loadFiles()
        let parsedFiles = try ParsedFile.parsedFiles(from: files)
        let context = Context(parsedFiles: parsedFiles)
        let fileGenerator = FileGenerator(context: context)
        
        let injectableFile = try fileGenerator.generateInjectableFile()
        let dummyInjectableFile = try fileGenerator.generateDummyInjectableFile()
        
        func write(_ file: File, to url: URL) throws {
            try file.contents.write(to: url, atomically: true, encoding: .utf8)
        }
        
        try write(injectableFile, to: injectableFileURL)
        try write(dummyInjectableFile, to: dummyInjectableFileURL)
    }
}

extension URL: ExpressibleByArgument {
    
    public init?(argument: String) {
        self = .init(fileURLWithPath: argument)
    }
}
