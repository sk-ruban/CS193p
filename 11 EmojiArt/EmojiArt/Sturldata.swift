//
//  Sturldata.swift
//  Emoji Art
//
//  Created by CS193p Instructor on 5/8/23.
//  Copyright (c) 2023 Stanford University
//

import CoreTransferable

// a type which represents either a String, a URL or a Data
// it implements Transferable by proxy

enum Sturldata: Transferable {
    case string(String)
    case url(URL)
    case data(Data)
    
    init(url: URL) {
        // some URLs have the data for an image directly embedded in the URL itself
        // (i.e. they are NOT a REFERENCE to the data somewhere else like most are)
        // these sorts of URLs are called "data scheme" URLs
        // (they will have "image/jpeg" or some such as the mime type)
        if let imageData = url.dataSchemeImageData {
            self = .data(imageData)
        } else {
            self = .url(url.imageURL)
        }
    }
    
    init(string: String) {
        // if the string looks like a URL, we're treat it like one
        if string.hasPrefix("http"), let url = URL(string: string) {
            self = .url(url.imageURL)
        } else {
            self = .string(string)
        }
    }

    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation { Sturldata(string: $0) }
        ProxyRepresentation { Sturldata(url: $0) }
        ProxyRepresentation { Sturldata.data($0) }
    }
}

// the extensions below are just helpers for Sturldata

extension URL {
    // some search engines give out a url which has yet another reference to the actual image url embedded in it
    // (e.g. https://searchresult.searchengine.com?imgurl=https://actualimageurl.jpg)
    // this property returns the first embedded url it finds (if any)
    // if there is no embedded url, it returns self
    
    var imageURL: URL {
        if let queryItems = URLComponents(url: self, resolvingAgainstBaseURL: true)?.queryItems {
            for queryItem in queryItems {
                if let value = queryItem.value, value.hasPrefix("http"), let imgurl = URL(string: value) {
                    return imgurl
                }
            }
        }
        return self
    }

    // returns the image data for data scheme url (if applicable)
    // for example, "data:image/jpeg;base64,<base 64 encoded image data>"
    // (this is as opposed to, for example, "https://stanford.edu/image.jpg")
    // images are rarely passed around using data schemes
    // it generally only makes sense for small images (thumbnails, etc.)
    
    var dataSchemeImageData: Data? {
        let urlString = absoluteString
        // is this a data scheme url with some sort of image as the mime type?
        if urlString.hasPrefix("data:image") {
            // yes, find the comma that separates the meta info from the image data
            if let comma = urlString.firstIndex(of: ","), comma < urlString.endIndex {
                let meta = urlString[..<comma]
                // we can only handle base64 encoded data
                if meta.hasSuffix("base64") {
                    let data = String(urlString.suffix(after: comma))
                    // get the data
                    if let imageData = Data(base64Encoded: data) {
                        return imageData
                    }
                }
            }
        }
        // not a data scheme or the data doesn't seem to be a base64 encoded image
        return nil
    }
}

extension Collection {
    // this will crash if after >= endIndex
    func suffix(after: Self.Index) -> Self.SubSequence {
        suffix(from: index(after: after))
    }
}
