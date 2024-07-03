//
//  BottomSheetViewController.swift
//  iOSTestApp
//
//  Created by Ateeq Ahmed on 03/07/24.
//

import UIKit

class BottomSheetViewController: UIViewController {

    var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStatistics()
    }
    
    func setupStatistics() {
        let itemCountLabel = UILabel()
        itemCountLabel.text = "Count of Items: \(items.count)"
        itemCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let characterCounts = getCharacterCounts(from: items)
        let top3Characters = characterCounts.sorted { $0.value > $1.value }.prefix(3)
        
        let topCharactersLabel = UILabel()
        topCharactersLabel.text = "Top 3 Occurrence Characters:"
        topCharactersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var characterLabels: [UILabel] = []
        for (char, count) in top3Characters {
            let label = UILabel()
            label.text = "\(char): \(count)"
            label.translatesAutoresizingMaskIntoConstraints = false
            characterLabels.append(label)
        }
        
        let stackView = UIStackView(arrangedSubviews: [itemCountLabel, topCharactersLabel] + characterLabels)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func getCharacterCounts(from items: [String]) -> [Character: Int] {
        var counts: [Character: Int] = [:]
        for item in items {
            for char in item {
                counts[char, default: 0] += 1
            }
        }
        return counts
    }
}
