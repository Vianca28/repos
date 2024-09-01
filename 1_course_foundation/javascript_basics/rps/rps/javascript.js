 
 var a="";
 var e=0;
 var f=0;
 var w="";
 var c=0;
var playerSelection=0;
var computerSelection=0;
var bet=0;
var b="";


function getComputerChoice(){
 let randomNumber = Math.floor(Math.random()*3);
return randomNumber;
}

r1=0;  com=1; plays=2; tie=3;
function playRound(playerSelection, computerSelection) {
r1=+1;
  playerSelection=document.getElementById("finalbet").value;
  computerSelection = getComputerChoice();

 
if(computerSelection==0){
a="rock";} else if(computerSelection==1){  a="paper";}
else{  a="scissors";}


if(playerSelection==0){
p="rock";} else if(playerSelection==1){  p="paper";}
else{  p="scissors";}

  b=0;        

  if(computerSelection==playerSelection)
   {
    b=2; }

   else if(playerSelection ==2 || computerSelection==2){
    if(playerSelection==2 && computerSelection==0){      b=0;    }
    else  if(playerSelection==0 && computerSelection==2){      b=1;   }    
    else if(playerSelection==2 && computerSelection==1){      b=1;    }
    else  if(playerSelection==1 && computerSelection==2){      b=0;   }    
    }

    else if(computerSelection > playerSelection){
      b=0; 
    }
    else if(computerSelection < playerSelection){
      b=1;
    }   
  return b; 
  }
  

 
function game(){
  var d=0; res=""; result="";
  playerSelection=document.getElementById("finalbet").value;
computerSelection = getComputerChoice();

d=playRound();
if(d==2){
  alert("It's a tie!"); 
}
else if(d==0 || d==1 && d!=2){
c++;
playerSelection=document.getElementById("finalbet").value;
computerSelection = getComputerChoice();

if(computerSelection==0){
  a="rock";} else if(computerSelection==1){  a="paper";}
  else{  a="scissors";}
    
  if(playerSelection==0){
  p="rock";} else if(playerSelection==1){  p="paper";}
  else{  p="scissors";}
  d=playRound();

  if(d==2){c--;}
if(c==1 && d!=2){

 if(d==0){res="Computer"; e++;}
  else if(d==1){res="Player"; f++;}

  document.getElementsByTagName("td")[1].innerHTML=a; 
  document.getElementsByTagName("td")[2].innerHTML=p; 
  document.getElementsByTagName("td")[3].innerHTML=res;
  result="Round 1: "+res+" "+d
}

else if(c==2  && d!=2){

 if(d==0){res="Computer"; e++;}
  else if(d==1){res="Player"; f++;}

  else if(computerSelection>playerSelection){res="Computer";  e++;} 
  else if(computerSelection<playerSelection){ res="Player"; f++;}

     document.getElementsByTagName("td")[5].innerHTML=a; 
     document.getElementsByTagName("td")[6].innerHTML=p; 
   document.getElementsByTagName("td")[7].innerHTML=res;
   result="Round 2:"+res+" "+d
}

else if(c==3  && d!=2){
 if(d==0){res="Computer"; e++;}
  else if(d==1){res="Player"; f++;}
    
  else if(computerSelection>playerSelection){res="Computer";  e++;} 
  else if(computerSelection<playerSelection){ res="Player"; f++;}

  document.getElementsByTagName("td")[9].innerHTML=a; 
  document.getElementsByTagName("td")[10].innerHTML=p; 
document.getElementsByTagName("td")[11].innerHTML=res; 
result="Round 3:"+res+" "+d
}

else if(c==4  && d!=2){
 if(d==0){res="Computer"; e++;}
  else if(d==1){res="Player"; f++;}

  document.getElementsByTagName("td")[13].innerHTML=a; 
  document.getElementsByTagName("td")[14].innerHTML=p; 
document.getElementsByTagName("td")[15].innerHTML=res;
result="Round 4:"+res+" "+d
      
}

else if(c==5  && d!=2){
 if(d==0){res="Computer"; e++;}
  else if(d==1){res="Player"; f++;}

  document.getElementsByTagName("td")[17].innerHTML=a; 
  document.getElementsByTagName("td")[18].innerHTML=p; 
document.getElementsByTagName("td")[19].innerHTML=res;
  
if(c==5){
    if(e>f){ res="Computer";   }
    else if(e<f){  res="Player";  }
  
    document.getElementsByTagName("td")[20].innerHTML=res;  
}
result="Round 5: "+res+" "+d
}
//counter();
 }
console.log(result);
}



function play(){
  getComputerChoice();
 // counter();
 
  playRound();

    game();
  
 
}