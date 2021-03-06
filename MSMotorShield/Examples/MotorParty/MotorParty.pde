// MakeShields Motor shield library
// copyright MakeShields, 2010
// this code is public domain, enjoy!

#include <MSMotorShield.h>
#include <Servo.h>

// DC motor on M2
MS_DCMotor motor(2);
// DC hobby servo
Servo servo1;
// Stepper motor on M3+M4 48 steps per revolution
MS_Stepper stepper(48, 2);

void setup() {
  Serial.begin(9600);           // set up Serial library at 9600 bps
  Serial.println("Motor party!");
  
  // turn on servo
  servo1.attach(9);
   
  // turn on motor #2
  motor.setSpeed(200);
  motor.run(RELEASE);
}

int i;

// Test the DC motor, stepper and servo ALL AT ONCE!
void loop() {
  motor.run(FORWARD);
  for (i=0; i<255; i++) {
    servo1.write(i);
    motor.setSpeed(i);  
    stepper.step(1, FORWARD, INTERLEAVE);
    delay(3);
 }
 
  for (i=255; i!=0; i--) {
    servo1.write(i-255);
    motor.setSpeed(i);  
    stepper.step(1, BACKWARD, INTERLEAVE);
    delay(3);
 }
 
  motor.run(BACKWARD);
  for (i=0; i<255; i++) {
    servo1.write(i);
    motor.setSpeed(i);  
    delay(3);
    stepper.step(1, FORWARD, DOUBLE);
 }
 
  for (i=255; i!=0; i--) {
    servo1.write(i-255);
    motor.setSpeed(i);  
    stepper.step(1, BACKWARD, DOUBLE);
    delay(3);
 }
}
