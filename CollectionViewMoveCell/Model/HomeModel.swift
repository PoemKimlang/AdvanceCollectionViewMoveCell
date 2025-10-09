//
//  HomeModel.swift
//  CollectionViewMoveCell
//
//  Created by kimlang on 9/4/23.
//

import Foundation

enum HomeRowType {
    case HEADER
    case ACCOUNT
    case QUICK_PAYMENT
}
struct HomeData{
    var rowType         : HomeRowType?
    var header          : [Header]?
    var account         : [Account]?
    var quick_paymnet   : [QuickPayment]?
    
    struct Header{
        var amount      : String?
        var name        : String?
        var hideAmount  : Bool = false 
        var send        : Bool?
        var receive     : Bool?
        var color       : String?
    }
    struct Account {
        var title   : String?
        var icon    : String?
    }
    struct QuickPayment{
        var background  : String?
        var title       : String?
        var icon        : String?
    }
}

