//
//  AddressViewController.swift
//  NEMO-fourcut-map-ios
//
//  Created by sanghyo on 2022/10/09.
//

import Foundation
import UIKit

protocol AddressViewControllerDelegate: AnyObject {
    func setSearchAddress(locationInfo: LocationInfo) -> Void
}

final class AddressViewController: UIViewController {
    
    weak var delegate: AddressViewControllerDelegate?
    private var addressResults: [LocationInfo]? = nil
    private let getLocationsUseCase: GetLocationsUseCase = GetLocationsUseCase()
    private var addressResultsStatus: AddressResultsStatus {
        get {
            return AddressResultsStatus(results: addressResults)
        }
    }
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        return view
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "장소 검색"
        label.font = UIFont.contentsTitle
        label.textColor = .customBlack
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.xmark, for: .normal)
        button.tintColor = .customBlack
        button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        button.contentHorizontalAlignment = .trailing
        return button
    }()
    
    private let searchTextField: UITextField = {
        let field = UITextField()
        field.textColor = .customBlack
        field.borderStyle = .roundedRect
        field.backgroundColor = .customGray
        field.placeholder = "구, 동, 역 등으로 검색"
        field.font = UIFont.contentsDefault
        return field
    }()
    
    private let divideLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customGray
        return view
    }()
    
    private let addressTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: AddressTableViewCell.registerId)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.registerId)
        tableView.backgroundColor = .customGray
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddsubview()
        configureConstraints()
        configureDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearHistory()
    }
    
    // MARK: - function
    
    private func clearHistory() {
        addressResults = nil
        searchTextField.text = ""
        addressTableView.reloadData()
    }
    
    // MARK: - objc function
    
    @objc private func closeModal() {
        self.dismiss(animated: true)
    }
    
    // MARK: - configure
    
    private func configureUI() {
        view.backgroundColor = .background
    }
    
    private func configureDelegate() {
        addressTableView.delegate = self
        addressTableView.dataSource = self
        searchTextField.delegate = self
    }
    
    private func configureAddsubview() {
        view.addSubviews(
            headerView,
            headerLabel,
            closeButton,
            searchTextField,
            divideLine,
            addressTableView
        )
    }
    
    private func configureConstraints() {
        headerView.snp.makeConstraints {
            let safeAreaLayout = view.safeAreaLayoutGuide
            
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(safeAreaLayout)
            $0.height.equalTo(60)
        }
        
        headerLabel.snp.makeConstraints {
            $0.center.equalTo(headerView)
        }
        
        closeButton.snp.makeConstraints {
            $0.size.equalTo(44)
            $0.centerY.equalTo(headerView.snp.centerY)
            $0.trailing.equalToSuperview().inset(Size.sidePadding)
        }
        
        searchTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Size.sidePadding)
            $0.top.equalTo(headerView.snp.bottom).offset(16)
            $0.height.equalTo(44)
        }
        
        divideLine.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(searchTextField.snp.bottom).offset(16)
            $0.height.equalTo(5)
        }
        
        addressTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(divideLine.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - table view Datasource & Delegate

extension AddressViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case AddressResultsStatus.notEmpty = addressResultsStatus {
            tableView.deselectRow(at: indexPath, animated: true)
            guard let addressResults = addressResults else { return }
            let locationInfo = addressResults[indexPath.row]
            delegate?.setSearchAddress(locationInfo: locationInfo)
            self.dismiss(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch addressResultsStatus {
        case .empty, .notDetermined:
            return tableView.frame.height
        case .notEmpty:
            return AddressTableViewCell.itemHeight
        }
    }
}

extension AddressViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch addressResultsStatus {
        case .empty:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.registerId) as? EmptyTableViewCell else { return EmptyTableViewCell() }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.registerId) as? AddressTableViewCell else { return AddressTableViewCell() }
            guard let addressResults = addressResults else { return cell }
            cell.locationInfo = addressResults[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch addressResultsStatus {
        case .empty:
            tableView.separatorStyle = .none
            return 1
        case .notEmpty:
            tableView.separatorStyle = .singleLine
            guard let addressResults = addressResults else { return 0 }
            return addressResults.count
        default:
            return 0
        }
    }
}

// MARK: - UITextFieldDelegate

extension AddressViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let keyword = textField.text else { return true }
        getLocationsUseCase.getLocations(keyword: keyword) { [weak self] locationList, error in
            guard error == nil else { return }
            self?.addressResults = locationList
            textField.resignFirstResponder()
            self?.addressTableView.reloadData()
        }
        return true
    }
}
