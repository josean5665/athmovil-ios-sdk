//
//  PaymentStatusCodable.swift
//  athmovil-checkout
//
//  Created by Hansy Enrique on 7/30/20.
//  Copyright © 2020 Evertec. All rights reserved.
//

import Foundation


protocol PaymentStatusCodable: Codable {

}

struct PaymentStatusCoder: PaymentStatusCodable  {
    
    let version = "", status = "", date = "", referenceNumber = "", dailyTransactionID = ""
    
    let statusPayment: ATHMPaymentStatus

    fileprivate enum CodingKeys: String, CodingKey{
        case version, status, date, referenceNumber, dailyTransactionID
    }
}



extension PaymentStatusCoder{
    
    init(from decoder: Decoder) throws{
        
        do {
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let version: ATHMVersion? = try? container.decodeIfPresent(ATHMVersion.self, forKey: .version) ?? nil
            
            let date: Date = container.decodeValueDefault(forKey: .date)
            
            switch version {
            case nil:
                
                let previousResponse = try ATHMResponseDeprecated(from: decoder)
                let dayliId = previousResponse.dailyTransactionId?.clearAsNumber() ?? "0"
                let numberDayliId = Int(dayliId) ?? 0
                
                statusPayment = ATHMPaymentStatus(reference: previousResponse.transactionReference ?? "",
                                                  dayliId: numberDayliId,
                                                  date: date,
                                                  status: previousResponse.convertToCurrentStatus())
                
            default:
                
                let status: ATHMStatus = container.decodeValueDefault(forKey: .status)
                let dayliId: Int = container.decodeValueDefault(forKey: .dailyTransactionID)
                let reference: String = container.decodeValueDefault(forKey: .referenceNumber)
                
                statusPayment = ATHMPaymentStatus(reference: reference,
                                                  dayliId: abs(dayliId),
                                                  date: date,
                                                  status: status)
            }
            
            statusPayment.version = version

        
        }catch let exception as NSError{
            let message = exception.debugDescription
            let castException = ATHMPaymentError(message: "There was an error while decode PaymentStatus. Detail: \(message)",
                                                 source: .response)
            throw castException
        }

    }
}
