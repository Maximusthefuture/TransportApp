//
//  DetailMapViewController.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import UIKit
import MapboxMaps

class DetailMapViewController: UIViewController {

    var mapView: MapView!
    var vm: DetailMapViewModel?
    var network: NetworkProtocol?
    var transportStopId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMap() 
        initViewModel()
        getStopLocation()
    }
    
    fileprivate func getStopLocation() {
        vm?.getTransportStopDetailInfo()
        vm?.transportStopLocation = { lat, lon in
            print("lat", lat)
            print("lon", lon)
            let coordinate = CLLocationCoordinate2D(latitude: lat ?? 0.0, longitude: lon ?? 0.0)
            var pointAnnotation = PointAnnotation(coordinate: coordinate)
            pointAnnotation.image = .init(image: UIImage(named: "red_pin")!, name: "red_pin")
            pointAnnotation.iconAnchor = .bottom
            let pointAnnotationManager = self.mapView.annotations.makePointAnnotationManager()
            pointAnnotationManager.annotations = [pointAnnotation]
            let cameraOption = CameraOptions(center: coordinate, zoom: 15.5)
            self.mapView.mapboxMap.setCamera(to: cameraOption)
        }
    }
    
   
    
    fileprivate func initMap() {
        let myResourceOptions = ResourceOptions(accessToken: "pk.eyJ1IjoibWF4aW11czMwIiwiYSI6ImNsMDEyMmVnODAxbTYzY3BsMThtb25ucnAifQ.voHNtVSe0EvVL_otfnxy1g")
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions)
        mapView = MapView(frame: view.bounds, mapInitOptions: myMapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
    }
    
    fileprivate func initViewModel() {
       vm = DetailMapViewModel(transportStopId: transportStopId ?? "", network: network)
    }
    

}
