//
//  ATHMPaymentRequestIT.swift
//  athmovil_checkoutIntegrationTests
//
//  Created by Hansy on 12/22/20.
//  Copyright © 2020 Evertec. All rights reserved.
//

import Foundation
import XCTest
@testable import athmovil_checkout

class ATHMPaymentRequestIT: XCTestCase {
    

    //MARK:- Negative
    
    func testWhenPay_GivenPaymentWithNegativeTotal_ThenCancelRequestTheRequestAndCallOnException() {
        let requetPayment = ATHMPaymentRequest(account: "test",
                                               scheme: "test",
                                               payment: -1.0)
        
        let handler = ATHMPaymentHandler(onCompleted: { _ in
            XCTAssert(false)
        }, onExpired: { (response) in
            XCTAssert(false)
        }, onCancelled: { (response: ATHMPaymentResponse) in
            XCTAssert(false)
        }) { error in
            XCTAssert(true)
        }
    
        requetPayment.pay(handler: handler)
    }
    
    func testWhenPaySimulated_GivenDummyTokenWithNegativeTotal_ThenCancelRequestTheRequestAndCallOnException() {
        let requetPayment = ATHMPaymentRequest(account: "dummy",
                                               scheme: "test",
                                               payment: -1.0)
        
        let handler = ATHMPaymentHandler(onCompleted: { _ in
            XCTAssert(false)
        }, onExpired: { (response) in
            XCTAssert(false)
        }, onCancelled: { (response: ATHMPaymentResponse) in
            XCTAssert(false)
        }) { error in
            XCTAssert(true)
        }
        
        requetPayment.pay(handler: handler)
    }
    
    func testWhenPay_GivenPaymentRequestWithNegativeTotalInDictionary_ThenCancelRequestTheRequestAndCallOnException() {
        let negativeTotalDic = NSDictionary(dictionary: ["total" : -20.0])
        let requestPayment = ATHMPaymentRequest(account: ATHMBusinessAccount(dictionary: NSDictionary(dictionary: ["token": "test"])),
                                                scheme: ATHMURLScheme(dictionary: NSDictionary(dictionary: ["urlScheme": "test"])),
                                                payment: ATHMPayment(dictionary: negativeTotalDic))
        
        let handler = ATHMPaymentHandlerDictionary(onCompleted: { _ in
            XCTAssert(false)
        }, onExpired: { (response) in
            XCTAssert(false)
        }, onCancelled: { (response: NSDictionary) in
            XCTAssert(false)
        }) { error in
            XCTAssert(true)
        }
                
        requestPayment.pay(dictionaryHandler: handler)
    }
    
    func testWhenPaySimulated_GivenDummyTokenWithNegativeTotalInDictionary_ThenCancelRequestTheRequestAndCallOnException() {
        let negativeTotalDic = NSDictionary(dictionary: ["total" : -20.0])
        let requestPayment = ATHMPaymentRequest(account: ATHMBusinessAccount(dictionary: NSDictionary(dictionary: ["token": "dummy"])),
                                                scheme: ATHMURLScheme(dictionary: NSDictionary(dictionary: ["urlScheme": "test"])),
                                                payment: ATHMPayment(dictionary: negativeTotalDic))
        
        let handler = ATHMPaymentHandlerDictionary(onCompleted: { _ in
            XCTAssert(false)
        }, onExpired: { (response) in
            XCTAssert(false)
        }, onCancelled: { (response: NSDictionary) in
            XCTAssert(false)
        }) { error in
            XCTAssert(true)
        }
        
        requestPayment.pay(dictionaryHandler: handler)
    }
    

    //MARK:- Boundary

    func testWhenPay_GivenPaymentRequestWithEmptyDictionary_ThenCancelRequestTheRequestAndCallOnException() {
        let emptyDic = NSDictionary(dictionary: ["" : ""])
        let requestPayment = ATHMPaymentRequest(account: ATHMBusinessAccount(dictionary: NSDictionary(dictionary: emptyDic)),
                                                scheme: ATHMURLScheme(dictionary: NSDictionary(dictionary: emptyDic)),
                                                payment: ATHMPayment(dictionary: emptyDic))
        
        let handler = ATHMPaymentHandlerDictionary(onCompleted: { _ in
            XCTAssert(false)
        }, onExpired: { (response) in
            XCTAssert(false)
        }, onCancelled: { (response: NSDictionary) in
            XCTAssert(false)
        }) { error in
            XCTAssert(true)
        }
        
        requestPayment.pay(dictionaryHandler: handler)
    }
    
}

