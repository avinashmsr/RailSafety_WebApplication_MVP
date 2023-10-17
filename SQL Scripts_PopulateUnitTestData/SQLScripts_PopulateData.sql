select * from public.wspd_app_train

INSERT INTO PUBLIC.wspd_app_train (train_no, train_name, train_description) 
	VALUES(22691,'XYZ Express','XYZ Express train from X to destination Y'); 
INSERT INTO PUBLIC.wspd_app_train (train_no, train_name, train_description) 
	VALUES(12301,'ABC Freight','ABC Freight train from A to destination B');

select * from public.wspd_app_rake

INSERT INTO public.wspd_app_rake (trainrake_no, rake_no, rake_description, rake_status, train_id)
	VALUES ('22691_1', 1, 'rake for XYZ express 22691', 'Active', 22691);
INSERT INTO public.wspd_app_rake (trainrake_no, rake_no, rake_description, rake_status, train_id)
	VALUES ('22691_2', 2, 'rake for XYZ express 22691', 'Active', 22691);
INSERT INTO public.wspd_app_rake (trainrake_no, rake_no, rake_description, rake_status, train_id)
	VALUES ('22691_3', 3, 'rake for XYZ express 22691', 'Active', 22691);
INSERT INTO public.wspd_app_rake (trainrake_no, rake_no, rake_description, rake_status, train_id)
	VALUES ('22691_4', 4, 'rake for XYZ express 22691', 'Active', 22691);
	
INSERT INTO public.wspd_app_rake (trainrake_no, rake_no, rake_description, rake_status, train_id)
	VALUES ('12301_1', 1, 'rake for ABC Freight 12301', 'Active', 12301);
INSERT INTO public.wspd_app_rake (trainrake_no, rake_no, rake_description, rake_status, train_id)
	VALUES ('12301_2', 2, 'rake for ABC Freight 12301', 'Active', 12301);
INSERT INTO public.wspd_app_rake (trainrake_no, rake_no, rake_description, rake_status, train_id)
	VALUES ('12301_3', 3, 'rake for ABC Freight 12301', 'Active', 12301);
INSERT INTO public.wspd_app_rake (trainrake_no, rake_no, rake_description, rake_status, train_id)
	VALUES ('12301_4', 4, 'rake for ABC Freight 12301', 'Active', 12301);
INSERT INTO public.wspd_app_rake (trainrake_no, rake_no, rake_description, rake_status, train_id)
	VALUES ('12301_5', 5, 'rake for ABC Freight 12301', 'Active', 12301);
INSERT INTO public.wspd_app_rake (trainrake_no, rake_no, rake_description, rake_status, train_id)
	VALUES ('12301_6', 6, 'rake for ABC Freight 12301', 'Active', 12301);
	
select * from public.wspd_app_coach
	
INSERT INTO public.wspd_app_coach (coach_no, coach_type, coach_class, coach_description, position, coach_name, rake_id)
	VALUES ('22691_1_14116', 'LMACCN', 'AC-I Class', 'Coach A5 of XYZ Exp',1,'A5','22691_1');
INSERT INTO public.wspd_app_coach (coach_no, coach_type, coach_class, coach_description, position, coach_name, rake_id)
	VALUES ('22691_1_14117', 'LMACCN', 'AC-I Class', 'Coach A4 of XYZ Exp',2,'A4','22691_1');
INSERT INTO public.wspd_app_coach (coach_no, coach_type, coach_class, coach_description, position, coach_name, rake_id)
	VALUES ('22691_1_14118', 'LMACCN', 'AC-I Class', 'Coach A3 of XYZ Exp',3,'A3','22691_1');
	
INSERT INTO public.wspd_app_coach (coach_no, coach_type, coach_class, coach_description, position, coach_name, rake_id)
	VALUES ('22691_2_14116', 'LMACCN', 'AC-I Class', 'Coach A5 of XYZ Exp',1,'A5','22691_2');
INSERT INTO public.wspd_app_coach (coach_no, coach_type, coach_class, coach_description, position, coach_name, rake_id)
	VALUES ('22691_2_14117', 'LMACCN', 'AC-I Class', 'Coach A4 of XYZ Exp',2,'A4','22691_2');
INSERT INTO public.wspd_app_coach (coach_no, coach_type, coach_class, coach_description, position, coach_name, rake_id)
	VALUES ('22691_2_14118', 'LMACCN', 'AC-I Class', 'Coach A3 of XYZ Exp',3,'A3','22691_2');
	
select * from public.wspd_app_faulttable
	
INSERT INTO public.wspd_app_faulttable (id, wsp_status_code, fault_datetime, coach_id)
	VALUES (1, 72,current_timestamp, '22691_1_14116');
INSERT INTO public.wspd_app_faulttable (id, wsp_status_code, fault_datetime, coach_id)
	VALUES (2, 63, current_timestamp, '22691_2_14117');
INSERT INTO public.wspd_app_faulttable (id, wsp_status_code, fault_datetime, coach_id)
	VALUES (3, 75, current_timestamp, '22691_2_14118');
INSERT INTO public.wspd_app_faulttable (id, wsp_status_code, fault_datetime, coach_id)
	VALUES (4, 72, current_timestamp, '22691_2_14116');
INSERT INTO public.wspd_app_faulttable (id, wsp_status_code, fault_datetime, coach_id)
	VALUES (5, 72, current_timestamp, '22691_1_14118');
INSERT INTO public.wspd_app_faulttable (id, wsp_status_code, fault_datetime, coach_id)
	VALUES (6, 99, current_timestamp, '22691_1_14118');
	
INSERT INTO public.wspd_app_faulttable (id, wsp_status_code, fault_datetime, coach_id)
	VALUES (7, 18, current_timestamp, '22691_1_14118');
INSERT INTO public.wspd_app_faulttable (id, wsp_status_code, fault_datetime, coach_id)
	VALUES (8, 27, current_timestamp, '22691_1_14117');
INSERT INTO public.wspd_app_faulttable (id, wsp_status_code, fault_datetime, coach_id)
	VALUES (9, 36, current_timestamp, '22691_1_14116');
INSERT INTO public.wspd_app_faulttable (id, wsp_status_code, fault_datetime, coach_id)
	VALUES (10, 45, current_timestamp, '22691_1_14117');
INSERT INTO public.wspd_app_faulttable (id, wsp_status_code, fault_datetime, coach_id)
	VALUES (11, 72, current_timestamp, '22691_1_14118');
INSERT INTO public.wspd_app_faulttable (id, wsp_status_code, fault_datetime, coach_id)
	VALUES (12, 99, current_timestamp, '22691_2_14117');
	
INSERT INTO public.wspd_app_faulttable (id, wsp_status_code, fault_datetime, coach_id)
	VALUES (13, 99, current_timestamp, '12345_1_14119');

