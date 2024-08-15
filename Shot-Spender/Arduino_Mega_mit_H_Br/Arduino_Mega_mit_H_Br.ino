#include <Adafruit_SSD1306.h>
#include <Adafruit_GFX.h>
#include <Adafruit_NeoPixel.h>
#include <Servo.h>
#include <Keypad.h>

// Keypad-Konfiguration
const byte COLS = 4;
const byte ROWS = 4;
char hexaKeys[ROWS][COLS] = {
  {'D', '#', '0', '*'},
  {'C', '9', '8', '7'},
  {'B', '6', '5', '4'},
  {'A', '3', '2', '1'}
};
byte colPins[COLS] = {2, 3, 4, 5};
byte rowPins[ROWS] = {6, 7, 8, 9};
char Taste;
Keypad Tastenfeld = Keypad(makeKeymap(hexaKeys), rowPins, colPins, ROWS, COLS);

// OLED-Display-Konfiguration
#define OLED_RESET -1
#define SCREEN_HEIGHT 32
#define SCREEN_WIDTH 128
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

// Pin-Definitionen
#define CALIBRATE_BUTTON_PIN 11 
#define NUM_BECHERS 6
#define NUM_PUMPS 4
#define SERVO_PIN 12 
#define NEOPIXEL_PIN 10 
#define NUM_LEDS 24

// Pins für Lichtsensoren
#define LIGHT_SENSOR1_PIN A0
#define LIGHT_SENSOR2_PIN A1
#define LIGHT_SENSOR3_PIN A2
#define LIGHT_SENSOR4_PIN A3
#define LIGHT_SENSOR5_PIN A4
#define LIGHT_SENSOR6_PIN A5

// Pins für Pumpensteuerung
#define PUMP1_DIR_PIN 26
#define PUMP1_PWM_PIN 27
#define PUMP2_DIR_PIN 28
#define PUMP2_PWM_PIN 29
#define PUMP3_DIR_PIN 30
#define PUMP3_PWM_PIN 31
#define PUMP4_DIR_PIN 32
#define PUMP4_PWM_PIN 33

#define PUMP_TIME 300
#define PUMP_REVERSE_TIME 100

// Globale Variablen
int selectedBechers = 0;
int selectedPump = 0;
Servo pumpServo;
Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LEDS, NEOPIXEL_PIN, NEO_GRB + NEO_KHZ800);
int lightThreshold = 500;

void setup() {
  Serial.begin(115200);

  pinMode(CALIBRATE_BUTTON_PIN, INPUT_PULLUP);

  for (int i = 0; i < NUM_PUMPS; i++) {
    pinMode(PUMP1_DIR_PIN + i * 2, OUTPUT);
    pinMode(PUMP1_PWM_PIN + i * 2, OUTPUT);
    digitalWrite(PUMP1_DIR_PIN + i * 2, LOW);
    analogWrite(PUMP1_PWM_PIN + i * 2, 0);
  }

  if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {
    Serial.println(F("SSD1306 allocation failed"));
    for(;;);
  }
  // Display Initialisierung zusammenhalten
  display.display(); // braucht es das
  delay(2000); // braucht es das
  display.clearDisplay(); 
  display.display(); //Braucht es das?

  pumpServo.attach(SERVO_PIN);

  // LED Strip
  strip.begin();
  strip.show();

  updateDisplay();
}

void loop() {
  Taste = Tastenfeld.getKey();
  if (Taste) {
    handleKeypadInput(Taste);
  }

  if (digitalRead(CALIBRATE_BUTTON_PIN) == LOW) {
    calibrateSensors();
    delay(1000);
  }

  checkBechers();
  
  if (allBechersPresent()) {
    fillBechers();
  }
}

// Verarbeitung der Tastatureingaben
void handleKeypadInput(char key) {
  switch (key) {
    // Anzahl der Becher
    case '1': case '2': case '3': case '4': // Zu wenig cases
      selectedBechers = key - '0';
      updateDisplay();
      delay(300);
      break;
    
    // Likör sorte
    case 'A': case 'B': case 'C': case 'D':
      selectedPump = key - 'A' + 1;
      updateDisplay();
      delay(300);
      break;
  }
}

