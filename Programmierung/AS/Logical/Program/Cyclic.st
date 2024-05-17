PROGRAM _CYCLIC
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
					IF inductiveSensorBecherspender_DI = FALSE OR counterBecherspender_var > 0 OR BecherAusgabe_var = 3 THEN
						directionThreadmillleft_DO := 0;
						BecherAusgabe_var := 3; 
						
						IF cocktailChosen_var = TRUE THEN
							BecherAusgabe_var := 0;
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
						
						// 300 ms impuls for arduino
						IF counterEisstation_var < 4 THEN
							eisspenderAktivieren_DO := TRUE;
						ELSE
							eisspenderAktivieren_DO := FALSE;
						END_IF

						IF counterEisstation_var > 100 THEN
							directionTreadmillright_DO := 1;
							currentStation_var := currentStation_var + 1;
							stationPercentage_var := 40;
						END_IF
					END_IF
								
				stationZitronenspender_var:
					IF inductiveSensorZitronenspende_DI = FALSE OR counterZitronenspender_var > 5 THEN
						directionTreadmillright_DO := 0;
						counterEisstation_var := 0;
						counterZitronenspender_var := counterZitronenspender_var + 1;
						stationPercentage_var := 50;
						
						// 300 ms impuls for arduino
						IF counterZitronenspender_var < 20 THEN
							zitronenspenderAktivieren_DO := TRUE;
						ELSE
							zitronenspenderAktivieren_DO := FALSE;
						END_IF
							
						IF counterZitronenspender_var > 0 THEN
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
						stationPercentage_var := 70;
						
						// IF first time on station
						IF counterCocktailmixer_var < 3 THEN
							cocktail_started := FALSE;
						END_IF
						
						//	IF cocktailFinished_var = TRUE THEN
						IF counterCocktailmixer_var > 3 AND pumpeBig1_DO = 0 AND pumpeBig2_DO = 0 AND pumpeBig3_DO = 0 AND pumpeBig4_DO = 0 AND pumpeSmall1_DO = 0 AND pumpeSmall2_DO = 0 AND pumpeSmall3_DO = 0 AND pumpeSmall4_DO = 0 AND  pumpeSmall5_DO = 0 AND  pumpeSmall6_DO = 0 THEN
							stationPercentage_var := 90;
							cocktailFinished_var := TRUE; 
							delayCocktailStation_var := delayCocktailStation_var + 1;
						END_IF
						
						IF delayCocktailStation_var > 15  AND stationPercentage_var = 90 THEN 
							directionTreadmillright_DO := TRUE;
							currentStation_var := currentStation_var + 1;
						END_IF
					END_IF								
		
				stationBecherentnahme_var:
					IF BecherAusgabe_var = 0 THEN
						counterCocktailmixer_var := 0;
						directionTreadmillright_DO := 1;
					END_IF
					
					IF inductiveSensorBecherausgabe_DI = FALSE THEN
						BecherAusgabe_var := 1;
						cocktailFinished_var := 0;
						stationPercentage_var := 100;
					END_IF
					
					IF BecherAusgabe_var = 1 THEN
						directionTreadmillright_DO := 0;
					END_IF
					
					// When Button gets clicked and Station got reached, go back to first station, im letzten Zyklus muss der Schalter True sein
					IF bechererkennungAusgabe_DI = FALSE AND bechererkennungLetzerZyklus = TRUE THEN
						BecherAusgabe_var := 2;
						counterBecherentnahme_var := 0;
						bechererkennungLetzerZyklus := FALSE;
					END_IF
					// SETZT den letzten Zyklus 
					IF bechererkennungAusgabe_DI = TRUE THEN
						bechererkennungLetzerZyklus := TRUE;
					END_IF
					
					IF BecherAusgabe_var = 2 THEN
						counterCocktailmixer_var := 0;
						directionTreadmillright_DO := 0;
						directionThreadmillleft_DO := 1;	
						currentStation_var := 0;
						cocktailChosen_var := FALSE;	
					END_IF
			END_CASE
		END_IF

		// Zurücksetzen auf Start
		IF resetToStart_var = TRUE THEN 
			currentStation_var := 4; 
			BecherAusgabe_var := 2;
			
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

			resetToStart_var := FALSE;
		END_IF
	END_IF
	
END_PROGRAM
