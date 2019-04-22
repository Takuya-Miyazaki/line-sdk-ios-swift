//
//  ShareControllerTests.swift
//
//  Copyright (c) 2016-present, LINE Corporation. All rights reserved.
//
//  You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
//  copy and distribute this software in source code or binary form for use
//  in connection with the web services and APIs provided by LINE Corporation.
//
//  As with any software that integrates with the LINE Corporation platform, your use of this software
//  is subject to the LINE Developers Agreement [http://terms2.line.me/LINE_Developers_Agreement].
//  This copyright notice shall be included in all copies or substantial portions of the software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import XCTest
@testable import LineSDK

class ShareControllerTests: XCTestCase {

    func testLocalAuthorizationStatus() {

        let status1 = ShareViewController
            .localAuthorizationStatusForSendingMessage(permissions: [])
        guard case .lackOfPermissions(let p1) = status1 else {
            XCTFail()
            return
        }
        XCTAssertEqual(p1, [.friends, .groups, .messageWrite])

        let status2 = ShareViewController
            .localAuthorizationStatusForSendingMessage(permissions: [.friends])
        guard case .lackOfPermissions(let p2) = status2 else {
            XCTFail()
            return
        }
        XCTAssertEqual(p2, [.groups, .messageWrite])

        let status3 = ShareViewController
            .localAuthorizationStatusForSendingMessage(permissions: [.friends, .groups, .messageWrite])
        guard case .authorized = status3 else {
            XCTFail()
            return
        }
    }

    func testNoTokenStatus() {
        LoginManager.shared.setup(channelID: "123", universalLinkURL: nil)
        defer { LoginManager.shared.reset() }

        let status = ShareViewController
            .localAuthorizationStatusForSendingMessage()
        guard case .lackOfToken = status else {
            XCTFail()
            return
        }
    }
}
