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
    var vm: DetailMapViewModelProtocol?
    var detailVC: TransportStopDetailVC!
    var transportStopDetail: TransportStopDetail?
    let diContainer = DependencyContainer.shared()
    
    let button: UIButton = {
       let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 40
        return button
    }()
    
    init(viewModel: DetailMapViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.vm = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMap()
        getStopLocation()
        button.centerInSuperview()
        passTransportData()
   
    }
   
    fileprivate func passTransportData() {
        vm?.getTransportStopData = { detail in
            self.transportStopDetail = detail
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
                self.detailVC = TransportStopDetailVC(initialHeight: 300 , viewModel: self.diContainer.makeTransportStopDetailViewModel(transportStopDetail: detail))
                self.addChild(self.detailVC!)
                self.detailVC?.didMove(toParent: self)
                self.mapView.addSubview(self.detailVC!.view)
                self.detailVC?.view.anchor(top: nil, leading: self.mapView.leadingAnchor, bottom: self.mapView.bottomAnchor, trailing: self.mapView.trailingAnchor, size: .init(width: 0, height: 300))
                self.detailVC.view.layer.cornerRadius = 10
                self.detailVC.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePan)))
            }
        }
    }
    
    @objc func handlePan(_ panGesture: UIPanGestureRecognizer) {
        let translationY = panGesture.translation(in: detailVC.view).y
        detailVC.view.transform = CGAffineTransform.init(translationX: 0, y: translationY)
        print(translationY)
        
        if translationY < 0 {
            detailVC.view.transform = .identity
        }
        
        if translationY >= 160.3 {
            navigationController?.popViewController(animated: true)
//            let vc = diContainer.makeTransportStopListVC()
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true)
        }
    }
    
    fileprivate func getStopLocation() {
        vm?.getTransportStopDetailInfo()
        vm?.transportStopLocation = { lat, lon in
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        vm?.saveLocationToUserDefaults()
    }
}
