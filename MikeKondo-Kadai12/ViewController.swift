//
//  ViewController.swift
//  MikeKondo-Kadai12
//
//  Created by 近藤米功 on 2022/08/26.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - UI Parts
    @IBOutlet private weak var taxFreePriceTextField: UITextField!
    @IBOutlet private weak var taxRateTextField: UITextField!
    @IBOutlet private weak var priceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        initTaxRate()
    }

    @IBAction private func didTapCalcButton(_ sender: Any) {
        let taxFreePrice = Int(taxFreePriceTextField.text ?? "") ?? 0
        let taxRate = Int(taxRateTextField.text ?? "") ?? 0
        calcPrice(taxRate: taxRate, taxFreePrice: taxFreePrice)
    }

    private func calcPrice(taxRate: Int, taxFreePrice: Int) {
        let price = taxFreePrice + (taxFreePrice/100)*taxRate
        priceLabel.text = "\(price)円"
        UserDefaults.standard.setValue(taxRate, forKey: "taxRateKey")
    }

    private func setupTextField() {
        taxFreePriceTextField.delegate = self
        taxRateTextField.delegate = self
    }

    private func initTaxRate() {
        guard let savedTaxRate = UserDefaults.standard.object(forKey: "taxRateKey") as? Int else { return }
        taxRateTextField.text = String(savedTaxRate)
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
