void tablero(){
for(a=0 ; a<8 ; a++){
 for(b=0 ; b<8 ; b=b+1){
  if((a+b) % 2==0){
   fill(255);
  }else{fill(0);}
 rect(b*50,a*50,50,50);
  }
 }
 fill(#AFAAAA);rect(400,0,200,400);
}
