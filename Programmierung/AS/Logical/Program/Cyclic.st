PROGRAM _CYCLIC
	// Visualisierungs Passworteingabe
	IF passwordVisu_st = "student42" THEN
		passwordVisuCorrect_var := TRUE;
	ELSE
		passwordVisuCorrect_var := FALSE;
	END_IF

		
	
	IF ERROR_DI = TRUE THEN
		// ON ERROR STOPPT ALLE PUMPEN DIREKT
		pumpeBig1_DO := FALSE;
		pumpeBig2_DO := FALSE;
		pumpeBig3_DO := FALSE;
		pumpeBig4_DO := FALSE;
		pumpeSmall1_DO := FALSE;
		pumpeSmall2_DO := FALSE;
		pumpeSmall3_DO := FALSE;
		pumpeSmall4_DO := FALSE;
		pumpeSmall5_DO := FALSE;
		pumpeSmall6_DO := FALSE;
		
		directionTreadmillright_DO := FALSE;
		directionThreadmillleft_DO := FALSE;
	ELSE
		// Reinigungsprogramm
		IF reingigunsmodus_var = TRUE THEN
			IF directionThreadmill_left_var = TRUE THEN
				directionThreadmillleft_DO := 0;
				directionTreadmillright_DO := 1;
			END_IF
			IF directionThreadmill_right_var = TRUE THEN
				directionThreadmillleft_DO := 1;
				directionTreadmillright_DO := 0;
			END_IF
			IF directionThreadmill_right_var = FALSE AND directionThreadmill_left_var = FALSE THEN
				directionThreadmillleft_DO := 0;
				directionTreadmillright_DO := 0;
			END_IF
			
			
		ELSE
			CASE currentStation_var OF
				stationBecherspender_var:
					// Setzt Website wieder auf Hauptseite nach erfolgten Durchlauf
					IF inductiveSensorBecherspender_DI = FALSE OR counterBecherspender_var > 0 THEN
						IF currentBecherausgabeState_var = 3 THEN
							goToMainpage_var := TRUE;
							resetCounter_var := 0;
							currentBecherausgabeState_var := 0;	
						END_IF
						
						directionThreadmillleft_DO := 0;
						counterBecherentnahme_var := 0;
						IF cocktailChosen_var = TRUE THEN
							goToMainpage_var := FALSE;
							currentBecherausgabeState_var := 0;
							counterBecherspender_var := counterBecherspender_var + 1;
							
							stationPercentage_var := 10;

							IF counterBecherspender_var = 1 THEN
								BecherspenderAktivieren_DO := TRUE;
							ELSE
								BecherspenderAktivieren_DO := FALSE;
							END_IF
							
							IF bechererkennungSpender_DI = TRUE THEN
								directionTreadmillright_DO := 1;
								currentStation_var := currentStation_var + 1;
								BecherspenderAktivieren_DO := FALSE;
								stationPercentage_var := 20;
							END_IF
						END_IF
					END_IF			
					
				stationEismaschine_var:
					IF inductiveSensorEisstation_DI = FALSE OR counterEisstation_var > 0 THEN
						directionTreadmillright_DO := 0;
						counterBecherspender_var := 0;
						counterEisstation_var := counterEisstation_var + 1;
						stationPercentage_var := 30;
						
						// 300 ms impuls for Arduino bei Anfahren der Station
						IF counterEisstation_var < 4 THEN
							eisspenderAktivieren_DO := TRUE;
						ELSE
							eisspenderAktivieren_DO := FALSE;
						END_IF
							
						// Wenn die Lichtschrankenrückmeldung kommt
						IF lichtschrankeEismaschine_DI = TRUE AND hilfsCounterEismaschine_var = 0 AND counterEisstation_var > 5 THEN
							hilfsCounterEismaschine_var := counterEisstation_var + 30;
						END_IF
						
						// Wenn der Wagen an der Station für 15 Sekunden steht oder das Signal vom Arduino kommt, das Lichtschranke ausgelöst wurde
						IF counterEisstation_var > 3000 OR hilfsCounterEismaschine_var <= counterEisstation_var AND hilfsCounterEismaschine_var <> 0 THEN
							directionTreadmillright_DO := 1;
							currentStation_var := currentStation_var + 1;
							stationPercentage_var := 40;
						END_IF
					END_IF
								
				stationZitronenspender_var:
					IF inductiveSensorZitronenspende_DI = FALSE OR counterZitronenspender_var > 0 THEN
						hilfsCounterEismaschine_var := 0;
						directionTreadmillright_DO := 0;
						counterEisstation_var := 0;
						counterZitronenspender_var := counterZitronenspender_var + 1;
						stationPercentage_var := 50;
						
						// 400 ms impuls for arduino
						IF counterZitronenspender_var < 4 THEN
							zitronenspenderAktivieren_DO := TRUE;
						ELSE
							zitronenspenderAktivieren_DO := FALSE;
						END_IF
							
						IF counterZitronenspender_var > 50 THEN
							directionTreadmillright_DO := 1;
							currentStation_var := currentStation_var + 1;
							stationPercentage_var := 60;
						END_IF
					END_IF
													
				stationCocktailmixer_var:
					IF inductiveSensorCocktailmixer_DI = FALSE OR counterCocktailmixer_var > 0 THEN
						directionTreadmillright_DO := 0;
						counterZitronenspender_var := 0;
						counterCocktailmixer_var := counterCocktailmixer_var + 1;
						
						
						CASE currentCocktialState_var OF
							0:
								// Arm fährt runter --> Signal Arduino
								IF counterCocktailmixer_var > 3 THEN
									armCocktailstation_DO := TRUE;
									currentCocktialState_var := currentCocktialState_var + 1;
									stationPercentage_var := 70;
								END_IF
							1:
								// Setzt Arduino Signal wieder auf 0
								IF counterCocktailmixer_var > 7 THEN;
									armCocktailstation_DO := FALSE;
									currentCocktialState_var := currentCocktialState_var + 1;
								END_IF
	
							2: 
								// Startet Cocktail, wenn Endlagenschalter Anschlägt
								IF counterCocktailmixer_var >= 30 AND endlagenschArmCocktailStation_DI = TRUE THEN
									cocktail_started := FALSE;
									currentCocktialState_var := currentCocktialState_var + 1;
								END_IF
							3:
								//	IF cocktailFinished_var = TRUE THEN
								IF counterCocktailmixer_var >= 50 AND pumpeBig1_DO = 0 AND pumpeBig2_DO = 0 AND pumpeBig3_DO = 0 AND pumpeBig4_DO = 0 AND pumpeSmall1_DO = 0 AND pumpeSmall2_DO = 0 AND pumpeSmall3_DO = 0 AND pumpeSmall4_DO = 0 AND  pumpeSmall5_DO = 0 AND  pumpeSmall6_DO = 0 THEN
									stationPercentage_var := 80;
									cocktailFinished_var := TRUE; 
									
									hilfsDelayArmCocktailStation_var := counterCocktailmixer_var + 5;
									currentCocktialState_var := currentCocktialState_var + 1;
								END_IF
							4:
								// Delay nach dem die Pumpen abgeschalten haben 500ms
								IF counterCocktailmixer_var >= hilfsDelayArmCocktailStation_var AND armCocktailstation_DO = FALSE THEN
									armCocktailstation_DO := TRUE;
									hilfsDelayArmCocktailStation_var :=  counterCocktailmixer_var + 4;
									currentCocktialState_var := currentCocktialState_var + 1;
								END_IF
							5:
								// 400 ms Signal auf den Ausgang beenden
								IF counterCocktailmixer_var >= hilfsDelayArmCocktailStation_var AND armCocktailstation_DO = TRUE THEN
									stationPercentage_var := 90;
									armCocktailstation_DO := FALSE;
									hilfsDelayArmCocktailStation_var := counterCocktailmixer_var + 16;
									currentCocktialState_var := currentCocktialState_var + 1;
								END_IF
							6:
								// geht zur nächsten Station nachdem der arm 1.6 Sekunden Zeit hatte hochzufahren
								IF 	counterCocktailmixer_var >= hilfsDelayArmCocktailStation_var AND stationPercentage_var = 90 THEN 
									directionTreadmillright_DO := TRUE;
									currentStation_var := currentStation_var + 1;
									currentCocktialState_var := 0;
								END_IF
						END_CASE
					END_IF								
		
				stationBecherentnahme_var:
					CASE currentBecherausgabeState_var OF
						0: // Stoppt an Station 
							IF inductiveSensorBecherausgabe_DI = FALSE OR bechererkennungAusgabe_DI = TRUE THEN
								counterCocktailmixer_var := 0;
								currentBecherausgabeState_var := 1;
								cocktailFinished_var := 0;
								stationPercentage_var := 100;
								directionTreadmillright_DO := 0;
								delayCocktailStation_var := 0;
							END_IF
						
						1:// Wenn Becher steht
							// drei Sekunden verzögerung zum verlässlichen erkennen des Endlagenschalters
							IF counterBecherentnahme_var >= 30 THEN 
								// Erkennt wenn Becher Ausgegeben wurde --> Wird als zweites ausgeführt
								IF bechererkennungAusgabe_DI = FALSE THEN
									currentBecherausgabeState_var := 2;
								END_IF
							ELSE
								counterBecherentnahme_var := counterBecherentnahme_var + 1;
							END_IF

						2: 
							// Zählt Für Verzögerung beim herausnehmen 
							IF counterBecherentnahme_var > 0 THEN
								counterBecherentnahme_var := counterBecherentnahme_var + 1; 
							END_IF
							
							// Fährt mit verzögerung wieder zum Start
							IF counterBecherentnahme_var >= 60 THEN
								directionTreadmillright_DO := 0;
								directionThreadmillleft_DO := 1;	
								currentStation_var := 0;
								cocktailChosen_var := FALSE;	
								currentBecherausgabeState_var := 3;
							END_IF
					END_CASE
			END_CASE
		END_IF

		// Zurücksetzen auf Start
		IF resetToStart_var = TRUE THEN 
			IF resetCounter_var < 10 THEN
				resetCounter_var := resetCounter_var + 1;
				pumpeBig1_DO := FALSE;
				pumpeBig2_DO := FALSE;
				pumpeBig3_DO := FALSE;
				pumpeBig4_DO := FALSE;
				pumpeSmall1_DO := FALSE;
				pumpeSmall2_DO := FALSE;
				pumpeSmall3_DO := FALSE;
				pumpeSmall4_DO := FALSE;
				pumpeSmall5_DO := FALSE;
				pumpeSmall6_DO := FALSE;
				
				counterBecherspender_var := 0;
				counterEisstation_var := 0;
				counterZitronenspender_var := 0;
				counterCocktailmixer_var := 0;
				
				directionThreadmillleft_DO := 0;
				
				// Fährt nich weiter, wenn hinten der Taster gedrückt wird
				IF bechererkennungAusgabe_DI = FALSE THEN
					directionTreadmillright_DO := 1;
				ELSE
					directionTreadmillright_DO := 0;
				END_IF
			ELSE
				directionTreadmillright_DO := 0;
				currentStation_var := 4; 
				currentBecherausgabeState_var := 2;
				counterBecherentnahme_var := 100;
	
				resetToStart_var := FALSE;
			END_IF
		END_IF
	END_IF
END_PROGRAM
