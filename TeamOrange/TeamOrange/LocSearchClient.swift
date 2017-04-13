//
//  LocationSearchDelegate.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/10/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit

final class LocSearchClient: NSObject {
    
    lazy var textField = UITextField()
    lazy var tableView = UITableView()
    var dismiss: ()->() = {}
    fileprivate static var client = LocSearchClient()
    override init(){
        super.init()
    }
    
    class func setFieldAndTable(from view: SearchBarView){
        view.searchBar.delegate = client
        //table.delegate = client
        //table.dataSource = client
        client.textField = view.searchBar
        client.tableView = view.tableView
    }
    
    class func setDismissal(to function: @escaping ()->()){
        client.dismiss = function
    }
}

//extension LocSearchClient:  UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "completionCell", for: indexPath)
//        return cell
//    }
//}

extension LocSearchClient: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text != "" else {
            return false
        }
        CoreLocClient.forwardGeocode(address: text, completion: {placemark in
            DispatchQueue.main.async {
                if let placemark = placemark{
                    //need to figure out stuff to do here, this is just testing purposes for right now
                    MapKitClient.goTo(place: placemark)
                    NSLog("%@", "successfully found Locations")
                } else {
                    //probably throw out an alert view or something...
                    NSLog("%@", "failed to find locations")
                }
            }
        })
        dismiss()
        textField.endEditing(true)
        return true
    }
    
    class func searchReady(){
        print("searchReady")
        _ = client.textFieldShouldReturn(client.textField)
    }
}
