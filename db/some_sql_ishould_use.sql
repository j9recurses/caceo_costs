


insert into election_years (year, election_dt, year_dt, el_typ) VALUES ('2014 Primary Election' , '06-03-2014', 2014, 'Primary');
insert into election_years (year, election_dt, year_dt, el_typ) VALUES ('2012 Presidential Primary Election', '06-05-2012', 2012 , 'Presidential Primary');
insert into election_years (year, election_dt, year_dt, el_typ) VALUES ('2010 Primary Election',  '06-08-2010', 2010, 'Primary' );
insert into election_years (year, election_dt, year_dt, el_typ) VALUES ('2008 Primary Election', '06-03-2008', 2008, 'Primary');
insert into election_years (year, election_dt, year_dt, el_typ) VALUES ('2008 Presidential Primary Election', '02-05-2008', 2008, 'Presidential Primary');
insert into election_years (year, election_dt, year_dt, el_typ) VALUES ('2006 Primary Election' ,'06-06-2006', 2006, 'Primary');
insert into election_years (year, election_dt, year_dt, el_typ) VALUES ('2004 Primary Election', '03-02-2004', 2004, 'Primary');
update election_years set year  = '2012 General Election', election_dt  =  '11-06-2012', year_dt = '2012', el_typ = 'General' where year = '2012';
update election_years set year  = '2010 General Election', election_dt  =  '11-02-2010', year_dt = '2010', el_typ = 'General' where year = '2010';
update election_years set year  = '2009 Special Election', election_dt  =  '05-19-2009', year_dt = '2009', el_typ = 'Special' where year = '2009';
update election_years set year  = '2008 General Election', election_dt  =  '11-07-2008', year_dt = '2008', el_typ = 'General' where year = '2008';
update election_years set year  = '2006 General Election', election_dt  =  '11-07-2006', year_dt = '2006', el_typ = 'General' where year = '2006';
update election_years set year  = '2005 Special Election', election_dt  =  '11-08-2005', year_dt = '2005', el_typ = 'Special' where year = '2005';
update election_years set year  = '2004 General Election', election_dt  =  '11-02-2004', year_dt = '2004', el_typ = 'General' where year = '2004';
delete from election_years where year = 2007 or year = 2011;
