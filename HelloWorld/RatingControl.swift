//
//  RatingControl.swift
//  HelloWorld
//
//  Created by eesee on 2017/12/13.
//  Copyright © 2017年 eesee. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    @IBInspectable var starSize:CGSize = CGSize(width:44.0,  height:44.0){
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount:Int = 5{
        didSet{
            setupButtons()
        }
    }

    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet{
            updateButtonSelectionStates()
        }
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder:coder)
        setupButtons()
    }
    
    fileprivate func createButton() {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "emptyStar"), for: .normal)
        addArrangedSubview(button)
        ratingButtons.append(button)
    }
    
    private func setupButtons(){
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        let bundle = Bundle(for:type(of: self))
        let filledStar = UIImage(named:"filledStar",in:bundle, compatibleWith :self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in:bundle, compatibleWith:self.traitCollection)
        let highlightStar = UIImage(named:"hightlightStar", in:bundle, compatibleWith:self.traitCollection)
        for _ in 0..<starCount{
            //createButton()
            let button = UIButton()
            //button.backgroundColor = UIColor.red
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for:.selected)
            button.setImage(highlightStar, for: .highlighted)
            button.setImage(highlightStar, for: [.highlighted, .selected])
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        updateButtonSelectionStates()
        
    }
    
    
    func ratingButtonTapped(button:UIButton){
        print("ratingButton pressed")
        guard let index = ratingButtons.index(of:button) else {
            fatalError("The button,\(button), is not in the ratingButtons arrays:\(ratingButtons)")
        }
        let selectedRating = index + 1
        if (selectedRating == rating){
            rating = 0
        } else {
            rating = selectedRating
        }
    }

    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
        }
    }
    

}
