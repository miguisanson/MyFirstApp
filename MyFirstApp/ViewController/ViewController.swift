//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Miguel Sanson on 6/8/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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

    let userViewModel = UserViewModel()
    let tableView = UITableView()
    let userCellName = "UserCell"

    override func loadView() {
        view = UIView()
        setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        clearCalculator()
    }

    func setupLayout() {
        view.backgroundColor = .white

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(mainStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            mainStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -16),
            mainStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -32)
        ])

        let displayLabel = UILabel()
        displayLabel.textAlignment = .right
        mainStack.addArrangedSubview(displayLabel)
        displayLabel.heightAnchor.constraint(equalToConstant: 64).isActive = true
        self.displayLabel = displayLabel

        let buttonStack = UIStackView()
        buttonStack.axis = .vertical
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 8
        mainStack.addArrangedSubview(buttonStack)

        let buttonHeight = buttonStack.heightAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.9)
        buttonHeight.priority = .defaultHigh
        buttonHeight.isActive = true
        buttonStack.heightAnchor.constraint(lessThanOrEqualToConstant: 330).isActive = true

        let deleteButton = makeButton(title: "DEL", action: #selector(deleteButtonTapped(_:)))
        let clearButton = makeButton(title: "AC", action: #selector(clearButtonTapped(_:)))
        let percentButton = makeButton(title: "%", action: #selector(percentButtonTapped(_:)))
        let divideButton = makeButton(title: "/", action: #selector(divideButtonTapped(_:)))
        let sevenButton = makeButton(title: "7", action: #selector(sevenButtonTapped(_:)))
        let eightButton = makeButton(title: "8", action: #selector(eightButtonTapped(_:)))
        let nineButton = makeButton(title: "9", action: #selector(nineButtonTapped(_:)))
        let multiplyButton = makeButton(title: "x", action: #selector(multiplyButtonTapped(_:)))
        let fourButton = makeButton(title: "4", action: #selector(fourButtonTapped(_:)))
        let fiveButton = makeButton(title: "5", action: #selector(fiveButtonTapped(_:)))
        let sixButton = makeButton(title: "6", action: #selector(sixButtonTapped(_:)))
        let subtractButton = makeButton(title: "-", action: #selector(subtractButtonTapped(_:)))
        let oneButton = makeButton(title: "1", action: #selector(oneButtonTapped(_:)))
        let twoButton = makeButton(title: "2", action: #selector(twoButtonTapped(_:)))
        let threeButton = makeButton(title: "3", action: #selector(threeButtonTapped(_:)))
        let addButton = makeButton(title: "+", action: #selector(addButtonTapped(_:)))
        let signButton = makeButton(title: "+/-", action: #selector(signButtonTapped(_:)))
        let zeroButton = makeButton(title: "0", action: #selector(zeroButtonTapped(_:)))
        let decimalButton = makeButton(title: ".", action: #selector(decimalButtonTapped(_:)))
        let equalsButton = makeButton(title: "=", action: #selector(equalsButtonTapped(_:)))

        self.deleteButton = deleteButton
        self.clearButton = clearButton
        self.percentButton = percentButton
        self.divideButton = divideButton
        self.sevenButton = sevenButton
        self.eightButton = eightButton
        self.nineButton = nineButton
        self.multiplyButton = multiplyButton
        self.fourButton = fourButton
        self.fiveButton = fiveButton
        self.sixButton = sixButton
        self.subtractButton = subtractButton
        self.oneButton = oneButton
        self.twoButton = twoButton
        self.threeButton = threeButton
        self.addButton = addButton
        self.signButton = signButton
        self.zeroButton = zeroButton
        self.decimalButton = decimalButton
        self.equalsButton = equalsButton

        buttonStack.addArrangedSubview(makeRow([deleteButton, clearButton, percentButton, divideButton]))
        buttonStack.addArrangedSubview(makeRow([sevenButton, eightButton, nineButton, multiplyButton]))
        buttonStack.addArrangedSubview(makeRow([fourButton, fiveButton, sixButton, subtractButton]))
        buttonStack.addArrangedSubview(makeRow([oneButton, twoButton, threeButton, addButton]))
        buttonStack.addArrangedSubview(makeRow([signButton, zeroButton, decimalButton, equalsButton]))

        let tableTitleLabel = UILabel()
        tableTitleLabel.text = "Users"
        tableTitleLabel.font = .boldSystemFont(ofSize: 20)
        mainStack.addArrangedSubview(tableTitleLabel)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 64
        mainStack.addArrangedSubview(tableView)
        tableView.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }

    func makeButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }

    func makeRow(_ buttons: [UIButton]) -> UIStackView {
        let rowStack = UIStackView(arrangedSubviews: buttons)
        rowStack.axis = .horizontal
        rowStack.distribution = .fillEqually
        rowStack.spacing = 8
        return rowStack
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.numberOfUsers
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellName) ??
            UITableViewCell(style: .subtitle, reuseIdentifier: userCellName)

        cell.textLabel?.text = userViewModel.displayName(row: indexPath.row)
        cell.detailTextLabel?.text = userViewModel.displayDetails(row: indexPath.row)
        cell.imageView?.image = UIImage(systemName: userViewModel.imageName(row: indexPath.row))
        cell.imageView?.tintColor = .black
        cell.selectionStyle = .none

        return cell
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

        tableView.backgroundColor = .white
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.black.cgColor
    }

    func styleButton(_ button: UIButton) {
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 24)
    }

}
