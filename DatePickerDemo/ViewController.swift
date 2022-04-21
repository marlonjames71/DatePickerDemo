//
//  ViewController.swift
//  DatePickerDemo
//
//  Created by Raskin, Marlon on 2/28/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets and Properties
    @IBOutlet weak var datePickerButton: UIButton!
    private var selectedDate: Date = Date()


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDatePickerButton(with: selectedDate)
    }


    // MARK: - Actions
    @IBAction func dateTapped(_ sender: UIButton) {
        guard let datePickerVC = storyboard?.instantiateViewController(
            identifier: "DatePickerVC",
            creator: { [weak self] coder in
            return DatePickerViewController(coder: coder, date: self?.selectedDate ?? Date())
        }) else {
            fatalError("Failed to load DatePickerViewController from storyboard")
        }
        datePickerVC.modalTransitionStyle = .crossDissolve
        datePickerVC.modalPresentationStyle = .overFullScreen
        datePickerVC.delegate = self
        present(datePickerVC, animated: true)
    }


    // MARK: - Helper Methods
    fileprivate func updateDatePickerButton(with date: Date) {
        let formattedDate = date.formatted(date: .long, time: .omitted)
        datePickerButton.setTitle(formattedDate, for: .normal)
    }
}


// MARK: - Extensions
extension ViewController: DatePickerViewControllerDelegate {
    func didDismiss(with date: Date) {
        selectedDate = date
        updateDatePickerButton(with: date)
    }
}

