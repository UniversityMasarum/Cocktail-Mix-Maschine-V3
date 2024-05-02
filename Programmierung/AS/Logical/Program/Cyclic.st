	// IF D11 equals ON -> Power on 10V 
	// 32000 = 14,6V
	// 10V = 

	//directionTreadmillleft := 25000;
	//directionTreadmillright := 25000;
	//speedTreadmill := -30000;
PROGRAM _CYCLIC
	// If there is currently a cocktail picked
	
	//IF 1 OR 1 OR 1 OR 1 OR 1 OR 1 THEN
	//	cocktailChosen := TRUE; 
	//ELSE 
	//	cocktailChosen := FALSE;
	//END_IF
	
	// Reinigungsprogramm
	IF reingigunsmodus_var = TRUE THEN
		IF directionThreadmill_left_var = TRUE THEN
			directionTreadmillright_DO := 1;
		END_IF
		IF directionThreadmill_right_var = TRUE THEN
			directionThreadmillleft_DO := 1;
		END_IF
		IF directionThreadmill_right_var = FALSE AND directionThreadmill_left_var = FALSE THEN
			directionThreadmillleft_DO := 0;
			directionTreadmillright_DO := 0;
		END_IF
			
	ELSE
		CASE currentStation_var OF
			stationBecherspender_var:
				// Hier kommt es zu einem Problem
				IF inductiveSensorBecherspender_DI = FALSE OR counterBecherspender_var > 0 THEN
					directionThreadmillleft_DO := 0;
					IF cocktailChosen = TRUE THEN
						BecherAusgabe_var := 0;
						Becherspender_DO := TRUE;
						counterBecherspender_var := counterBecherspender_var + 1;
						
						IF counterBecherspender_var > 100 THEN
							directionTreadmillright_DO := 1;
							Becherspender_DO := FALSE;
							currentStation_var := currentStation_var + 1;
						END_IF
					END_IF
				END_IF			
				
				stationEismaschine_var:
					IF inductiveSensorEisstation_DI = FALSE OR counterEisstation_var <> 0 THEN
						directionTreadmillright_DO := 0;
						eisspenderAktivieren_DO := TRUE;
						counterBecherspender_var := 0;
						counterEisstation_var := counterEisstation_var + 1;
							
						IF counterEisstation_var > 100 THEN
							directionTreadmillright_DO := 1;
							eisspenderAktivieren_DO := FALSE;
							currentStation_var := currentStation_var + 1;
						END_IF
					END_IF
							
				stationZitronenspender_var:
					IF inductiveSensorZitronenspende_DI = FALSE OR counterZitronenspender_var <> 0 THEN
						directionTreadmillright_DO := 0;
						counterEisstation_var := 0;
						zitronenspenderAktivieren_DO := TRUE;
						counterZitronenspender_var := counterZitronenspender_var + 1;
							
						IF counterZitronenspender_var > 100 THEN
							directionTreadmillright_DO := 1;
							zitronenspenderAktivieren_DO := FALSE;
							currentStation_var := currentStation_var + 1;
						END_IF
					END_IF
												
				stationCocktailmixer_var:
					IF inductiveSensorCocktailmixer_DI = FALSE OR counterCocktailmixer_var <> 0 THEN
						directionTreadmillright_DO := 0;
						counterZitronenspender_var := 0;
						zitronenspenderAktivieren_DO := TRUE;
						counterCocktailmixer_var := counterCocktailmixer_var + 1;
			
					// IF counterCocktailmixer_var > 100 THEN
					//	IF cocktailFinished_var = TRUE THEN
						IF pumpeBig1_DO = 0 AND pumpeBig2_DO = 0 AND pumpeBig3_DO = 0 AND pumpeBig4_DO = 0 AND pumpeSmall1_DO = 0 AND pumpeSmall2_DO = 0 AND pumpeSmall3_DO = 0 AND pumpeSmall4_DO = 0 AND  pumpeSmall5_DO = 0 AND  pumpeSmall6_DO = 0 THEN
							directionTreadmillright_DO := 1;
							zitronenspenderAktivieren_DO := FALSE;
							currentStation_var := currentStation_var + 1;
						END_IF
					END_IF								
															
			stationBecherentnahme_var:
				IF BecherAusgabe_var = 0 THEN
						directionTreadmillright_DO := 1;
					END_IF
				
					IF inductiveSensorBecherausgabe_DI = FALSE THEN
						BecherAusgabe_var := 1;
						cocktailFinished_var := 0;
					END_IF
					IF BecherAusgabe_var = 1 THEN
						directionTreadmillright_DO := 0;
					END_IF
					
					// When Button gets clicked and Station got reached, go back to first station
					IF buttonAusgabe_DI = TRUE AND BecherAusgabe_var = 1 THEN
						BecherAusgabe_var := 2;
					END_IF
					IF BecherAusgabe_var = 2 THEN
						counterCocktailmixer_var := 0;
						directionTreadmillright_DO := 0;
						directionThreadmillleft_DO := 1;	
						currentStation_var := 0;
						cocktailChosen := FALSE;
					END_IF
			END_CASE
		END_IF
	

END_PROGRAM
