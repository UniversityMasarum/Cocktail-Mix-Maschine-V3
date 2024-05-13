	// IF D11 equals ON -> Power on 10V 
	// 32000 = 14,6V
	// 10V = 

	//directionTreadmillleft := 25000;
	//directionTreadmillright := 25000;
	//speedTreadmill := -30000;
PROGRAM _CYCLIC
	// If there is currently a cocktail picked
	
	IF ERROR_DI = FALSE THEN
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
							// 300 ms impuls for Arduino
							IF counterBecherspender_var = 1 THEN
								BecherspenderAktivieren_AO := 16400;
							ELSE
								BecherspenderAktivieren_AO := 0;
							END_IF
							
							IF bechererkennungSpender_DI = TRUE THEN
								directionTreadmillright_DO := 1;
								currentStation_var := currentStation_var + 1;
								BecherspenderAktivieren_AO := 0;
								stationPercentage_var := 20;
							END_IF
						END_IF
					END_IF			
					
				stationEismaschine_var:
					IF inductiveSensorEisstation_DI = FALSE OR counterEisstation_var > 0 THEN
						directionTreadmillright_DO := 0;
						eisspenderAktivieren_DO := TRUE;
						counterBecherspender_var := 0;
						counterEisstation_var := counterEisstation_var + 1;
						stationPercentage_var := 30;
						
						// 300 ms impuls for arduino
						IF counterEisstation_var < 3 THEN
							EismaschineAktivieren_AO := 16400;
						ELSE
							EismaschineAktivieren_AO := 0;
						END_IF
								
						IF counterEisstation_var > 150 THEN
							directionTreadmillright_DO := 1;
							eisspenderAktivieren_DO := FALSE;
							currentStation_var := currentStation_var + 1;
							EismaschineAktivieren_AO := 0; 
							stationPercentage_var := 40;
						END_IF
					END_IF
								
				stationZitronenspender_var:
					IF inductiveSensorZitronenspende_DI = FALSE OR counterZitronenspender_var > 0 THEN
						directionTreadmillright_DO := 0;
						counterEisstation_var := 0;
						counterZitronenspender_var := counterZitronenspender_var + 1;
						stationPercentage_var := 50;
						
						// 300 ms impuls for arduino
						IF counterZitronenspender_var < 3 THEN
							zitronenspenderAktivieren_A0 := 16400;
						ELSE
							zitronenspenderAktivieren_A0 := 0;
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
						stationPercentage_var := 70;
						
						// IF first time on station
						IF counterCocktailmixer_var < 3 THEN
							cocktail_started := FALSE;
						END_IF
						
						//	IF cocktailFinished_var = TRUE THEN
						IF counterCocktailmixer_var > 3 AND pumpeBig1_DO = 0 AND pumpeBig2_DO = 0 AND pumpeBig3_DO = 0 AND pumpeBig4_DO = 0 AND pumpeSmall1_DO = 0 AND pumpeSmall2_DO = 0 AND pumpeSmall3_DO = 0 AND pumpeSmall4_DO = 0 AND  pumpeSmall5_DO = 0 AND  pumpeSmall6_DO = 0 THEN
							directionTreadmillright_DO := TRUE;
							currentStation_var := currentStation_var + 1;
							cocktailFinished_var := TRUE; 
							
							stationPercentage_var := 90;
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
						
					// When Button gets clicked and Station got reached, go back to first station
					IF bechererkennungAusgabe_DI = FALSE AND BecherAusgabe_var = 1 THEN
						BecherAusgabe_var := 2;
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
		
	ELSE
		// ON ERROR
		pumpeBig1_DO := 0;
		pumpeBig2_DO := 0;
		pumpeBig3_DO := 0;
		pumpeBig4_DO := 0;
		pumpeSmall1_DO := 0;
		pumpeSmall2_DO := 0;
		pumpeSmall3_DO := 0;
		pumpeSmall4_DO := 0;
		pumpeSmall5_DO := 0;
		pumpeSmall6_DO := 0;
		directionTreadmillright_DO := 0;
		directionThreadmillleft_DO := 0;
	END_IF
END_PROGRAM
