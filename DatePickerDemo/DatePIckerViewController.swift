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

    let selectedDate: Date
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerContainer: UIView!
    @IBOutlet weak var selectDateButton: UIButton!
    
    weak var delegate: DatePickerViewControllerDelegate?
    
    init?(coder: NSCoder, date: Date) {
        self.selectedDate = date
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        datePickerContainer.backgroundColor = .systemBackground
        datePickerContainer.layer.shadowColor = UIColor.black.cgColor
        datePickerContainer.layer.shadowOpacity = 0.2
        datePickerContainer.layer.shadowRadius = 10
        datePickerContainer.transform = .init(scaleX: 0.45, y: 0.45)
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
    
    private func animateOut(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.85,
                       initialSpringVelocity: 0.55,
                       options: [.curveEaseOut],
                       animations: {
            self.datePickerContainer.alpha = 0
            self.datePicker.alpha = 0
            self.datePicker.transform = .init(scaleX: 0.85, y: 0.85)
            self.datePickerContainer.transform = .init(scaleX: 0.85, y: 0.85)
        }, completion: completion)
    }
    
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
}
