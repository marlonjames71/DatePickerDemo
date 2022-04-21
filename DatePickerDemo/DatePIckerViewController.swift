//
//  DatePickerViewController.swift
//  DatePickerDemo
//
//  Created by Raskin, Marlon on 2/28/22.
//

import UIKit

protocol DatePickerViewControllerDelegate: AnyObject {
    func didDismiss(with date: Date)
}


class DatePickerViewController: UIViewController {

    // MARK: - Outlets and Properties
    let selectedDate: Date
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerContainer: UIView!
    @IBOutlet weak var selectDateButton: UIButton!
    
    weak var delegate: DatePickerViewControllerDelegate?


    // MARK: - Init
    init?(coder: NSCoder, date: Date) {
        self.selectedDate = date
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        datePicker.transform = .init(scaleX: 0.3, y: 0.3)
        datePicker.alpha = 0
        datePicker.date = selectedDate
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -30, to: Date())
        datePicker.maximumDate = Date()
        
        datePickerContainer.layer.cornerCurve = .continuous
        datePickerContainer.layer.cornerRadius = 20
        datePickerContainer.backgroundColor = .secondarySystemBackground
        datePickerContainer.layer.shadowColor = UIColor.black.cgColor
        datePickerContainer.layer.shadowOpacity = 0.15
        datePickerContainer.layer.shadowRadius = 10
        datePickerContainer.transform = .init(scaleX: 0.45, y: 0.45)
        datePickerContainer.layer.borderWidth = 0.7
        datePickerContainer.layer.borderColor = UIColor.secondarySystemFill.cgColor
        datePickerContainer.alpha = 0     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 0.55,
            options: [.curveEaseOut]) {
            self.datePicker.transform = .identity
            self.datePicker.alpha = 1
            self.datePickerContainer.alpha = 1
            self.datePickerContainer.transform = .identity
        } completion: { completed in }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }


    // MARK: - Actions
    @IBAction func selectDateTapped(_ sender: UIButton) {
        self.delegate?.didDismiss(with: datePicker.date)
        animateOut { [weak self] completed in
            self?.dismiss(animated: true)
        }
    }

    @IBAction func cancelTapped(_ sender: UIButton) {
        animateOut { [weak self] completed in
            self?.dismiss(animated: true)
        }
    }


    // MARK: - Helper Methods
    private func animateOut(completion: ((Bool) -> Void)? = nil) {
        // Using a custom timing curve that I made using the Couverture app
        // I wanted to mimic the disappearing animation from Things 3

        let point1 = CGPoint(x: 0.7, y: -0.6)
        let point2 = CGPoint(x: 0.32, y: 1.29)
        let animator = UIViewPropertyAnimator(duration: 0.3, controlPoint1: point1, controlPoint2: point2) {
            self.datePickerContainer.alpha = 0
            self.datePicker.alpha = 0
            self.datePicker.transform = .init(scaleX: 0.85, y: 0.85)
            self.datePickerContainer.transform = .init(scaleX: 0.85, y: 0.85)
        }

        animator.startAnimation()
        animator.addCompletion { position in
            completion?(true)
        }
    }
}
