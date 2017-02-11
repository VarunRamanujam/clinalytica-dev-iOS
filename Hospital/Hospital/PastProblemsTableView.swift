//
//  PastProblemsTableView.swift
//  Hospital
//
//  Created by Shridhar on 2/5/17.
//
//

import UIKit

let PastProblemsCellIdentifier = "PastProblemsCellIdentifier"
let PastProblemsTitleCellIdentifier = "PastProblemsTitleCellIdentifier"

class PastProblemsTableView: RUITableView {

    var pastProbles = [PastProblem]()
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        initialzePastProblemsTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialzePastProblemsTableView()
    }
    
    func initialzePastProblemsTableView() {
        
        self.addBorderAndCornerRadius()
        self.delegate = self
        self.dataSource = self
        
        self.register(UINib(nibName: "PastProblemsCell", bundle: nil), forCellReuseIdentifier: PastProblemsCellIdentifier)
        self.register(UINib(nibName: "PastProblemsTitleCell", bundle: nil), forCellReuseIdentifier: PastProblemsTitleCellIdentifier)
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = 85.0
        
        for _ in 1...6 {
            let object = PastProblem()
            pastProbles.append(object)
        }
    }
}

extension PastProblemsTableView : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pastProbles.count + 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: PastProblemsTitleCellIdentifier, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PastProblemsCellIdentifier, for: indexPath) as! PastProblemsCell
            cell.pastProblem = pastProbles[indexPath.row - 1]
            return cell
        }
    }
}
