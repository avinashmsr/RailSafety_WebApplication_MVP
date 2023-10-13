select * from public.wspd_app_train

INSERT INTO PUBLIC.wspd_app_train 
	VALUES(22691,'XYZ Express','XYZ Express train from X to destination Y'); 
INSERT INTO PUBLIC.wspd_app_train 
	VALUES(12301,'ABC Freight','ABC Freight train from A to destination B');

select * from public.wspd_app_rake

INSERT INTO public.wspd_app_rake
	VALUES ('22691_1', 'rake for XYZ express 22691', 'Active', 22691);
INSERT INTO public.wspd_app_rake
	VALUES ('22691_2', 'rake for XYZ express 22691', 'Active', 22691);
INSERT INTO public.wspd_app_rake
	VALUES ('22691_3', 'rake for XYZ express 22691', 'Active', 22691);
INSERT INTO public.wspd_app_rake
	VALUES ('22691_4', 'rake for XYZ express 22691', 'Active', 22691);
	
INSERT INTO public.wspd_app_rake
	VALUES ('12301_1', 'rake for ABC Freight 12301', 'Active', 12301);
INSERT INTO public.wspd_app_rake
	VALUES ('12301_2', 'rake for ABC Freight 12301', 'Active', 12301);
INSERT INTO public.wspd_app_rake
	VALUES ('12301_3', 'rake for ABC Freight 12301', 'Active', 12301);
INSERT INTO public.wspd_app_rake
	VALUES ('12301_4', 'rake for ABC Freight 12301', 'Active', 12301);
INSERT INTO public.wspd_app_rake
	VALUES ('12301_5', 'rake for ABC Freight 12301', 'Active', 12301);
INSERT INTO public.wspd_app_rake
	VALUES ('12301_6', 'rake for ABC Freight 12301', 'Active', 12301);
	
select * from public.wspd_app_coach
	
INSERT INTO public.wspd_app_coach
	VALUES ('22691_1_14116', 'LMACCN', 'AC-I Class', 'Coach A5 of XYZ Exp',1,'A5','22691_1');
INSERT INTO public.wspd_app_coach
	VALUES ('22691_1_14117', 'LMACCN', 'AC-I Class', 'Coach A4 of XYZ Exp',2,'A4','22691_1');
INSERT INTO public.wspd_app_coach
	VALUES ('22691_1_14118', 'LMACCN', 'AC-I Class', 'Coach A3 of XYZ Exp',3,'A3','22691_1');
	
INSERT INTO public.wspd_app_coach
	VALUES ('22691_2_14116', 'LMACCN', 'AC-I Class', 'Coach A5 of XYZ Exp',1,'A5','22691_2');
INSERT INTO public.wspd_app_coach
	VALUES ('22691_2_14117', 'LMACCN', 'AC-I Class', 'Coach A4 of XYZ Exp',2,'A4','22691_2');
INSERT INTO public.wspd_app_coach
	VALUES ('22691_2_14118', 'LMACCN', 'AC-I Class', 'Coach A3 of XYZ Exp',3,'A3','22691_2');
	
select * from public.wspd_app_faulttable

INSERT INTO public.wspd_app_faulttable
	VALUES (1, 72,current_timestamp, '22691_1_14116');
INSERT INTO public.wspd_app_faulttable
	VALUES (2, current_timestamp, '22691_2_14117', 72);
INSERT INTO public.wspd_app_faulttable
	VALUES (3, current_timestamp, '22691_2_14118', 72);
INSERT INTO public.wspd_app_faulttable
	VALUES (4, current_timestamp, '22691_2_14116', 72);
INSERT INTO public.wspd_app_faulttable
	VALUES (5, current_timestamp, '22691_1_14118', 72);
INSERT INTO public.wspd_app_faulttable
	VALUES (6, current_timestamp, '22691_1_14118', 99);
	
	INSERT INTO public.wspd_app_faulttable
	VALUES (7, current_timestamp, '22691_1_14118', 72);
		INSERT INTO public.wspd_app_faulttable
	VALUES (8, current_timestamp, '22691_1_14117', 72);
		INSERT INTO public.wspd_app_faulttable
	VALUES (9, current_timestamp, '22691_1_14116', 72);
		INSERT INTO public.wspd_app_faulttable
	VALUES (10, current_timestamp, '22691_1_14117', 72);
		INSERT INTO public.wspd_app_faulttable
	VALUES (11, current_timestamp, '22691_1_14118', 72);
		INSERT INTO public.wspd_app_faulttable
	VALUES (12, current_timestamp, '22691_2_14117', 99);
	
	INSERT INTO public.wspd_app_faulttable
	VALUES (13, current_timestamp, '12345_1_14119', 72);