// Aktualisierung des Displays
void updateDisplay() {
  display.clearDisplay(); // Bildschirm löschen
  display.setTextSize(5); // Textgröße für die Becheranzahl setzen
  display.setTextColor(WHITE); // Textfarbe auf Weiß setzen

  // Becheranzahl anzeigen
  display.setCursor(0, 0); // Cursor auf obere linke Ecke setzen
  display.print(selectedBechers); // Anzahl der ausgewählten Becher drucken

  // Pumpennummer anzeigen
  display.setTextSize(3); // Textgröße für die Pumpennummer setzen
  display.setCursor(0, 25); // Cursor auf eine neue Zeile setzen
  display.print((char)('A' + selectedPump - 1)); // Buchstabe der ausgewählten Pumpe drucken

  display.display(); // Display aktualisieren
}

// Überprüfung der Becher
void checkBechers() {
  int becherCount = 0;
  for (int i = 0; i < NUM_BECHERS; i++) {
    int sensorValue = analogRead(LIGHT_SENSOR1_PIN + i);
    if (sensorValue < lightThreshold) {
      becherCount++;
      setHolderColor(i, 0, 255, 0);
    } else {
      setHolderColor(i, 255, 0, 0);
    }
  }
  strip.show();
}

// Überprüfung, ob alle Becher vorhanden sind
bool allBechersPresent() {
  int becherCount = 0;
  for (int i = 0; i < NUM_BECHERS; i++) {
    if (analogRead(LIGHT_SENSOR1_PIN + i) < lightThreshold) {
      becherCount++;
    }
  }
  return (becherCount == selectedBechers);
}

// Aktivierung der Pumpe
void activatePump(int pump, bool reverse = false) {
  int dirPin = PUMP1_DIR_PIN + (pump - 1) * 2;
  int pwmPin = PUMP1_PWM_PIN + (pump - 1) * 2;
  digitalWrite(dirPin, reverse ? LOW : HIGH);
  analogWrite(pwmPin, 255);
}

// Deaktivierung der Pumpe
void deactivatePump(int pump) {
  int pwmPin = PUMP1_PWM_PIN + (pump - 1) * 2;
  analogWrite(pwmPin, 0);
}

// Füllen der Becher
void fillBechers() {
  if (selectedBechers > 0 && selectedPump > 0) {
    int angleStep = 180 / NUM_BECHERS;
    for (int i = 0; i < selectedBechers; i++) {
      pumpServo.write(i * angleStep);
      delay(500);
      activatePump(selectedPump);
      delay(PUMP_TIME);
      deactivatePump(selectedPump);
      activatePump(selectedPump, true);
      delay(PUMP_REVERSE_TIME);
      deactivatePump(selectedPump);
      delay(500);
    }
  }
}

// Einstellung der LED-Farbe für die Halterung
void setHolderColor(int holderIndex, uint8_t red, uint8_t green, uint8_t blue) {
  int ledIndex = holderIndex * 4;
  for (int i = 0; i < 4; i++) {
    strip.setPixelColor(ledIndex + i, strip.Color(red, green, blue));
  }
}

// Kalibrierung der Sensoren
void calibrateSensors() {
  Serial.println("Kalibriere Sensoren...");
  int maxSensorvalue = 0;
  for (int i = 0; i < NUM_BECHERS; i++) {
    int sensorValue = analogRead(LIGHT_SENSOR1_PIN + i);
    if (sensorValue > maxSensorvalue) {
      maxSensorvalue = sensorValue;
    }
    Serial.print("Sensor ");
    Serial.print(i);
    Serial.print(" - Wert: ");
    Serial.println(sensorValue);
    delay(500);
  }
  lightThreshold = maxSensorvalue - 10;
  Serial.println("Kalibrierung abgeschlossen.");
  Serial.print("Neuer Schwellenwert: ");
  Serial.println(lightThreshold);
}


