//
//  Bundle+SPM.swift
//  SwiftTweaks
//
//  Created by Jarek Pendowski on 29/06/2021.
//  Copyright © 2021 Khan Academy. All rights reserved.
//

import Foundation

#if !SWIFT_PACKAGE

private class BundleFinder {}

extension Bundle {
	static var module: Bundle {
		return Bundle(for: BundleFinder.self)
	}
}

#endif
