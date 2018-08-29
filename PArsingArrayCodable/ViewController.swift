//
//  ViewController.swift
//  PArsingArrayCodable
//
//  Created by Samvidya Edutech LLP on 29/08/18.
//  Copyright © 2018 Samvidya Edutech LLP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
     let url = URL(string:"https://api.androidhive.info/contacts/")

    override func viewDidLoad() {
        super.viewDidLoad()


       //  To read values from URLs:

        URLSession.shared.dataTask(with: url!) { (data, response
            , error) in
            
            guard let data = data else{return}
            do{
                let decoder = JSONDecoder()
                let gitData = try decoder.decode(Contacts.self, from: data)

                for i in gitData.contacts! {
                     print(i.name!)
                    print(i.email!)
                    print(i.gender!)
                    print(i.address!)
                    print(i.phone!.home?.rawValue ?? "")
                    print(i.phone!.mobile?.rawValue ?? "")
                    print(i.phone!.office?.rawValue ?? "")
                }
                
             
            }catch let err {
                print("Err", err)
            }
            
            }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class Contacts: Codable {
    let contacts: [Contact]?
    
    init(contacts: [Contact]?) {
        self.contacts = contacts
    }
}

class Contact: Codable {
    let id, name, email: String?
    let address: Address?
    let gender: Gender?
    let phone: Phone?
    
    init(id: String?, name: String?, email: String?, address: Address?, gender: Gender?, phone: Phone?) {
        self.id = id
        self.name = name
        self.email = email
        self.address = address
        self.gender = gender
        self.phone = phone
    }
}

enum Address: String, Codable {
    case xxXxXxxxXStreetXCountry = "xx-xx-xxxx,x - street, x - country"
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

class Phone: Codable {
    let mobile: Mobile?
    let home, office: Home?
    
    init(mobile: Mobile?, home: Home?, office: Home?) {
        self.mobile = mobile
        self.home = home
        self.office = office
    }
}

enum Home: String, Codable {
    case the00000000 = "00 000000"
}

enum Mobile: String, Codable {
    case the910000000000 = "+91 0000000000"
}
func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func contactsTask(with url: URL, completionHandler: @escaping (Contacts?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
