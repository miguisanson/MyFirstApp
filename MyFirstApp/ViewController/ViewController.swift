//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Miguel Sanson on 6/8/26.
//

import UIKit

class ViewController: UIViewController {

    // This label shows the calculator number.
    @IBOutlet weak var displayLabel: UILabel!

    // These variables keep references to each calculator button.
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var decimalButton: UIButton!
    @IBOutlet weak var equalsButton: UIButton!

    // These variables remember what the user typed.
    var firstNumber = 0.0
    var mathSign = ""
    var isTypingNumber = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        clearCalculator()
    }

    // Each IBAction is connected to one calculator button.
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        deleteLastNumber()
    }

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        clearCalculator()
    }

    @IBAction func percentButtonTapped(_ sender: UIButton) {
        let currentNumber = Double(displayLabel.text ?? "0") ?? 0
        showAnswer(currentNumber / 100)
        isTypingNumber = false
    }

    @IBAction func divideButtonTapped(_ sender: UIButton) {
        saveFirstNumber("/")
    }

    @IBAction func sevenButtonTapped(_ sender: UIButton) {
        typeNumber("7")
    }

    @IBAction func eightButtonTapped(_ sender: UIButton) {
        typeNumber("8")
    }

    @IBAction func nineButtonTapped(_ sender: UIButton) {
        typeNumber("9")
    }

    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        saveFirstNumber("x")
    }

    @IBAction func fourButtonTapped(_ sender: UIButton) {
        typeNumber("4")
    }

    @IBAction func fiveButtonTapped(_ sender: UIButton) {
        typeNumber("5")
    }

    @IBAction func sixButtonTapped(_ sender: UIButton) {
        typeNumber("6")
    }

    @IBAction func subtractButtonTapped(_ sender: UIButton) {
        saveFirstNumber("-")
    }

    @IBAction func oneButtonTapped(_ sender: UIButton) {
        typeNumber("1")
    }

    @IBAction func twoButtonTapped(_ sender: UIButton) {
        typeNumber("2")
    }

    @IBAction func threeButtonTapped(_ sender: UIButton) {
        typeNumber("3")
    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        saveFirstNumber("+")
    }

    @IBAction func signButtonTapped(_ sender: UIButton) {
        let currentNumber = Double(displayLabel.text ?? "0") ?? 0
        showAnswer(currentNumber * -1)
    }

    @IBAction func zeroButtonTapped(_ sender: UIButton) {
        typeNumber("0")
    }

    @IBAction func decimalButtonTapped(_ sender: UIButton) {
        let currentText = displayLabel.text ?? "0"

        if isTypingNumber == false {
            displayLabel.text = "0."
            isTypingNumber = true
        } else if currentText.contains(".") == false {
            displayLabel.text = currentText + "."
        }
    }

    @IBAction func equalsButtonTapped(_ sender: UIButton) {
        let secondNumber = Double(displayLabel.text ?? "0") ?? 0
        var answer = 0.0

        if mathSign == "+" {
            answer = firstNumber + secondNumber
        } else if mathSign == "-" {
            answer = firstNumber - secondNumber
        } else if mathSign == "x" {
            answer = firstNumber * secondNumber
        } else if mathSign == "/" {
            if secondNumber == 0 {
                displayLabel.text = "Error"
                isTypingNumber = false
                mathSign = ""
                return
            }

            answer = firstNumber / secondNumber
        } else {
            return
        }

        showAnswer(answer)
        isTypingNumber = false
        mathSign = ""
    }

    // This function is used by the number buttons.
    func typeNumber(_ number: String) {
        if isTypingNumber {
            if displayLabel.text == "0" {
                displayLabel.text = number
            } else {
                displayLabel.text = (displayLabel.text ?? "") + number
            }
        } else {
            displayLabel.text = number
            isTypingNumber = true
        }
    }

    // This function remembers the first number and the math sign.
    func saveFirstNumber(_ sign: String) {
        firstNumber = Double(displayLabel.text ?? "0") ?? 0
        mathSign = sign
        isTypingNumber = false
    }

    func deleteLastNumber() {
        var currentText = displayLabel.text ?? "0"

        if isTypingNumber == false || currentText == "0" || currentText == "Error" {
            displayLabel.text = "0"
            return
        }

        currentText.removeLast()

        if currentText.isEmpty || currentText == "-" {
            displayLabel.text = "0"
            isTypingNumber = false
        } else {
            displayLabel.text = currentText
        }
    }

    func clearCalculator() {
        displayLabel.text = "0"
        firstNumber = 0
        mathSign = ""
        isTypingNumber = false
    }

    func showAnswer(_ answer: Double) {
        if answer.truncatingRemainder(dividingBy: 1) == 0 {
            displayLabel.text = String(Int(answer))
        } else {
            displayLabel.text = String(answer)
        }
    }

    func setupScreen() {
        view.backgroundColor = .white

        displayLabel.textColor = .black
        displayLabel.backgroundColor = .white
        displayLabel.layer.borderWidth = 1
        displayLabel.layer.borderColor = UIColor.black.cgColor
        displayLabel.font = .systemFont(ofSize: 48)
        displayLabel.adjustsFontSizeToFitWidth = true
        displayLabel.minimumScaleFactor = 0.35

        styleButton(deleteButton)
        styleButton(clearButton)
        styleButton(percentButton)
        styleButton(divideButton)
        styleButton(sevenButton)
        styleButton(eightButton)
        styleButton(nineButton)
        styleButton(multiplyButton)
        styleButton(fourButton)
        styleButton(fiveButton)
        styleButton(sixButton)
        styleButton(subtractButton)
        styleButton(oneButton)
        styleButton(twoButton)
        styleButton(threeButton)
        styleButton(addButton)
        styleButton(signButton)
        styleButton(zeroButton)
        styleButton(decimalButton)
        styleButton(equalsButton)
    }

    func styleButton(_ button: UIButton) {
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 24)
    }

}

class UsersTableViewController: UITableViewController {

    let userViewModel = UserViewModel()
    let userCellName = "UserCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        tableView.rowHeight = 72
        tableView.register(UserCell.self, forCellReuseIdentifier: userCellName)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.numberOfUsers
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellName, for: indexPath) as! UserCell

        cell.showUser(
            name: userViewModel.displayName(row: indexPath.row),
            details: userViewModel.displayDetails(row: indexPath.row),
            imageName: userViewModel.imageName(row: indexPath.row)
        )
        cell.selectionStyle = .none

        return cell
    }
}

class UserCell: UITableViewCell {

    let personImageView = UIImageView()
    let nameLabel = UILabel()
    let detailsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    func setupCell() {
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        personImageView.contentMode = .scaleAspectFill
        personImageView.clipsToBounds = true
        personImageView.layer.cornerRadius = 8

        nameLabel.font = .boldSystemFont(ofSize: 16)
        detailsLabel.font = .systemFont(ofSize: 14)
        detailsLabel.textColor = .darkGray

        let labelStack = UIStackView(arrangedSubviews: [nameLabel, detailsLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 4

        let rowStack = UIStackView(arrangedSubviews: [personImageView, labelStack])
        rowStack.axis = .horizontal
        rowStack.spacing = 12
        rowStack.alignment = .center
        rowStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(rowStack)

        NSLayoutConstraint.activate([
            personImageView.widthAnchor.constraint(equalToConstant: 52),
            personImageView.heightAnchor.constraint(equalToConstant: 52),

            rowStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rowStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rowStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rowStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func showUser(name: String, details: String, imageName: String) {
        nameLabel.text = name
        detailsLabel.text = details
        personImageView.image = UIImage(named: imageName)
    }
}
