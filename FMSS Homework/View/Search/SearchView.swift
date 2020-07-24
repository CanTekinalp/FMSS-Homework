//
//  SearchView.swift
//  FMSS Homework
//
//  Created by Can Tekinalp on 24.07.2020.
//  Copyright © 2020 Can Tekinalp. All rights reserved.
//

import UIKit

protocol SearchViewDelegate: NSObjectProtocol {
    func searchView(textDidChange searchText: String)
    func searchTextFieldCleared()
}

final class SearchView: UIView {
            
    weak var delegate: SearchViewDelegate?
        
    private var prevText: String = ""
    private let searchElementThreshold: Int = 2
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.addDoneToolbar(target: self, action: #selector(handleDoneButton))
        return searchBar
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDoneButton() {
        searchBar.resignFirstResponder()
        delegate?.searchView(textDidChange: searchBar.searchTextField.text ?? "")
    }
}

extension SearchView {
    
    private func setup() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(searchBar)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 8
        searchBar.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         paddingTop: padding, paddingleft: padding, paddingBottom: padding, paddingRight: padding,
                         width: 0, height: 0, centerX: nil, centerY: nil)
    }
}

extension SearchView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (prevText.count >  searchElementThreshold && searchText.isEmpty) ||
            (prevText.count > searchElementThreshold && searchText.count < searchElementThreshold + 1)
        {
            delegate?.searchTextFieldCleared()
            prevText = searchText
            return
        }
        prevText = searchText
        delegate?.searchView(textDidChange: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
}
