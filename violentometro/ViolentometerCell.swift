//
//  ViolentometerCell.swift
//  violentometro
//
//  Created by Memo Rodriguez on 2/27/19.
//  Copyright © 2019 Guillermo Rodriguez. All rights reserved.
//

import UIKit
import SelectionList

class ViolentometerCell: UICollectionViewCell {
    
    let questionLabel: UILabel = {
        let _label = UILabel()
        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.textAlignment = .center
        _label.numberOfLines = 0
        _label.font = UIFont.systemFont(ofSize: 25)
        _label.lineBreakMode = .byWordWrapping
        return _label
    }()
    
    lazy var selectionList: SelectionList = {
        let _list = SelectionList()
        _list.translatesAutoresizingMaskIntoConstraints = false
        _list.items = ["Si", "No"]
        _list.tableView.tableFooterView = UIView()
        _list.rowHeight = 60
        _list.addTarget(self, action: #selector(selectionChanged), for: .valueChanged)
        return _list
    }()
    
    var viewController: ViolentometerViewController?
    var question: Question?
    
    func configureCell(question: Question, viewController: ViolentometerViewController) {
        self.viewController = viewController
        self.question = question
        
        addSubview(questionLabel)
        addSubview(selectionList)
        
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: topAnchor),
            questionLabel.bottomAnchor.constraint(equalTo: centerYAnchor),
            questionLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            
            selectionList.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectionList.topAnchor.constraint(equalTo: centerYAnchor),
            selectionList.bottomAnchor.constraint(equalTo: bottomAnchor),
            selectionList.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            ])
        
        
        questionLabel.text = question.question
        selectionList.selectedIndex = nil
        selectionList.setupCell =  { (cell: UITableViewCell, index: Int) in
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        }
        
    }
    
    @objc
    private func selectionChanged() {
        guard let selectedIndex = selectionList.selectedIndex,
            let controller = viewController,
            let question = self.question,
            let answer = Answer(rawValue: selectedIndex)else { return }
        controller.nextQuestion(question: question, answer: answer)
    }
}


