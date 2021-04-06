//
//  Logger.swift
//  Pokedex
//
//  Created by Maharjan Binish on 2021/04/04.
//

import UIKit
import SwiftyBeaver

enum Logger {
    
    static func setup() {
        guard SHOWLOG else {
            print("[Logger] Log is disabled, since the PokeApi logs are extremely large and takes long time to display blocking the thread.")
            return
        }
        
        #if API_DEVELOPMENT
        SwiftyBeaver.addDestination(makeDevelopConsoleDestination())
//        SwiftyBeaver.addDestination(FileDestination(logFileURL: .log))
        UIViewController.logDeinit()
        #endif
    }
    
    static func verbose(_ message: @autoclosure () -> Any, file: String = #file, function: String = #function, line: Int = #line) {
        SwiftyBeaver.verbose(message(), file, function, line: line, context: nil)
    }

    static func debug(_ message: @autoclosure () -> Any, file: String = #file, function: String = #function, line: Int = #line) {
        SwiftyBeaver.debug(message(), file, function, line: line, context: nil)
    }

    static func info(_ message: @autoclosure () -> Any, file: String = #file, function: String = #function, line: Int = #line) {
        SwiftyBeaver.info(message(), file, function, line: line, context: nil)
    }

    static func warning(_ message: @autoclosure () -> Any, file: String = #file, function: String = #function, line: Int = #line) {
        SwiftyBeaver.warning(message(), file, function, line: line, context: nil)
    }

    static func error(_ message: @autoclosure () -> Any, file: String = #file, function: String = #function, line: Int = #line) {
        SwiftyBeaver.error(message(), file, function, line: line, context: nil)
    }

    static func `deinit`(_ object: Any, file: String = #file, function: String = #function, line: Int = #line) {
        SwiftyBeaver.debug("🗑 deinit - \(object)", file, function, line: line, context: nil)
    }
}

private extension Logger {
    
    /// 開発用のログ出力先
    static func makeDevelopConsoleDestination() -> ConsoleDestination {
        let destination = ConsoleDestination()
        
        destination.levelColor.verbose = "👉🏼"
        destination.levelColor.debug = "🤖"
        destination.levelColor.info = "🚀"
        destination.levelColor.warning = "⚠️"
        destination.levelColor.error = "💀"
        
        return destination
    }
}

#if API_DEVELOPMENT
import ReactiveCocoa

private extension UIViewController {
    
    /// deinit 時にログを出力する。DEBUG時のみ呼び出すこと！
    static func logDeinit() {
        guard let source = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.viewDidLoad)),
            let target = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.swizzled_viewDidLoad)) else {
                return
        }
        
        method_exchangeImplementations(source, target)
    }
    
    @objc private func swizzled_viewDidLoad() {
        swizzled_viewDidLoad()
        
        let className = String(describing: type(of: self))
        reactive.lifetime.observeEnded {
            Logger.deinit(className)
        }
    }
}
#endif
