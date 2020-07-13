//
//  Service.swift
//  HS-APP
//
//  Created by Samuel Esserman on 5/18/20.
//  Copyright © 2020 Samuel Esserman. All rights reserved.
//

import Foundation
import Firebase

let consumer_key        = "ck_a59843c0c56ae3d4acf2d8e9ce3c740568dd19aa"
let consumer_secret     = "cs_02564886f33dd0aacc1fbd787e324cc2c77e7291"
let baseURL             = "https://www.highseas-store.com/wp-json/wc/v3"
let auth                = "?consumer_key=\(consumer_key)&consumer_secret=\(consumer_secret)"


class Service {
    
    static let shared = Service() //Singleton
    let db            = Firestore.firestore()
    
    func fetchGallery(handler: @escaping ([GalleryItem]?, Error?) -> ()) {
        db.collection("gallery").getDocuments { (queryShot, err) in
            if let err = err {
                handler(nil, err)
            } else {
                var items = [GalleryItem]()
                for document in queryShot!.documents {
                    let data = document.data()
                    let imageUrl = data["imageUrl"] as? String ?? ""
                    let title = data["title"] as? String ?? ""
                    
                    let item = GalleryItem(title: title, imageUrl: imageUrl)
                    items.append(item)
                }
                handler(items, nil)
            }
        }
    }
    
    
    func fetchAllProducts(searchTerm: String, handler: @escaping ([Product]?, Error?) -> ()) {
        let searchURL = baseURL + "/products" + "&search=\(searchTerm)" + auth
        fetchGenericJSONData(urlString: searchURL, completion: handler)
    }
    
    
    func fetchAllProducts(handler: @escaping ([Product]?, Error?) -> ()) {
        let productsURL = baseURL + "/products" + auth
        fetchGenericJSONData(urlString: productsURL, completion: handler)
    }
    

    func fetchProductByID(id: Int, handler: @escaping (Product?, Error?) -> ()) {
        let url = baseURL + "/products/" + String(id) + auth
        fetchGenericJSONData(urlString: url, completion: handler)
    }
    
    
    
    // delcare my generic json function here
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        
        print("T is type", T.self)
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                //success
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
        } .resume()
    }
}

// Stack
// Generic is to delcare the Type later on

class Stack<T: Decodable> {
    var items = [T]()
    func push(item: T) { items.append(item) }
    func pop() -> T? { return items.last }
}
