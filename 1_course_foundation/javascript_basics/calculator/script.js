let firstOperand =''
let secondOperand=''
let currentOperation=''
let shouldResetScreen = false
let digits=''
const arrayNum=[]

const numberButtons = document.querySelectorAll('[number]')
const operatorButtons = document.querySelectorAll('[operator]')

const answerScreen = document.getElementById('answer')
const equationScreen = document.getElementById('equation')

numberButtons.forEach((button) =>
  button.addEventListener('click', () => getInput(button.textContent))
)
operatorButtons.forEach((button) =>
  button.addEventListener('click', () => setOperation(button.textContent))
)

function deleteNum() {
  if(answerScreen.textContent.length!=0){
    equationScreen.textContent=answerScreen.textContent

  for(i=0; i<=arrayNum.length+1; i++){
    arrayNum.pop()
  }
   equationScreen.textContent= equationScreen.textContent.toString().slice(0, -1)
   digits=equationScreen.textContent
  }  
  else{
equationScreen.textContent= equationScreen.textContent.toString().slice(0, -1)
d_length=digits.length;
digits=digits.substring(0, d_length-1)+digits.substring(d_length,digits.length)
  }
answerScreen.textContent=''
}

function getInput(number){  
  if(answerScreen.textContent.length!=0){
    equationScreen.textContent=answerScreen.textContent

    for(i=0; i<=arrayNum.length+1; i++){
      arrayNum.pop()
     }
     
    equationScreen.textContent += number;
    setDigit(equationScreen.textContent); 

    answerScreen.textContent=''

   }  
  else{
  equationScreen.textContent += number;
  setDigit(number); 
  }
  }

 function setDigit(number){
    if(number!=null){
      digits+=number
    }
    else if(number==null){  
      if(digits!=null){
      arrayNum.push(digits)  
      digits=''  
    }
    }    
  }

    
function setOperation(operator) {
if(answerScreen.textContent.length!=0){
  equationScreen.textContent=answerScreen.textContent

  for(i=0; i<=arrayNum.length+1; i++){
    arrayNum.pop()
   }
  

  firstOperand=answerScreen.textContent
  currentOperation = operator
  equationScreen.textContent = `${firstOperand} ${currentOperation}`
  shouldResetScreen = true
  answerScreen.textContent=''

 setDigit(firstOperand)
  setDigit(null)  
  arrayNum.push(operator)

}
else{
  firstOperand = equationScreen.textContent
  currentOperation = operator
  equationScreen.textContent = `${firstOperand} ${currentOperation}`
  shouldResetScreen = true

  setDigit(null)
  arrayNum.push(operator)
}

}

function clearScreen() { 
  answerScreen.textContent = ''
    equationScreen.textContent = ''
    firstOperand = ''
    secondOperand = ''
    currentOperation = null

   for(i=0; i<=arrayNum.length+1; i++){
    arrayNum.pop()
   }
  }

function equals() {
  //alert('positive')
  setDigit(null)

  let firstnum='', secondnum='';
  let a='', b=''; 
  let product='', quotient='', sum='', difference=''
   if(arrayNum.length!=0){   
   for(i=0; i<=arrayNum.length; i++){
    
  //     //follow MDAS rule
  //     //check for * first
     if(arrayNum[i]=="*"){
      a=i-1;
      b=i+2;
     firstnum=arrayNum[i-1];
    secondnum= arrayNum[i+1]
     product= firstnum * secondnum   
    
   arrayNum.splice(a,b);
   arrayNum.splice(a,0,product)
  
    }  
    if(arrayNum[i]=="/"){
      a=i-1;
      b=i+2;
     firstnum=arrayNum[i-1];
    secondnum= arrayNum[i+1]
     quotient= firstnum / secondnum   
    
   arrayNum.splice(a,b);
   arrayNum.splice(a,0,quotient)
  
    }
   if(arrayNum[i]=="+"){
      a=i-1;
      b=i+2;

    firstnum=arrayNum[i-1];
    secondnum= arrayNum[i+1]
    sum= Number(firstnum) + Number(secondnum)   
    
   arrayNum.splice(a,b);
   arrayNum.splice(a,0,sum)
  
    }
   if(arrayNum[i]=="-"){
      a=i-1;
      b=i+2;
     firstnum=arrayNum[i-1];
    secondnum= arrayNum[i+1]
     difference= Number(firstnum) - Number(secondnum)   
    
   arrayNum.splice(a,b);
   arrayNum.splice(a,0,difference)
    }

   }
  
 }
 answerScreen.textContent=arrayNum
  }
  


  
//operation following MDAS rule

function multiply(a, b){ c= Number(a) * Number(b); return c}
function divide(a, b){ return a / b;}
function add(a, b){ return a + b;}
function substract(a, b){ return a - b;}
