//
//  FeedMapVC+Map.swift
//  wmsy
//
//  Created by C4Q on 3/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps
import SVProgressHUD

extension FeedMapVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let camera = GMSCameraPosition.camera(withLatitude: marker.position.latitude,
                                              longitude: marker.position.longitude,
                                              zoom: 17.0)
        self.mapView.mapView.animate(to: camera)
        let dict = marker.userData as? [String: String]
        let whimTitle = dict!["title"]
        for whim in feedWhims{
            if whim.title == whimTitle{
                self.currentWhim = whim
            }
        }
        let expiration = dict!["expiration"]
        let titleCount  = whimTitle?.count
        let customString = NSMutableAttributedString.init(string: "\(whimTitle!) \(expiration!)", attributes: [NSAttributedStringKey.font:UIFont(name: "Helvetica", size: 18.0)!])
        customString.addAttributes([NSAttributedStringKey.font:UIFont(name: "Helvetica", size: 14.0)!,NSAttributedStringKey.foregroundColor:UIColor.lightGray], range: NSRange(location:titleCount!,length: (expiration?.count)! + 1))
        
        
        
        self.mapView.detailView.whimTitle.attributedText = customString
        self.mapView.detailView.whimDescription.text = dict!["description"]
        let hostURL = URL(string: dict!["hostImageURL"]!)
        let hostID = dict!["hostID"]
        let whimID = dict!["whimID"]
        DBService.manager.getAppUser(fromID: hostID!) { (appUser) in
            self.currentUser = appUser
        }
        self.mapView.detailView.userPicture.kf.setImage(with: hostURL, for: .normal, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cache, url) in
            self.mapView.detailView.userPicture.imageView?.setNeedsDisplay()
            let interests = self.getInterestKeys(appUser: AppUser.currentAppUser!)
            if interests.contains(whimID!){
//                self.mapView.detailView.interestedButton.setImage(#imageLiteral(resourceName: "interestedCircleIcon"), for: .normal)
                self.mapView.detailView.interestedButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8)
                self.mapView.detailView.interestedButton.setTitle("Remove Interest", for: .normal)
                self.mapView.detailView.interestedButton.titleLabel?.textColor = .white
            }else{
//                self.mapView.detailView.interestedButton.setImage(#imageLiteral(resourceName: "uninterestedCircleIcon"), for: .normal)
                self.mapView.detailView.interestedButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.3)
                self.mapView.detailView.interestedButton.setTitle("Show Interest", for: .normal)
                self.mapView.detailView.interestedButton.titleLabel?.textColor = .white
            }
            
            self.mapView.detailView.isHidden = false
            
        }
        return true
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.mapView.detailView.isHidden = true
    }
}

extension FeedMapVC: CLLocationManagerDelegate{
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        self.userLocation = location
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}

extension FeedMapVC: mapDetailViewDelegate {
    func interestPressed() {
        print("interest is being pressed")
        let interests = getInterestKeys(appUser: AppUser.currentAppUser!)
        if interests.contains(currentWhim!.id){
            //User is no longer interested
            print("Current User: \(currentUser?.name ?? "No current user") Is NOT Interested in Whim #: \(currentWhim?.id) by Host: \(currentWhim?.hostID)")
            DBService.manager.removeInterest(forWhim: currentWhim!, forUser: AppUser.currentAppUser!)
//            self.mapView.detailView.interestedButton.setImage(#imageLiteral(resourceName: "uninterestedCircleIcon"), for: .normal)

            
            self.mapView.detailView.interestedButton.titleLabel?.textColor = .white
            self.mapView.detailView.interestedButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.3)
            self.mapView.detailView.interestedButton.setTitle("Show Interest", for: .normal)
            self.feedView.tableView.reloadData()
            
        } else {
            //User is now interested
            print("Current User: \(currentUser?.name ?? "No current user") is Interested in Whim #: \(currentWhim?.id) by Host: \(currentWhim?.hostID)")
            DBService.manager.addInterest(forWhim: currentWhim!)
//            self.mapView.detailView.interestedButton.setImage(#imageLiteral(resourceName: "interestedCircleIcon"), for: .normal)
            self.mapView.detailView.interestedButton.titleLabel?.textColor = .white
            self.mapView.detailView.interestedButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8)
            self.mapView.detailView.interestedButton.setTitle("Remove Interest", for: .normal)
            
            
            self.feedView.tableView.reloadData()
        }
    }
    
    func userPicturePressed() {
        hostProfileView.modalTransitionStyle = .crossDissolve
        hostProfileView.modalPresentationStyle = .overCurrentContext
        tabBarController?.present(hostProfileView, animated: false, completion: nil)
//        present(GuestProfileVC(), animated: true, completion: nil)
        hostProfileView.profileView.nameLabel.text = currentUser?.name
        hostProfileView.profileView.bioLabel.text = currentUser?.bio
        let url = URL(string: (currentUser?.photoID)!)
        hostProfileView.profileView.profileImageView.kf.setImage(with: url)
}
}
