//
//  File.swift
//  
//
//  Created by Nikita Mikheev on 24.09.2021.
//

import UIKit

protocol AssertionControllerDelegate: AnyObject {
    func didUserProceed()
}

final class AssertionController: UIViewController {
    // MARK: Delegate
    weak var delegate: AssertionControllerDelegate?
    
    // MARK: Subviews
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var sendActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var proceedButton: UIButton!
    
    // MARK: Properties
    private let assertion: Assertion
    
    // MARK: Dependencies
    private let textConverter: AssertionTextConverting
    
    // MARK: Initializers
    init(
        assertion: Assertion
    ) {
        self.assertion = assertion
        self.textConverter = AssertionTextConverter(assertion: assertion)
        super.init(nibName: "AssertionController", bundle: Bundle.module)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let hoverButtonY = proceedButton.frame.origin.y
        let bottomOffset = view.frame.height - hoverButtonY + 8
        textView.textContainerInset.bottom = bottomOffset
        
        updateShadows()
    }
    
    // MARK: Setup
    private func setupView() {
        // Level Label
        levelLabel.text = assertion.level.name
        
        switch assertion.level {
        case .critical:
            levelLabel.textColor = Color.criticalRed
        case .important:
            levelLabel.textColor = Color.importantOrange
        case .handled:
            levelLabel.textColor = Color.handledBlue
        }
        
        // Send Button
        sendButton.isHidden = true  // Functionality not available
        
        // Text View
        textView.attributedText = textConverter.getDisplayMessage()
        textView.isEditable = false
        
        textView.textContainerInset = UIEdgeInsets(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16
        )
        
        // Proceed Button
        proceedButton.layer.cornerRadius = 25
        proceedButton.layer.masksToBounds = true
    }
    
    // MARK: User interactivity
    @IBAction func sendButtonAction() {
        // Functionality not available
    }
    @IBAction func proceedButtonAction() {
        delegate?.didUserProceed()
    }
    
    // MARK: Shadow
    private func updateShadows() {
        // Header
        let path = UIBezierPath(rect: headerView.bounds)
        headerView.layer.shadowPath = path.cgPath
        headerView.layer.shadowOffset.height = 1
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOpacity = 0.2
    }
}
