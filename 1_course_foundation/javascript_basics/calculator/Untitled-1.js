 <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="style.css" />
    <link
      href="https://fonts.googleapis.com/css2?family=Roboto&display=swap"
      rel="stylesheet"
    />
    <link rel="shortcut icon" href="favicon.ico" />
    <script
      src="https://kit.fontawesome.com/4c536a6bd5.js"
      crossorigin="anonymous"
    ></script>
    <script src="script.js" defer></script>
    <title>Calculator</title>
  </head>
  <body>
    <main class="main">
      <div class="calculator">
        <div class="screen">
          <div class="screen-last" id="lastOperationScreen"></div>
          <div class="screen-current" id="currentOperationScreen">0</div>
        </div>
        <div class="buttons-grid">
          <button
            class="btn btn-red span-2"
            id="clearBtn"
            onclick="this.blur();"
          >
            CLEAR
          </button>
          <button
            class="btn btn-blue span-2"
            id="deleteBtn"
            onclick="this.blur();"
          >
            DELETE
          </button>
          <button class="btn" onclick="this.blur();" data-number>7</button>
          <button class="btn" onclick="this.blur();" data-number>8</button>
          <button class="btn" onclick="this.blur();" data-number>9</button>
          <button class="btn" onclick="this.blur();" data-operator>÷</button>

          <button class="btn" onclick="this.blur();" data-number>4</button>
          <button class="btn" onclick="this.blur();" data-number>5</button>
          <button class="btn" onclick="this.blur();" data-number>6</button>
          <button class="btn" onclick="this.blur();" data-operator>×</button>

          <button class="btn" onclick="this.blur();" data-number>1</button>
          <button class="btn" onclick="this.blur();" data-number>2</button>
          <button class="btn" onclick="this.blur();" data-number>3</button>
          <button class="btn" onclick="this.blur();" data-operator>−</button>

          <button class="btn" onclick="this.blur();" id="pointBtn">.</button>
          <button class="btn" onclick="this.blur();" data-number>0</button>
          <button class="btn" onclick="this.blur();" id="equalsBtn">=</button>
          <button class="btn" onclick="this.blur();" data-operator>+</button>
        </div>
      </div>


      let firstOperand = ''
let secondOperand = ''
let currentOperation = null
let shouldResetScreen = false

const numberButtons = document.querySelectorAll('[data-number]')
const operatorButtons = document.querySelectorAll('[data-operator]')
const equalsButton = document.getElementById('equalsBtn')
const clearButton = document.getElementById('clearBtn')
const deleteButton = document.getElementById('deleteBtn')
const pointButton = document.getElementById('pointBtn')
const lastOperationScreen = document.getElementById('lastOperationScreen')
const currentOperationScreen = document.getElementById('currentOperationScreen')

window.addEventListener('keydown', handleKeyboardInput)
equalsButton.addEventListener('click', evaluate)
clearButton.addEventListener('click', clear)
deleteButton.addEventListener('click', deleteNumber)
pointButton.addEventListener('click', appendPoint)

numberButtons.forEach((button) =>
  button.addEventListener('click', () => appendNumber(button.textContent))
)

operatorButtons.forEach((button) =>
  button.addEventListener('click', () => setOperation(button.textContent))
)

function appendNumber(number) {
  if (currentOperationScreen.textContent === '0' || shouldResetScreen)
    resetScreen()
  currentOperationScreen.textContent += number
}

function resetScreen() {
  currentOperationScreen.textContent = ''
  shouldResetScreen = false
}

function clear() {
  currentOperationScreen.textContent = '0'
  lastOperationScreen.textContent = ''
  firstOperand = ''
  secondOperand = ''
  currentOperation = null
}

function appendPoint() {
  if (shouldResetScreen) resetScreen()
  if (currentOperationScreen.textContent === '')
    currentOperationScreen.textContent = '0'
  if (currentOperationScreen.textContent.includes('.')) return
  currentOperationScreen.textContent += '.'
}

function deleteNumber() {
  currentOperationScreen.textContent = currentOperationScreen.textContent
    .toString()
    .slice(0, -1)
}

function setOperation(operator) {
  if (currentOperation !== null) evaluate()
  firstOperand = currentOperationScreen.textContent
  currentOperation = operator
  lastOperationScreen.textContent = `${firstOperand} ${currentOperation}`
  shouldResetScreen = true
}

function evaluate() {
  if (currentOperation === null || shouldResetScreen) return
  if (currentOperation === '÷' && currentOperationScreen.textContent === '0') {
    alert("You can't divide by 0!")
    return
  }
  secondOperand = currentOperationScreen.textContent
  currentOperationScreen.textContent = roundResult(
    operate(currentOperation, firstOperand, secondOperand)
  )
  lastOperationScreen.textContent = `${firstOperand} ${currentOperation} ${secondOperand} =`
  currentOperation = null
}

function roundResult(number) {
  return Math.round(number * 1000) / 1000
}

function handleKeyboardInput(e) {
  if (e.key >= 0 && e.key <= 9) appendNumber(e.key)
  if (e.key === '.') appendPoint()
  if (e.key === '=' || e.key === 'Enter') evaluate()
  if (e.key === 'Backspace') deleteNumber()
  if (e.key === 'Escape') clear()
  if (e.key === '+' || e.key === '-' || e.key === '*' || e.key === '/')
    setOperation(convertOperator(e.key))
}

function convertOperator(keyboardOperator) {
  if (keyboardOperator === '/') return '÷'
  if (keyboardOperator === '*') return '×'
  if (keyboardOperator === '-') return '−'
  if (keyboardOperator === '+') return '+'
}

function add(a, b) {
  return a + b
}

function substract(a, b) {
  return a - b
}

function multiply(a, b) {
  return a * b
}

function divide(a, b) {
  return a / b
}

function operate(operator, a, b) {
  a = Number(a)
  b = Number(b)
  switch (operator) {
    case '+':
      return add(a, b)
    case '−':
      return substract(a, b)
    case '×':
      return multiply(a, b)
    case '÷':
      if (b === 0) return null
      else return divide(a, b)
    default:
      return null
  }
}
