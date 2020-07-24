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
}

final class SearchView: UIView {
            
    weak var delegate: SearchViewDelegate?
        
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
        guard let searchText = searchBar.searchTextField.text, searchText.isEmpty == false else { return }
        delegate?.searchView(textDidChange: searchText)
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
        delegate?.searchView(textDidChange: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("asds")
    }
}
