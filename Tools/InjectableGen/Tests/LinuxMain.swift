import XCTest

import InjectableGenTests

var tests = [XCTestCaseEntry]()
tests += InjectableGenTests.allTests()
XCTMain(tests)
