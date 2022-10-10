//
//  ViewController.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/09/20.
//

import UIKit
import CoreLocation
import NMapsMap
import SnapKit

final class HomeViewController: UIViewController {
    enum Size {
        static let contentInset: CGFloat = (UIScreen.main.bounds.width - HomeStoreCell.itemSize.width) / 2
        static let minimumInterItem: CGFloat = 10
        static let layoutInset: CGFloat = 24
    }    
    
    private let getAllStoresUseCase: GetAllStoresUseCase = GetAllStoresUseCase()
    private let locationManager = LocationManager.shared
    private var markers: [NMFMarker] = []
    private lazy var storeList: [FourcutStore] = [] {
        didSet {
            DispatchQueue.main.async {
                self.setMarkers(stores: self.storeList)
                self.currentPageIndex = Int(self.currentPageIndex) >= self.storeList.count ? CGFloat(self.storeList.count - 1) : self.currentPageIndex
            }
        }
    }
    private var currentPageIndex: CGFloat = 0
    private var searchingLocation: CLLocation?
    
    private let mapView: NMFMapView = {
        let mapView = NMFMapView()
        mapView.zoomLevel = 15
        mapView.positionMode = .direction
        return mapView
    }()
    private lazy var addressButton: UIButton = {
        let button = UIButton()
        button.setTitle("서울특별시 양천구 목동로 212", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.contentsAccent
        button.setImage(ImageLiterals.downArrow, for: .normal)
        button.tintColor = UIColor.customBlack
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 20
        button.layer.applyShadow()
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        button.addTarget(self, action: #selector(touchAddressButton), for: .touchUpInside)
        return button
    }()
    private lazy var researchButton: UIButton = {
        var button = UIButton()
        button.setTitle("현재 위치 기준으로 다시 찾아보기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.contentsDefaultAccent
        button = button.setButtonProperty(
                                   backgroundColor: UIColor.brandPink,
                                   radius: 15,
                                   top: 8, left: 16, bottom: 8, right: 16)
        button.addTarget(self, action: #selector(researchStores), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private lazy var turnToListButton: UIButton = {
        var button = UIButton()
        button.setTitle("목록 보기", for: .normal)
        button.setTitleColor(UIColor.customBlack, for: .normal)
        button.titleLabel?.font = UIFont.contentsDefault
        button = button.setButtonProperty(
                                    backgroundColor: UIColor.white,
                                   radius: 15,
                                   top: 8, left: 16, bottom: 8, right: 16)
        return button
    }()
    
    private lazy var currentLocationButton: UIButton = {
             let button = UIButton()
             let imageConfig = UIImage.SymbolConfiguration(pointSize: 20)
             button.setImage(ImageLiterals.currentLocation, for: .normal)
             button.imageView?.tintColor = .brandPink
             button.setPreferredSymbolConfiguration(imageConfig, forImageIn: .normal)
             button.layer.applyShadow(alpha: 0.15, x: 0, y: 1)
             button.layer.borderColor = UIColor.customGray?.cgColor
             button.layer.borderWidth = 1
             button.layer.cornerRadius = 20
             button.backgroundColor = .white
             button.addTarget(self, action: #selector(moveCameraToCurrentLocation), for: .touchUpInside)
             return button
         }()
    
    private let storeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Size.contentInset, bottom: 0, right: Size.contentInset)
        collectionView.register(HomeStoreCell.self, forCellWithReuseIdentifier: HomeStoreCell.registerId)
        collectionView.register(HomeStoreEmptyCell.self, forCellWithReuseIdentifier: HomeStoreEmptyCell.registerId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        return collectionView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureAddsubview()
        configureConstraints()
        configureDelegate()
        initMap()
        getStores(from: self.locationManager.getCurrentLocation())
    }
    
    // MARK: - closure & function
    
    private func moveCamera(to location: CLLocation, while interval: TimeInterval){
        let camPosition = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
        let cameraUpdate = NMFCameraUpdate(scrollTo: camPosition)
        cameraUpdate.animation = .easeIn
        cameraUpdate.animationDuration = interval
        mapView.moveCamera(cameraUpdate)
    }
    
    private func getStores(from location: CLLocation?) {
        guard let x = location?.coordinate.longitude, let y = location?.coordinate.latitude else { return }
        getAllStoresUseCase.getAllStores(longtitude: x, latitude:y) { [weak self] stores, error in
            guard let self = self else { return }
            guard error == nil else { return }
            self.storeList = stores.sorted(by: {$0.distance < $1.distance})
            print(self.storeList)
            DispatchQueue.main.async {
                self.storeCollectionView.reloadData()
            }
        }
    }
    
    private func initMap() {
            mapView.addCameraDelegate(delegate: self)
        }
    
    private func setMarkers(stores: [FourcutStore]) {
        clearMarkers()
        
        for idx in 0 ..< stores.count {
            let store = stores[idx]
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: store.y, lng: store.x)
            marker.iconImage = NMFOverlayImage(name: ImageLiterals.nonSelectedMarker)
            marker.width = 30
            marker.height = 40
            marker.mapView = self.mapView
            marker.touchHandler = { [weak self] _ in
                guard let self = self else { return false }
                let pageWidthIncludingSpace = HomeStoreCell.itemSize.width + Size.minimumInterItem
                self.currentPageIndex = CGFloat(idx)
                self.storeCollectionView.contentOffset.x = self.currentPageIndex * pageWidthIncludingSpace - Size.contentInset
                return true
            }
            markers.append(marker)
        }
    }
    
    private func clearMarkers() {
        for marker in markers {
            marker.mapView = nil
        }
        markers = []
    }
    
    private func selectMarker(selectedIdx: Int) {
        for index in 0 ..< markers.count {
            if index == selectedIdx {
                let marker = markers[index]
                let storeLocation = CLLocation(latitude: marker.position.lat, longitude: marker.position.lng)
                markers[index].iconImage = NMFOverlayImage(name: ImageLiterals.selectedMarker)
                setMarkerSize(marker: markers[index], width: 39, height: 52)
                moveCamera(to: storeLocation, while: 0.2)
            } else {
                markers[index].iconImage = NMFOverlayImage(name: ImageLiterals.nonSelectedMarker)
                setMarkerSize(marker: markers[index], width: 30, height: 40)
            }
        }
    }
    
    private func setMarkerSize(marker: NMFMarker, width: CGFloat, height: CGFloat) {
        marker.width = width
        marker.height = height
    }

    // MARK: - objc function
        
    @objc private func moveCameraToCurrentLocation() {
        locationManager.settingLocationManager()
        guard let currentLocation = locationManager.getCurrentLocation() else { return }
        self.moveCamera(to: currentLocation, while: 0.5)
        self.getStores(from: currentLocation)
        researchButton.isHidden = true
    }
    
    @objc private func researchStores() {
        self.getStores(from: searchingLocation)
        researchButton.isHidden = true
    }
    
    @objc private func touchAddressButton() {
        let addressViewController = AddressViewController()
        addressViewController.modalPresentationStyle = .fullScreen
        self.present(addressViewController, animated: true)
    }
    
    // MARK: - configure
        
    private func configureDelegate() {
        storeCollectionView.dataSource = self
        storeCollectionView.delegate = self
    }
    
    private func configureAddsubview() {
        view.addSubviews(
            mapView,
            addressButton,
            researchButton,
            turnToListButton,
            currentLocationButton,
            storeCollectionView
        )
    }
    
    private func configureConstraints() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addressButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.left.right.equalToSuperview().inset(Size.layoutInset)
            $0.height.equalTo(50)
        }
        
        researchButton.snp.makeConstraints {
            $0.top.equalTo(addressButton.snp.bottom).offset(16)
            $0.centerX.equalTo(addressButton.snp.centerX)
            $0.height.equalTo(40)
        }
        
        storeCollectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(130)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Size.layoutInset)
        }
        
