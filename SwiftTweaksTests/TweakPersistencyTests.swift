//
//  TweakPersistencyTests.swift
//  SwiftTweaksTests
//
//  Created by Jarek Pendowski on 14/06/2021.
//  Copyright © 2021 Khan Academy. All rights reserved.
//

import XCTest
@testable import SwiftTweaks

class TweakPersistencyTests: XCTestCase {
	
	struct TestTweak: TweakIdentifiable {
		var persistenceIdentifier: String
		var value: Int
	}

    func testPersistency() throws {
		let identifier = "abc"
		let persistency = TweakPersistency(identifier: identifier)
		
		let expectWrite = expectation(description: "writes to disk asynchronously")
		let randomValue = (0...42).randomElement() ?? 42
		
		let tweak = TestTweak(persistenceIdentifier: "integerValue", value: randomValue)
		persistency.setValue(tweak.value, forTweakIdentifiable: tweak)
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			expectWrite.fulfill()
		}
		waitForExpectations(timeout: 0.25, handler: nil)
		
		let persistencyReader = TweakPersistency(identifier: identifier)
		guard let readValue = persistencyReader.persistedValueForTweakIdentifiable(tweak) as? Int else {
			return XCTFail()
		}
		XCTAssertEqual(readValue, randomValue)
    }


}
