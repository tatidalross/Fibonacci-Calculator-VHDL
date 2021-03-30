# Fibonacci Calculator VHDL
 Implementing a circuit in VHDL that calculates Fibonacci numbers

# read pdf

# algorithm 

#include "stdio.h"
void main()
{
  // Declaração de variáveis.
int x, y, temp, i, n;
 
i = 3;
x = 1;
y = 1;
 
printf("Digite n: ");
scanf("%d", &n);
  
while (i <= n){
 temp = x+y;
  x = y;
  y = temp;
  i ++;
};
result = y;
}

# FSM
![fsm](https://user-images.githubusercontent.com/23202165/112918886-4df46800-90dc-11eb-9aa9-7bbd1f6238bd.png)

# FSMD
![fsmd](https://user-images.githubusercontent.com/23202165/112918909-5d73b100-90dc-11eb-92f1-a6dd0d01a04e.png)

# ULA
![f2](https://user-images.githubusercontent.com/23202165/112918696-de7e7880-90db-11eb-9ab7-a0f8ce417535.png)
