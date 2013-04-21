#include <SoftwareSerial.h>
#define rxPin 2
#define txPin 3
#define unlockSeconds 2

// The tag database consists of two parts. The first part is an array of
// tag values with each tag taking up 5 bytes. The second is a list of
// names with one name for each tag (ie: group of 5 bytes).
char* allowedTags[] = {
  "4200443A41",         // Tag 1
  "420044234D",         // Tag 2
  "00365F88D8",
  "00365F8DD0",
  "00365F8A16",
};

// List of names to associate with the matching tag IDs
char* tagName[] = {
  "Button 1",      // Tag 1
  "Button 2",      // Tag 2
  "Ampule 1",
  "Ampule 2",
  "Ampule 3",
};

// Check the number of tags defined
int numberOfTags = sizeof(allowedTags)/sizeof(allowedTags[0]);

int incomingByte = 0;    // To store incoming serial data


SoftwareSerial rfid = SoftwareSerial( rxPin, txPin );
void setup() {
Serial.begin(9600); // connect to the serial port
rfid.begin(9600);
}

void loop() {
  byte i         = 0;
  byte val       = 0;
  byte checksum  = 0;
  byte bytesRead = 0;
  byte tempByte  = 0;
  byte tagBytes[6];    // "Unique" tags are only 5 bytes but we need an extra byte for the checksum
  char tagValue[10];

  // Read from the RFID module. Because this connection uses SoftwareSerial
  // there is no equivalent to the Serial.available() function, so at this
  // point the program blocks while waiting for a value from the module
  if((val = rfid.read()) == 2) {        // Check for header
    bytesRead = 0;
    while (bytesRead < 12) {            // Read 10 digit code + 2 digit checksum
      val = rfid.read();

      // Append the first 10 bytes (0 to 9) to the raw tag value
      if (bytesRead < 10)
      {
        tagValue[bytesRead] = val;
      }

      // Check if this is a header or stop byte before the 10 digit reading is complete
      if((val == 0x0D)||(val == 0x0A)||(val == 0x03)||(val == 0x02)) {
        break;                          // Stop reading
      }

      // Ascii/Hex conversion:
      if ((val >= '0') && (val <= '9')) {
        val = val - '0';
      }
      else if ((val >= 'A') && (val <= 'F')) {
        val = 10 + val - 'A';
      }

      // Every two hex-digits, add a byte to the code:
      if (bytesRead & 1 == 1) {
        // Make space for this hex-digit by shifting the previous digit 4 bits to the left
        tagBytes[bytesRead >> 1] = (val | (tempByte << 4));

        if (bytesRead >> 1 != 5) {                // If we're at the checksum byte,
          checksum ^= tagBytes[bytesRead >> 1];   // Calculate the checksum... (XOR)
        };
      } else {
        tempByte = val;                           // Store the first hex digit first
      };

      bytesRead++;                                // Ready to read next digit
    }

    // Send the result to the host connected via USB
    if (bytesRead == 12) {                        // 12 digit read is complete
      tagValue[10] = '\0';                        // Null-terminate the string

      Serial.print("Tag read: ");
      for (i=0; i<5; i++) {
        // Add a leading 0 to pad out values below 16
        if (tagBytes[i] < 16) {
          Serial.print("0");
        }
        Serial.print(tagBytes[i], HEX);
      }
      Serial.println();

      Serial.print("Checksum: ");
      Serial.print(tagBytes[5], HEX);
      Serial.println(tagBytes[5] == checksum ? " -- passed." : " -- error.");

      // Show the raw tag value
      //Serial.print("VALUE: ");
      //Serial.println(tagValue);

      // Search the tag database for this particular tag
      int tagId = findTag( tagValue );

      // Only fire the strike plate if this tag was found in the database
      if( tagId > 0 )
      {
        Serial.print("Authorized tag ID ");
        Serial.print(tagId);
        Serial.print(": unlocking for ");
        Serial.println(tagName[tagId - 1]);   // Get the name for this tag from the database
        unlock();                             // Fire the strike plate to open the lock
      } else {
        Serial.println("Tag not authorized");
      }
      Serial.println();     // Blank separator line in output
    }

    bytesRead = 0;
  }
}

void unlock() {
  Serial.println("Unlocked!!");
}

/**
 * Search for a specific tag in the database
 */
int findTag( char tagValue[10] ) {
  for (int thisCard = 0; thisCard < numberOfTags; thisCard++) {
    // Check if the tag value matches this row in the tag database
    if(strcmp(tagValue, allowedTags[thisCard]) == 0)
    {
      // The row in the database starts at 0, so add 1 to the result so
      // that the card ID starts from 1 instead (0 represents "no match")
      return(thisCard + 1);
    }
  }
  // If we don't find the tag return a tag ID of 0 to show there was no match
  return(0);
}
