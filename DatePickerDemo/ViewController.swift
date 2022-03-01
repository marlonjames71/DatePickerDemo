//
//  ViewController.swift
//  DatePickerDemo
//
//  Created by Raskin, Marlon on 2/28/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePickerButton: UIButton!
    private var selectedDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDatePickerButton(with: selectedDate)
    }


    @IBAction func dateTapped(_ sender: UIButton) {
        guard let datePickerVC = storyboard?.instantiateViewController(identifier: "DatePickerVC", creator: { coder in
            return DatePickerViewController(coder: coder, date: self.selectedDate)
        }) else {
            fatalError("Failed to load DatePickerViewController from storyboard")
        }
        datePickerVC.modalTransitionStyle = .crossDissolve
        datePickerVC.modalPresentationStyle = .overFullScreen
        datePickerVC.delegate = self
        present(datePickerVC, animated: true)
    }
    
    fileprivate func updateDatePickerButton(with date: Date) {
        let formattedDate = date.formatted(date: .long, time: .omitted)
        datePickerButton.setTitle(formattedDate, for: .normal)
    }
}

extension ViewController: DatePickerViewControllerDelegate {
    func didDismiss(with date: Date) {
        selectedDate = date
        updateDatePickerButton(with: date)
    }
}

