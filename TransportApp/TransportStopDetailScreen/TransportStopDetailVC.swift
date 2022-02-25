//
//  TrasportStopDetailVC.swift
//  TransportApp
//
//  Created by Maximus on 24.02.2022.
//

import Foundation
import UIKit


class TransportStopDetailVC: ResizableViewController {
    
    var transportStopDetail: TransportStopDetail?
    
    let stopNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
       
        return label
    }()
    
    let realTimeForecastText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        label.text = "Real-time forecast"
        return label
    }()
    
    let showScheduleButton: UIButton = {
       let button = UIButton()
        button.setTitle("Show schedule", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(handleScheduleButtonTap), for: .touchUpInside)
        return button
    }()
    
    var lineView: UIView!
    
   
    var vm: TransportStopDetailViewModelProtocol?
    
    var transportNumbersStackView: UIStackView!
    
     init(initialHeight: CGFloat, viewModel: TransportStopDetailViewModelProtocol?) {
        self.vm = viewModel
        super.init(initialHeight: initialHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stopNameLabel)
        stopNameLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopNameLabel.text = vm?.transportStopName
        vm?.getData()
        stopNameLabel.layoutIfNeeded()
        initTransportNumberStackView()
        initRealTimeForecastText()
        initHorizontalButtonStackView()
        verticalStackView()
    }
    
    
    @objc fileprivate func handleScheduleButtonTap() {
        print("Handle schedule")
    }
    
    //разделить на более мелкие методы
    fileprivate func initTransportNumberStackView() {
        transportNumbersStackView = UIStackView()
        view.addSubview(transportNumbersStackView)
        transportNumbersStackView?.axis = .horizontal
        transportNumbersStackView?.distribution = .fillEqually
        transportNumbersStackView.spacing = 10
        transportNumbersStackView.anchor(top: stopNameLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 16, bottom: 0, right: 0))
        
        let timeHorizontalStackView = UIStackView()
        view.addSubview(timeHorizontalStackView)
        timeHorizontalStackView.axis = .horizontal
        timeHorizontalStackView.distribution = .fillEqually
        timeHorizontalStackView.spacing = 10
        timeHorizontalStackView.alignment = .center
        timeHorizontalStackView.anchor(top: transportNumbersStackView.bottomAnchor, leading: transportNumbersStackView.leadingAnchor, bottom: nil, trailing: transportNumbersStackView.trailingAnchor, padding: .init(top: 4, left: 16, bottom: 0, right: 0))
        
        guard let count = vm?.transportArray else { return }
        for tag in count {
            let button = UIButton()
            button.setTitle(tag.number, for: .normal)
            button.setTitleColor(UIColor().colorWithHexString(hex: tag.fontColor), for: .normal)
            button.backgroundColor = UIColor().colorWithHexString(hex: tag.color)
            button.layer.cornerRadius = 6
            transportNumbersStackView?.addArrangedSubview(button)
            timeHorizontalStackView.addArrangedSubview( initTimeLabel( tag.timeArrival.first ?? ""))
        }
    }
    
    fileprivate func initTimeLabel(_ text: String?) -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.text = text
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        return label
    }
    
    fileprivate func initRealTimeForecastText() {
        view.addSubview(realTimeForecastText)
        realTimeForecastText.anchor(top: transportNumbersStackView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
    }
    
    fileprivate func initScheduleButton() {
        view.addSubview(showScheduleButton)
        showScheduleButton.anchor(top: lineView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
    }
    
    
    let shareButton: CustomButton = {
       let button = CustomButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.setTitle("Share", for: .normal)
        button.addTarget(self, action: #selector(handleShareButtonTap), for: .touchUpInside)
        return button
    }()
    
    let favoriteButton: CustomButton = {
       let button = CustomButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setTitle("Favorite", for: .normal)
        button.addTarget(self, action: #selector(handleFavoriteButtonTap), for: .touchUpInside)
        return button
    }()
    
    let routeButton: CustomButton = {
       let button = CustomButton()
        button.setImage(UIImage(systemName: "chart.line.uptrend.xyaxis"), for: .normal)
        button.setTitle("Route", for: .normal)
        button.addTarget(self, action: #selector(handleRouteButtonTap), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleShareButtonTap() {
        
    }
   
    @objc fileprivate func handleFavoriteButtonTap() {
        
    }
   
    @objc fileprivate func handleRouteButtonTap() {
        
    }
   
    
    fileprivate var horizontalButtonStackView: UIStackView!
    
    fileprivate func initHorizontalButtonStackView() {
        horizontalButtonStackView = UIStackView(arrangedSubviews: [shareButton, favoriteButton, routeButton])
        horizontalButtonStackView.axis = .horizontal
        horizontalButtonStackView.distribution = .fillEqually
    }
    
    fileprivate func verticalStackView() {
        let line1 = LineView(frame: .zero)
        let line2 = LineView(frame: .zero)
        let line3 = LineView(frame: .zero)
        let stackView = UIStackView(arrangedSubviews: [line1, showScheduleButton, line2, horizontalButtonStackView, line3])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: realTimeForecastText.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
}
