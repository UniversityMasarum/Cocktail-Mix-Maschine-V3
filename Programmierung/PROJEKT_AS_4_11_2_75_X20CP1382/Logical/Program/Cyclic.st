
PROGRAM _CYCLIC
	// IF D11 equals ON -> Power on 10V 
	// 32000 = 14,6V
	// 10V = 
	peristalticPump1_AO := 10000;
	IF inductiveSensor1_DI = TRUE 
	THEN 
		directionTreadmillright := 25000;
		directionTreadmillleft := 0;
	ELSIF inductiveSensor2_DI = TRUE THEN
		directionTreadmillleft := 25000;
		directionTreadmillright := 0;
	END_IF;
	

	//
	
	//speedTreadmill := -30000;
END_PROGRAM
