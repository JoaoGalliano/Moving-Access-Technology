/*
Configuração inicial do sensor TCRT5000
*/
 
int switch_pin = 7;

void setup() 
{
  Serial.begin(9600);
  pinMode(switch_pin, INPUT);
}
 
void loop() 
{
  if(digitalRead(switch_pin) == LOW){
    Serial.println(1);
  }
  else {
    Serial.println(0);
  }
 delay(1000);
}
