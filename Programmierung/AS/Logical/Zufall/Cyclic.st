
PROGRAM _CYCLIC
	IF zufallscocktail_var = FALSE THEN
			//willk�rliches Verrechnen zum Erstellen eines Zufalls	
			Random_Number[01] := (Random_Number[01] + 73) * ((Random_Number[17] + 1) MOD 14);
			Random_Number[02] := (Random_Number[09] + 73) * ((Random_Number[12] + 1) MOD 16);
			Random_Number[03] := (Random_Number[13] + 73) * ((Random_Number[20] + 1) MOD 11);
			Random_Number[04] := (Random_Number[18] + 73) * ((Random_Number[09] + 1) MOD 17);
			Random_Number[05] := (Random_Number[08] + 73) * ((Random_Number[16] + 1) MOD 19);
			Random_Number[06] := (Random_Number[20] + 72) * ((Random_Number[09] + 1) MOD 13);
			Random_Number[07] := (Random_Number[07] + 73) * ((Random_Number[01] + 1) MOD 17);
			Random_Number[08] := (Random_Number[11] + 73) * ((Random_Number[18] + 1) MOD 18);
			Random_Number[09] := (Random_Number[19] + 73) * ((Random_Number[12] + 1) MOD 11);
			Random_Number[10] := (Random_Number[12] + 73) * ((Random_Number[07] + 1) MOD 16);
			Random_Number[11] := (Random_Number[04] + 73) * ((Random_Number[02] + 1) MOD 10);
			Random_Number[12] := (Random_Number[03] + 73) * ((Random_Number[10] + 1) MOD 19);
			Random_Number[13] := (Random_Number[16] + 73) * ((Random_Number[15] + 1) MOD 18);
			Random_Number[14] := (Random_Number[06] + 73) * ((Random_Number[14] + 1) MOD 17);
			Random_Number[15] := (Random_Number[15] + 73) * ((Random_Number[04] + 1) MOD 15);
			Random_Number[16] := (Random_Number[05] + 73) * ((Random_Number[05] + 1) MOD 10);
			Random_Number[17] := (Random_Number[10] + 73) * ((Random_Number[06] + 1) MOD 18);
			Random_Number[18] := (Random_Number[14] + 73) * ((Random_Number[03] + 1) MOD 14);
			Random_Number[19] := (Random_Number[17] + 73) * ((Random_Number[19] + 1) MOD 19);
			Random_Number[20] := (Random_Number[02] + 73) * ((Random_Number[11] + 1) MOD 16);

		//festlegen, welche nicht-alkoholischen Zutaten verwendet werden
			FOR i := 1 TO 5 DO									//ZutatJaNein setzen f�r nicht-alkoholische, Z�hlen
				IF Random_Number[i] MOD 3 = 0 THEN				//durch MOD 3 h�ufiger als alkoholische    
					zutat_JaNein[i] := TRUE;
					Number_Counter[i] := Number_Counter[i] + 1;
				ELSE
					zutat_JaNein[i] := FALSE;
				END_IF	
			END_FOR;

		//festlegen, welche alkoholischen Zutaten verwendet werden
			FOR i := 6 TO 10 DO									//Zutatjanein setzen f�r alkoholische, Z�hlen
				IF Random_Number[i] MOD 7 = 0 THEN				//durch MOD 7 weniger h�ufig als nich-alkoholische
					zutat_JaNein[i] := TRUE;		
					Number_Counter[i] := Number_Counter[i] + 1;
				ELSE
					zutat_JaNein[i] := FALSE;
				END_IF	
			END_FOR;
			
			ml := 30;		//Menge zur�cksetzen
			ml_ausgabe := 0; //Ausgabemenge zur�cksetzen
			FOR i := 1 TO 10 DO		//Mengenarray zur�cksetzen
				zutat_Menge[i] := 0;	
			END_FOR;
			
			REPEAT 			//Festlegen der Getr�nkemengen, zweimal durchgehen
				//�ber Modulo Werte aufnehmen, Multiplizieren und in zutat_Menge Array schreiben
				IF n MOD 2 = 0 THEN		//es wird immer zwischen den einstelligen und zweistelligen Zufallszahlen gewechselt
					p := 10;
				ELSIF n MOD 3 = 0 THEN
					r := 87;		//alles mit r ist nur, um etwas mehr Zufall zu erzeugen
				ELSE	
					p := 0;
					r := 0;
				END_IF
				//Mengen durch unterschiedliche Modulo unterschiedlich festlegen	
				FOR i := 1 TO 5 DO		
					IF zutat_JaNein[i] = TRUE THEN
					k := (Random_Number[i+p]+r) MOD (ml/2);		//mit �briger Menge modulo rechnen, sodass maximale Menge nie �berschritten wird
						zutat_Menge[i] := zutat_Menge[i] + k * 10;
						ml := ml - k;
						access_counter := access_counter + 1;		//nur Informationsgewinnung
					END_IF
				END_FOR;
				FOR i := 6 TO 10 DO
					IF zutat_JaNein[i] = TRUE THEN
						m := ml/5;		
						k := (Random_Number[i+p]+r) MOD (m);
						zutat_Menge[i] := zutat_Menge[i] + k * 10;
						ml := ml - k;
						access_counter := access_counter + 1;		//nur Informationsgewinnung
					END_IF
				END_FOR;
				n := n + 1;		//Durchl�ufe der Schleife z�hlen

				UNTIL
				ml <= 3 OR n > 20 // Die Schleife wird verlassen, wenn ml <= 3 oder wenn zu viele Iterationen stattfinden
			END_REPEAT;
			n := 0;
		
			//zu allen Zutatenmengen gleichm��ig etwas addieren, sodass Menge erf�llt wird
			REPEAT    
				FOR i := 10 TO 1 BY -1 DO
					IF i < 6 THEN 
						q := 2;
					ELSE 
						q := 1;
					END_IF
					IF ml > 1 AND zutat_JaNein[i] = TRUE THEN
						zutat_Menge[i] := zutat_Menge[i] + q*10;
						ml := ml - q;
					END_IF
				END_FOR
				n:= n + 1;
				UNTIL ml <= 1 OR n > 20
			END_REPEAT;
		
			//Gesamtmenge zur Informationsgewinnung
			FOR i:= 1 TO 10 DO		
				ml_ausgabe := ml_ausgabe + zutat_Menge[i];
			END_FOR;
		END_IF
		menge_alkohol := 0;	
		menge_alkoholfrei := 0;
	
		//Menge nicht-alkoholischer Getr�nke ermitteln
		FOR i := 1 TO 5 DO
			menge_alkoholfrei := menge_alkoholfrei + zutat_Menge[i];
		END_FOR
	
		//Menge alkoholischer Getr�nke ermitteln
		FOR i := 6 TO 10 DO
			menge_alkohol := menge_alkohol + zutat_Menge[i];
		END_FOR
		
		//Mengen werden nur in weiterverwendete Arrays geschrieben, Getr�nk den Kriterien entspricht
		IF menge_alkohol <= 270 AND menge_alkoholfrei <= 270 AND (menge_alkohol + menge_alkoholfrei) > 270 THEN
			FOR i := 1 TO 10 DO
				zutat_Menge_ok[i] := zutat_Menge[i];
				zutat_JaNein_ok[i] := zutat_JaNein[i];
			END_FOR;
		END_IF
	
		cycle_counter := cycle_counter + 1;		//nur zur Informationsgewinnung
END_PROGRAM
