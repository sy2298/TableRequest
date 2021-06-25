//
//  Dummy.swift
//  TableRequest
//
//  Created by 이서영 on 2021/06/24.
//

import Foundation

struct Dummy : Codable{
    let results : [Result]
}
struct Result : Codable{
    let name : Name?
    let email : String?
    let picture : Picture?
}
struct Name: Codable{
    let title: String?
    let first: String?
    let last: String?
}
struct Picture:Codable{
    let large : String?
    let medium : String?
    let thumbnail : String?
}
