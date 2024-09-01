
let Color =  '#333333'
let Mode = 'color'
let size =  16


function populate(size){
  let container=document.querySelector("#container");
  let squares=container.querySelectorAll('div');
  squares.forEach((div)=>div.remove());
 

  container.style.gridTemplateColumns=`repeat(${size} , 1fr)`;
  container.style.gridTemplateRows=`repeat(${size} , 1fr)`;
  
  let gridsize=size*size;
 
  for(i=0; i < gridsize; i++){
   let square = document.createElement("div");  
   square.classList.add("grids");
  square.addEventListener('mouseover', colorChange)
  square.addEventListener('mousedown', colorChange)
  
  square.style.backgroundColor="white";

 
   //divs.style.borderColor="black";
   container.insertAdjacentElement("beforeend", square);
  
   container.appendChild(square); 
  }
}
populate(size);




function sizeChange(input){
  if(input >=2 || input<=100){
populate(input);
}
else alert("Grid size limit:100");
}

function reloadGrid() {
  size= document.getElementById("changeSize").value;
 
  populate(size)
 }
 
 let mouseDown = false
 document.body.onmousedown = () => (mouseDown = true)
 document.body.onmouseup = () => (mouseDown = false)
 
const colorPicker = document.getElementById('colorPicker');
const colorBtn = document.getElementById('colorBtn');
const rainbowBtn = document.getElementById('rainbowBtn');
const eraserBtn = document.getElementById('eraserBtn');
const clearBtn = document.getElementById('clearBtn');

colorPicker.oninput = (e) => setColor(e.target.value);
colorBtn.onclick = () => activate('color');
rainbowBtn.onclick = () => activate('rainbow');
eraserBtn.onclick = () => activate('eraser');
clearBtn.onclick = () => reloadGrid()



function activate(activatedMode){
  activateButton(activatedMode);
  Mode=activatedMode;
}

function setColor(newColor) {
  Color = newColor
}





function activateButton(activatedMode) {
  if (Mode === 'rainbow') {
    rainbowBtn.style.backgroundColor="#ccc"
  } else if (Mode === 'color') {
    colorBtn.style.backgroundColor="#ccc"
  } else if (Mode === 'eraser') {
    eraserBtn.style.backgroundColor="#ccc"
  }

  if (activatedMode === 'rainbow') {
    rainbowBtn.classList.add('active')
    rainbowBtn.style.backgroundColor="#334173"
  } else if (activatedMode === 'color') {
    colorBtn.style.backgroundColor="#334173"
  } else if (activatedMode === 'eraser') {
    eraserBtn.style.backgroundColor="#334173"
  }
}

function colorChange(e){
  if (e.type === 'mouseover' && !mouseDown) return
  if (Mode === 'rainbow') {
    const randomR = Math.floor(Math.random() * 256)
    const randomG = Math.floor(Math.random() * 256)
    const randomB = Math.floor(Math.random() * 256)
    e.target.style.backgroundColor = `rgb(${randomR}, ${randomG}, ${randomB})`
  } else if (Mode === 'color') {
    e.target.style.backgroundColor = Color
  } else if (Mode === 'eraser') {
    e.target.style.backgroundColor = 'white'
  }
  
}