        turnToListButton.snp.makeConstraints {
            $0.bottom.equalTo(storeCollectionView.snp.top).offset(-10)
            $0.height.equalTo(30)
            $0.centerX.equalTo(researchButton)
        }
        
        currentLocationButton.snp.makeConstraints {
                    $0.right.equalToSuperview().inset(Size.layoutInset)
                    $0.bottom.equalTo(storeCollectionView.snp.top).offset(-36)
                    $0.width.height.equalTo(40)
                }
    }
}
// MARK: - UICollectionViewDataSource
    
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = storeList.isEmpty ? 1 : storeList.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if storeList.isEmpty {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeStoreEmptyCell.registerId, for: indexPath) as? HomeStoreEmptyCell else { return HomeStoreEmptyCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeStoreCell.registerId, for: indexPath) as? HomeStoreCell else { return HomeStoreCell() }
            cell.storeInfo = storeList[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Size.minimumInterItem
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return HomeStoreCell.itemSize
    }
}

// MARK: - UIScrollViewDelegate

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidthIncludingSpace = HomeStoreCell.itemSize.width + Size.minimumInterItem
        let offset = targetContentOffset.pointee.x
        let index = (offset + Size.contentInset) / pageWidthIncludingSpace
        var roundedIndex = round(index)
        
        if currentPageIndex < roundedIndex {
            currentPageIndex += 1
            roundedIndex = currentPageIndex
        } else if currentPageIndex > roundedIndex {
            currentPageIndex -= 1
            roundedIndex = currentPageIndex
        }
        
        targetContentOffset.pointee = CGPoint(x: roundedIndex * pageWidthIncludingSpace - Size.contentInset, y: 0)
        
        selectMarker(selectedIdx: Int(currentPageIndex))
    }
}

extension HomeViewController: NMFMapViewCameraDelegate {
     func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
         if reason == NMFMapChangedByGesture {
             researchButton.isHidden = false
             searchingLocation = CLLocation(latitude: mapView.cameraPosition.target.lat, longitude: mapView.cameraPosition.target.lng)
         }
     }
 }
