/********************************************************
 * MYSQL scripts to generate tables for Final Project *
 * Team coc353C                                         *
 ********************************************************/

/* SQL Statements to initiate warm up project DB */

USE coc353_4;
SET SQL_SAFE_UPDATES = 0;

/* SQL Statements to ensure clean table creation */

DROP TABLE IF EXISTS researchAssignment CASCADE;
DROP TABLE IF EXISTS project CASCADE;
DROP TABLE IF EXISTS purchase CASCADE;
DROP TABLE IF EXISTS contract CASCADE;
DROP TABLE IF EXISTS client CASCADE;
DROP TABLE IF EXISTS product CASCADE;
DROP TABLE IF EXISTS teamLeader CASCADE;
DROP TABLE IF EXISTS team CASCADE;
DROP TABLE IF EXISTS researchCenter CASCADE;
DROP TABLE IF EXISTS manufacturing CASCADE;
DROP TABLE IF EXISTS warehouse CASCADE;
DROP TABLE IF EXISTS headOffice CASCADE;
DROP TABLE IF EXISTS jobPosition CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS facility CASCADE;
DROP TABLE IF EXISTS pharmaCompany CASCADE;
drop trigger if exists updateCEO;
drop trigger if exists updateResearcher;

/* SQL Statements to create desired tables */



CREATE TABLE pharmaCompany(
 company_ID INT PRIMARY KEY AUTO_INCREMENT,
 companyName VARCHAR(60) NOT NULL
);

CREATE TABLE facility(
 facility_ID INT PRIMARY KEY AUTO_INCREMENT,
 company_ID INT NOT NULL,
 facilityName VARCHAR(40),
 facilityType ENUM ('Research Center', 'Head Office', 'Warehouse', 'Manufacturing Facility') NOT NULL,
 address VARCHAR(40) NOT NULL,
 city VARCHAR(40) NOT NULL,
 province ENUM ('NL','PE','NS','NB','QC','ON','MB','SK','AB','BC','YT','NT','NU','NY','CA','OO','SA','OR','WU'),
 postalCode CHAR(7),
 country VARCHAR(80) NOT NULL,
 phoneNumber CHAR(12) NOT NULL,

 FOREIGN KEY (company_ID) REFERENCES pharmaCompany(company_ID)

);

CREATE TABLE jobPosition (
  position_ID INT PRIMARY KEY AUTO_INCREMENT,
  jobTitle VARCHAR(60) NOT NULL
);

CREATE TABLE employee(
 company_ID INT NOT NULL ,
 SSN CHAR(10) NOT NULL,
 position INT NOT NULL, 
 firstName VARCHAR(40) NOT NULL,
 lastName VARCHAR(40) NOT NULL,
 dateOfBirth DATE NOT NULL,
 citizenship VARCHAR(40) NOT NULL,
 address VARCHAR(40) NOT NULL,
 city VARCHAR(40) NOT NULL,
 province ENUM ('NL','PE','NS','NB','QC','ON','MB','SK','AB','BC','YT','NT','NU','NY','CA') NOT NULL,
 postalCode CHAR(7) NOT NULL ,
 country VARCHAR(80) NOT NULL,
 phoneNumber CHAR(12) NOT NULL,
 email VARCHAR(40) NOT NULL,
 salary FLOAT NOT NULL,
 facility INT NOT NULL,
 startDate DATE NOT NULL,
 endDate DATE,

 PRIMARY KEY (company_ID, SSN, position),
 FOREIGN KEY (facility) REFERENCES facility(facility_ID)

);

CREATE TABLE manufacturing(
 facility_ID INT NOT NULL,
 maxProdCapacity INT NOT NULL,

 FOREIGN KEY (facility_ID) REFERENCES facility(facility_ID)

);

CREATE TABLE warehouse(
 facility_ID INT NOT NULL,
 maxStoringCapacity INT NOT NULL,

 FOREIGN KEY (facility_ID) REFERENCES facility(facility_ID)

);

CREATE TABLE headOffice(
 facility_ID INT NOT NULL,
 company_ID INT NOT NULL,
 CEO_SSN CHAR(10) NOT NULL,
 position INT NOT NULL,
 email VARCHAR(40) NOT NULL,
 website VARCHAR(40) NOT NULL,

 FOREIGN KEY (facility_ID) REFERENCES facility(facility_ID),
 FOREIGN KEY (company_ID, CEO_SSN, position) REFERENCES employee(company_ID, SSN, position) 

);

CREATE TABLE researchCenter(
 facility_ID INT NOT NULL,
 typeOfResearch VARCHAR(40) NOT NULL,

 FOREIGN KEY (facility_ID) REFERENCES facility(facility_ID)

);

CREATE TABLE client (
 client_ID INT PRIMARY KEY AUTO_INCREMENT,
 companyName VARCHAR(40) NOT NULL,
 contactName VARCHAR(100) NOT NULL,
 address VARCHAR(80) NOT NULL,
 city VARCHAR(40) NOT NULL,
 province ENUM('NL','PE','NS','NB', 'QC','ON','MB','SK','AB','BC','YT','NT','NU','NY','CA') NOT NULL,
 postalCode CHAR(7) NOT NULL,
 country VARCHAR(70) NOT NULL,
 phoneNumber CHAR(12) NOT NULL,
 email VARCHAR(80) NOT NULL
);

CREATE TABLE contract (
 contract_ID INT PRIMARY KEY AUTO_INCREMENT,
 client_ID INT NOT NULL,
 clientname VARCHAR(100) NOT NULL,
 company_ID INT NOT NULL,
 employee_SSN CHAR(10) NOT NULL,
 position INT NOT NULL,
 contractDate DATE NOT NULL,
 deliveryDate DATE NOT NULL,
 
 FOREIGN KEY (client_ID) REFERENCES client(client_ID),
 FOREIGN KEY (company_ID, employee_SSN, position) REFERENCES employee(company_ID, SSN, position)

);

CREATE TABLE product (
 UPC INT PRIMARY KEY AUTO_INCREMENT,
 product_ID INT NOT NULL,
 name VARCHAR(40) NOT NULL,
 description VARCHAR(150) NOT NULL,
 volume INT NOT NULL,
 weight FLOAT NOT NULL,
 price FLOAT NOT NULL,
 status ENUM('Available', 'Unavailable') NOT NULL
);

CREATE TABLE purchase (
 purchase_ID INT PRIMARY KEY AUTO_INCREMENT,
 product_ID INT NOT NULL,
 quantity INT NOT NULL,
 unitPrice FLOAT NOT NULL,
 contract_ID INT NOT NULL,

 FOREIGN KEY (product_ID) REFERENCES product(UPC),
 FOREIGN KEY (contract_ID) REFERENCES contract(contract_ID)

);

CREATE TABLE team (
  team_ID INT PRIMARY KEY AUTO_INCREMENT,
  teamName VARCHAR(60) NOT NULL,
  company_ID INT NOT NULL,
  lead_SSN CHAR(10) NOT NULL,
  position INT NOT NULL,

  FOREIGN KEY (company_ID, lead_SSN, position) REFERENCES employee(company_ID, SSN, position) 

);

CREATE TABLE project (
  project_ID INT PRIMARY KEY AUTO_INCREMENT,
  team_ID INT NOT NULL,
  projectName VARCHAR(60) NOT NULL,
  startDate DATE NOT NULL,
  endDate DATE,
 
  FOREIGN KEY (team_ID) REFERENCES team(team_ID)

);

CREATE TABLE researchAssignment (
  project_ID INT NOT NULL,
  company_ID INT NOT NULL,
  researcher_SSN CHAR(10) NOT NULL,
  position INT NOT NULL,
  startDate DATE NOT NULL,
  endDate DATE,
  totalHours INT NOT NULL,
	
  PRIMARY KEY (project_ID,company_ID, researcher_SSN, position), 
  FOREIGN KEY (project_ID) REFERENCES project(project_ID),
  FOREIGN KEY (company_ID, researcher_SSN, position) REFERENCES employee(company_ID, SSN, position)  

);

/* ---------------------------------------------- */
/*

Population of tables for Final

*/
/*----------------------------------------------- */


/* populate jobPosition table */
INSERT INTO jobPosition (position_ID, jobTitle) 
VALUES 
(1, 'CEO'), (2, 'Researcher'), (3, 'Administrator'), (4, 'Secretary'), (5, 'Machine Operator'), (6, 'Technician'), (7, 'Security'), (8, 'Receiver'), (9, 'Shipper'), (10, 'Manager'), (11, 'Laborer'), (12, 'Security Officer');

/* populate pharmaCompany */

INSERT INTO pharmaCompany (company_ID, companyName) 
VALUES 
(1, 'Pfizer'), (2, 'Moderna'), (3, 'Johnson & Johnson'), (4, 'Astrazeneca'), (5, 'Greco Pills Inc'), (6, 'Miss Smarty Pants Enterprises, Inc.'), (7, 'SPIRIT PHARMACEUTICALS,LLC'), (8, 'Uriel Pharmacy Inc.'), (9, 'Lake Erie Medical DBA Quality Care Products LLC');

 /*1 facility of type research center for each comapny */

insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (1100, 1, 'Kunze, MacGyver and Pollich', 'Research Center', '3932 Lerdahl Trail', 'Verkhniy Dashkesan', 'ON', '7c9 1f9', 'USA', '448-166-9248');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (1200, 2, 'Jaskolski-Kerluke', 'Research Center', '84 Pleasure Circle', 'Baños', 'AB', '6w6 8w9', 'Ecuador', '317-736-9967');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (1300, 3, 'Murazik, Bogisich and Littel', 'Research Center', '64 South Parkway', 'Pasirbitung', 'CA', '9g8 1g7', 'Indonesia', '151-923-0392');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (1400, 4, 'Rodriguez Inc', 'Research Center', '8 Carpenter Street', 'Santa Cruz', 'QC', '4h4 4u7', 'Mexico', '614-868-8006');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (1500, 5, 'Willms-Haag', 'Research Center', '7292 Bonner Plaza', 'Zhishan', 'YT', '5c7 9v9', 'China', '323-627-4287');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (1600, 6, 'Reinger, Bins and Quitzon', 'Research Center', '786 Myrtle Hill', 'Huangtian', 'NT', '2u1 6c7', 'China', '591-420-3795');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (1700, 7, 'Dietrich LLC', 'Research Center', '83 Glacier Hill Way', 'Kinnegad', 'NL', '1i9 5l8', 'Ireland', '826-461-2185');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (1800, 8, 'Cartwright and Sons', 'Research Center', '0 Norway Maple Hill', 'Karangsari', 'NS', '8g4 6o1', 'Indonesia', '461-136-6913');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (1900, 9, 'Davis and Sons', 'Research Center', '9642 Sycamore Plaza', 'Tamuning-Tumon-Harmon Village', 'NY', '1w1 1m3', 'Guam', '785-692-3428');

/* 1 facility of type headOffice for each company */

insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (2100, 1, 'Ullrich-Kunde', 'Head Office', '9700 Hollow Ridge Place', 'Wola Jachowa', 'NT', '9z5 2w6', 'Canada', '217-251-8725');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (2200, 2, 'Welch, Hilpert and Reinger', 'Head Office', '01704 Carpenter Way', 'Jubaoshan', 'OO', '4f0 8r4', 'China', '167-106-4338');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (2300, 3, 'Hettinger, Lowe and Kshlerin', 'Head Office', '85447 Blaine Terrace', 'Khryashchevka', 'CA', '7w0 7b7', 'USA', '849-418-2049');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (2400, 4, 'Walter, Moore and Abernathy', 'Head Office', '49233 Welch Point', 'Lipu', 'WU', '7j0 7l9', 'China', '226-994-4311');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (2500, 5, 'Fay LLC', 'Head Office', '606 Steensland Center', 'Beijiang', 'NB', '9o0 4x4', 'Canada', '790-929-5799');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (2600, 6, 'Ledner-Wunsch', 'Head Office', '41 Fair Oaks Way', 'Dhangarhi', 'SA', '0i9 4z8', 'Nepal', '511-163-3853');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (2700, 7, 'Gleason-Dooley', 'Head Office', '10341 Sachs Junction', 'Jambean', 'NT', '8f3 5h1', 'USA', '195-713-7530');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (2800, 8, 'Von, Wehner and Hodkiewicz', 'Head Office', '79445 Mcbride Point', 'Yuncheng', 'SK', '4c9 5x2', 'China', '362-677-8796');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (2900, 9, 'Beer-Kub', 'Head Office', '399 6th Alley', 'Imielin', 'OR', '4f9 6n1', 'Poland', '557-329-7821');

/* 1 facility of type warehouse for each company */

insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (3100, 1, 'Muller, Ortiz and Kunze', 'Warehouse', '1471 Spenser Place', 'Pontalina', 'ON', '1q1 6e9', 'Canada', '903-269-4530');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (3101, 1, 'Kunze', 'Warehouse', '1452 Spenser Place', 'Pontalina', 'ON', '1h1 6e9', 'Canada', '903-222-4530');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (3200, 2, 'Kozey-Hickle', 'Warehouse', '280 Lakewood Gardens Drive', 'Taroudant', 'QC', '4i8 1j0', 'Canada', '179-518-3672');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (3201, 2, 'Kozey', 'Warehouse', '230 Lakewood Gardens Drive', 'Taroudant', 'QC', '4l8 1j0', 'Canada', '172-528-3672');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (3300, 3, 'Connelly Group', 'Warehouse', '9743 Fair Oaks Road', 'Songyuan', 'SK', '6g2 1w7', 'Canada', '378-918-3290');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (3400, 4, 'Hamill and Sons', 'Warehouse', '78013 Kennedy Junction', 'Cimaragas', 'NL', '9u2 8z4', 'Canada', '791-511-5842');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (3500, 5, 'Jacobson, Prohaska and Braun', 'Warehouse', '3391 Loeprich Point', 'Chamical', 'QC', '4k5 2i5', 'Canada', '551-248-0149');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (3600, 6, 'Okuneva LLC', 'Warehouse', '87371 Killdeer Alley', 'La Esperanza', 'NY', '5i8 2h1', 'USA', '395-201-4037');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (3700, 7, 'Parker-Larkin', 'Warehouse', '963 Anhalt Road', 'Kaum Kaler', 'NY', '9w1 7g2', 'USA', '773-902-5390');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (3800, 8, 'Gutkowski, Schultz and Cassin', 'Warehouse', '271 Hermina Street', 'Ma''an', 'CA', '0w8 8x8', 'USA', '352-535-2772');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (3900, 9, 'Stiedemann-King', 'Warehouse', '9308 Corben Street', 'Shashi', 'CA', '5e4 6q4', 'USA', '432-566-2863');

/* 1 facility of type Manuf. for each company */

insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (4100, 1, 'Collier Inc', 'Manufacturing Facility', '03 Forest Pass', 'Zhanghuban', 'YT', '6g0 3h7', 'China', '610-721-1169');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (4101, 1, 'Inc', 'Manufacturing Facility', '02 Forest Pass', 'Zhanghubanee', 'YT', '6g0 3n7', 'China', '612-721-1169');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (4200, 2, 'Kunde, Aufderhar and O''Conner', 'Manufacturing Facility', '09 Center Plaza', 'Sidi Qacem', 'NY', '6v6 8t1', 'Morocco', '703-390-7634');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (4201, 2, 'Kunde Aufderhar', 'Manufacturing Facility', '05 Center Plaza', ' Qacem', 'NY', '6k6 8t1', 'Morocco', '702-391-7634');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (4300, 3, 'Hermiston Group', 'Manufacturing Facility', '6060 Fairview Court', 'Banraeaba Village', 'PE', '0a5 6n8', 'Kiribati', '906-937-5434');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (4400, 4, 'O''Reilly, Kautzer and O''Hara', 'Manufacturing Facility', '1 North Terrace', 'Chunghwa', 'NY', '6i3 7v1', 'North Korea', '797-965-3934');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (4500, 5, 'Bogan, Kub and O''Kon', 'Manufacturing Facility', '4 Doe Crossing Court', 'Kumalarang', 'NL', '0v7 0i4', 'Philippines', '310-956-0294');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (4600, 6, 'Stamm Inc', 'Manufacturing Facility', '83265 Mcbride Center', 'Banjar Desa', 'YT', '3c8 4v6', 'Indonesia', '294-468-7560');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (4700, 7, 'Schmidt, Ratke and Stiedemann', 'Manufacturing Facility', '82294 Farwell Alley', 'Saitama', 'YT', '4d7 4s3', 'Japan', '621-927-2998');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (4800, 8, 'Osinski-Bogan', 'Manufacturing Facility', '0419 Schiller Pass', 'Jinrui', 'AB', '2r3 6g5', 'China', '416-674-8503');
insert into facility (facility_ID, company_ID, facilityName, facilityType, address, city, province, postalCode, country, phoneNumber) values (4900, 9, 'Corkery, Hintz and Gerlach', 'Manufacturing Facility', '25444 Doe Crossing Lane', 'Colinas', 'NU', '1h8 7o6', 'Brazil', '113-784-5907');

/*The CEO of each company */

insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000001, 1, 'Ted', 'Delph', '1967-10-27', 'Armenian', '80826 Lunder Place', 'Asemanis', 'BC', '9x9 9z4', 'Indonesia', '586-987-0491', 'tdelph0@soup.io', 1149402.78, 2100, '2018-07-20', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (2, 1000000002, 1, 'Hillard', 'Mogey', '1981-04-08', 'Catalan', '62 Mayfield Road', 'Helang', 'NY', '1b3 7o0', 'China', '303-801-7233', 'hmogey1@a8.net', 3772737.0, 2200, '2020-10-17', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (3, 1000000003, 1, 'Kayne', 'Tanton', '1977-04-19', 'Hebrew', '91734 Meadow Vale Court', 'Kuroishi', 'NS', '7f9 0u8', 'Japan', '851-288-3919', 'ktanton2@over-blog.com', 2344481.88, 2300, '2021-09-28', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (4, 1000000004, 1, 'Leelah', 'Baddeley', '1971-07-06', 'Hiri Motu', '71 Johnson Terrace', 'Bălţi', 'NL', '3y2 4b6', 'Moldova', '481-131-0945', 'lbaddeley3@shareasale.com', 4431565.89, 2400, '2015-11-20', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (5, 1000000005, 1, 'Kristien', 'Trigwell', '1973-08-18', 'Haitian Creole', '6 Di Loreto Junction', 'Malpique', 'NB', '7z4 7z4', 'Portugal', '557-428-6887', 'ktrigwell4@ft.com', 2026357.47, 2500, '2021-09-17', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (6, 1000000006, 1, 'Monika', 'Gogan', '1976-12-22', 'Hebrew', '870 Comanche Plaza', 'Tapilon', 'PE', '9t4 4u9', 'Philippines', '746-425-3370', 'mgogan5@meetup.com', 1918771.63, 2600, '2016-01-15', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (7, 1000000007, 1, 'Arni', 'Portwaine', '1983-08-26', 'Korean', '13848 Bartillon Road', 'Konosha', 'CA', '7x5 8v7', 'Russia', '379-133-1632', 'aportwaine6@craigslist.org', 1256932.72, 2700, '2011-09-03', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (8, 1000000008, 1, 'Gloria', 'Woodyeare', '1975-03-07', 'Azeri', '64603 Kipling Junction', 'Yanwan', 'AB', '7o7 0z1', 'China', '213-299-8196', 'gwoodyeare7@angelfire.com', 1376958.0, 2800, '2016-02-23', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (9, 1000000009, 1, 'Violetta', 'Vagg', '1982-01-13', 'Danish', '4 Elmside Lane', 'Si Racha', 'NS', '0k9 4k1', 'Thailand', '732-658-8179', 'vvagg8@51.la', 4546609.0, 2900, '2009-11-17', null);

/* Active researchers for pfizer in pfizer's 1 Research Center (1100). These researchers will be the team leads*/

insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000101, 2, 'Rusty', 'Paler', '1963-02-04', 'Tetum', '787 Bluejay Point', 'Tengqiao', 'SK', '1c0 3d9', 'China', '513-730-3026', 'rpaler0@wix.com', 3601978.96, 1100, '2019-07-01', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000102, 2, 'Arin', 'Klagge', '1976-10-06', 'Lao', '7878 Stone Corner Avenue', 'Granada', 'NY', '6s3 4h0', 'Colombia', '292-158-7945', 'aklagge1@tiny.cc', 4374070.0, 1100, '2018-08-22', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000103, 2, 'Lyda', 'Reiglar', '1974-09-15', 'Korean', '40146 Spaight Pass', 'Kinnegad', 'NY', '7x0 0d4', 'Ireland', '947-260-8516', 'lreiglar2@aboutads.info', 4511897.0, 1100, '2013-10-01', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000104, 2, 'Paule', 'Copp', '1979-12-19', 'Dzongkha', '9 Hoffman Alley', 'Kétou', 'BC', '9o2 1p8', 'Benin', '397-715-8405', 'pcopp3@sun.com', 4861765.0, 1100, '2009-12-31', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000105, 2, 'Ertha', 'Yerrall', '1976-08-04', 'Swahili', '75710 Forster Drive', 'Ergong', 'SK', '5i0 5x1', 'China', '296-270-4361', 'eyerrall4@ted.com', 2230931.0, 1100, '2019-02-04', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000106, 2, 'Tiffi', 'Pasek', '1970-10-31', 'Tajik', '1 Anthes Park', 'Jingtailu', 'MB', '6z7 5o0', 'China', '838-560-7294', 'tpasek5@creativecommons.org', 2615464.0, 1100, '2020-07-05', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000107, 2, 'Cary', 'McNevin', '1981-09-19', 'Assamese', '98613 Jenna Court', 'Kribi', 'ON', '0g6 6h8', 'Cameroon', '275-795-4843', 'cmcnevin6@studiopress.com', 4290883.0, 1100, '2012-05-27', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000108, 2, 'Flo', 'Meriet', '1971-09-04', 'Kashmiri', '4648 Goodland Terrace', 'Brejos', 'QC', '4u5 0j7', 'Portugal', '280-929-1442', 'fmeriet7@vistaprint.com', 3158274.56, 1100, '2019-01-28', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000109, 2, 'Gilburt', 'Foye', '1961-06-10', 'Lao', '6810 Autumn Leaf Plaza', 'Diaoluoshan', 'NB', '4w7 3h4', 'China', '595-801-6822', 'gfoye8@twitpic.com', 4794297.0, 1100, '2014-09-27', null);

/* Created 9 more researchers, who are NOT team leads, to work on particular team assignments */

insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000111, 2, 'Marthe', 'Mount', '1975-09-04', 'Tajik', '7 Elmside Alley', 'Kertapura', 'ON', '9y2 6t1', 'Indonesia', '522-965-0698', 'mmount0@fotki.com', 508890.0, 1100, '2016-03-03', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000112, 2, 'Sharl', 'Jeandillou', '1986-09-27', 'Italian', '24 Texas Way', 'Banjar Tengah', 'QC', '0b7 3u4', 'Indonesia', '256-642-5953', 'sjeandillou1@behance.net', 778053.93, 1100, '2017-12-09', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000113, 2, 'Filmore', 'Basile', '1972-01-20', 'Bosnian', '60 Mendota Plaza', 'Loutráki', 'NT', '3y5 4u1', 'Greece', '925-489-3127', 'fbasile2@nhs.uk', 318407.83, 1100, '2016-05-12', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000114, 2, 'Lilla', 'Oppy', '1963-06-19', 'Czech', '5768 Ohio Park', 'Shifo', 'QC', '3s8 1u5', 'China', '778-130-9952', 'loppy3@amazon.co.uk', 687138.58, 1100, '2015-11-14', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000115, 2, 'Julee', 'Mattam', '1985-02-09', 'Aymara', '00877 Comanche Place', 'Capatárida', 'YT', '6d8 7b4', 'Venezuela', '155-827-7796', 'jmattam4@deviantart.com', 751221.03, 1100, '2012-02-23', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000116, 2, 'Barton', 'Camblin', '1976-08-18', 'Burmese', '139 Weeping Birch Road', 'Malaga', 'PE', '9i9 3d2', 'Spain', '675-806-6123', 'bcamblin5@skype.com', 752704.25, 1100, '2012-08-21', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000117, 2, 'Sharl', 'Corkhill', '1985-05-25', 'Haitian Creole', '856 Vernon Way', 'Chivor', 'ON', '6g6 9x9', 'Colombia', '794-826-8759', 'scorkhill6@pinterest.com', 998832.56, 1100, '2020-08-08', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000118, 2, 'Tobe', 'Merman', '1986-02-15', 'Marathi', '533 Fairfield Hill', 'Navariya', 'PE', '2g9 9p8', 'Ukraine', '920-694-1322', 'tmerman7@e-recht24.de', 700351.48, 1100, '2017-06-04', null);
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000000119, 2, 'Elna', 'Wilflinger', '1974-08-16', 'Dhivehi', '417 Crownhardt Avenue', 'Saint David’s', 'NY', '7e9 4e3', 'Grenada', '185-307-9126', 'ewilflinger8@nytimes.com', 270742.71, 1100, '2011-07-18', null);


/* 1 manuf. for each */

insert into manufacturing (facility_ID, maxProdCapacity) values (4100, 719);
insert into manufacturing (facility_ID, maxProdCapacity) values (4101, 889);
insert into manufacturing (facility_ID, maxProdCapacity) values (4200, 785);
insert into manufacturing (facility_ID, maxProdCapacity) values (4201, 685);
insert into manufacturing (facility_ID, maxProdCapacity) values (4300, 977);
insert into manufacturing (facility_ID, maxProdCapacity) values (4400, 895);
insert into manufacturing (facility_ID, maxProdCapacity) values (4500, 596);
insert into manufacturing (facility_ID, maxProdCapacity) values (4600, 564);
insert into manufacturing (facility_ID, maxProdCapacity) values (4700, 946);
insert into manufacturing (facility_ID, maxProdCapacity) values (4800, 831);
insert into manufacturing (facility_ID, maxProdCapacity) values (4900, 620);

/* 1 warehouse for each */

insert into warehouse (facility_ID, maxStoringCapacity) values (3100, 5639);
insert into warehouse (facility_ID, maxStoringCapacity) values (3101, 5000);
insert into warehouse (facility_ID, maxStoringCapacity) values (3200, 9113);
insert into warehouse (facility_ID, maxStoringCapacity) values (3201, 1113);
insert into warehouse (facility_ID, maxStoringCapacity) values (3300, 5979);
insert into warehouse (facility_ID, maxStoringCapacity) values (3400, 9661);
insert into warehouse (facility_ID, maxStoringCapacity) values (3500, 9109);
insert into warehouse (facility_ID, maxStoringCapacity) values (3600, 5131);
insert into warehouse (facility_ID, maxStoringCapacity) values (3700, 8208);
insert into warehouse (facility_ID, maxStoringCapacity) values (3800, 7760);
insert into warehouse (facility_ID, maxStoringCapacity) values (3900, 5863);

/* 1 research center for each */

insert into researchCenter (facility_ID, typeOfResearch) values (1100, 'Ibuprofen');
insert into researchCenter (facility_ID, typeOfResearch) values (1200, 'ALLOXANUM');
insert into researchCenter (facility_ID, typeOfResearch) values (1300, 'Enalapril Maleate');
insert into researchCenter (facility_ID, typeOfResearch) values (1400, 'Benzocaine');
insert into researchCenter (facility_ID, typeOfResearch) values (1500, 'Hyoscyamine Sulfate');
insert into researchCenter (facility_ID, typeOfResearch) values (1600, 'Arsenicum iodatum');
insert into researchCenter (facility_ID, typeOfResearch) values (1700, 'methylprednisolone acetate');
insert into researchCenter (facility_ID, typeOfResearch) values (1800, 'Hydrocortisone Silicone');
insert into researchCenter (facility_ID, typeOfResearch) values (1900, 'Trolamine salicylate 10%');

/* 1 head office for each */

insert into headOffice (facility_ID, company_ID, CEO_SSN, position, email, website) values (2100, 1, 1000000001, 1, 'cgayler0@freewebs.com', 'netlog.com');
insert into headOffice (facility_ID, company_ID, CEO_SSN, position, email, website) values (2200, 2, 1000000002, 1, 'hpettus1@artisteer.com', 'delicious.com');
insert into headOffice (facility_ID, company_ID, CEO_SSN, position, email, website) values (2300, 3, 1000000003, 1, 'fdutnell2@engadget.com', 'hatena.ne.jp');
insert into headOffice (facility_ID, company_ID, CEO_SSN, position, email, website) values (2400, 4, 1000000004, 1, 'tgerold3@unblog.fr', 'merriam-webster.com');
insert into headOffice (facility_ID, company_ID, CEO_SSN, position, email, website) values (2500, 5, 1000000005, 1, 'nbumpass4@spotify.com', 'omniture.com');
insert into headOffice (facility_ID, company_ID, CEO_SSN, position, email, website) values (2600, 6, 1000000006, 1, 'dperle5@wp.com', 'tuttocitta.it');
insert into headOffice (facility_ID, company_ID, CEO_SSN, position, email, website) values (2700, 7, 1000000007, 1, 'vwimms6@europa.eu', 'storify.com');
insert into headOffice (facility_ID, company_ID, CEO_SSN, position, email, website) values (2800, 8, 1000000008, 1, 'gtressler7@google.com', 'cargocollective.com');
insert into headOffice (facility_ID, company_ID, CEO_SSN, position, email, website) values (2900, 9, 1000000009, 1, 'bivankin8@gravatar.com', 'zdnet.com');

/*Creating the only 9 clients that should be necessary */

insert into client (client_ID, companyName, contactName, address, city, province, postalCode, country, phoneNumber, email) values (100, 'Gabcube', 'Giralda Calcut', '2 Del Sol Park', 'Lekas', 'CA', '5d8 3g1', 'Canada', '261-299-3809', 'gcalcut0@springer.com');
insert into client (client_ID, companyName, contactName, address, city, province, postalCode, country, phoneNumber, email) values (200, 'Meejo', 'Joelly Aylmore', '5822 Hayes Lane', 'Danauparis', 'YT', '2c9 6h8', 'Canada', '481-828-5253', 'jaylmore1@pbs.org');
insert into client (client_ID, companyName, contactName, address, city, province, postalCode, country, phoneNumber, email) values (300, 'Avaveo', 'Bjorn Kowalik', '0 Charing Cross Lane', 'Gatbo', 'NL', '7l2 7m3', 'Canada', '362-286-7547', 'bkowalik2@nationalgeographic.com');
insert into client (client_ID, companyName, contactName, address, city, province, postalCode, country, phoneNumber, email) values (400, 'Shufflester', 'Rorke Shenfish', '2299 Merrick Pass', 'Manggis', 'SK', '4e4 0e8', 'Canada', '334-121-2125', 'rshenfish3@youtube.com');
insert into client (client_ID, companyName, contactName, address, city, province, postalCode, country, phoneNumber, email) values (500, 'Jatri', 'Sergei Kyllford', '775 Oriole Pass', 'Aozou', 'QC', '3e6 0t7', 'USA', '930-339-3777', 'skyllford4@shop-pro.jp');
insert into client (client_ID, companyName, contactName, address, city, province, postalCode, country, phoneNumber, email) values (600, 'Abata', 'Tobe Parnell', '18350 Portage Court', 'Tazhuang', 'QC', '9x9 3a9', 'USA', '332-982-1769', 'tparnell5@netscape.com');
insert into client (client_ID, companyName, contactName, address, city, province, postalCode, country, phoneNumber, email) values (700, 'Zava', 'Ugo Goulter', '30026 Forest Dale Crossing', 'Pandian', 'YT', '0j0 5n6', 'USA', '370-818-9284', 'ugoulter6@eventbrite.com');
insert into client (client_ID, companyName, contactName, address, city, province, postalCode, country, phoneNumber, email) values (800, 'Meezzy', 'Ara Thomasset', '2 Katie Place', 'Muyuzi', 'ON', '7b1 1n0', 'USA', '577-988-9993', 'athomasset7@cnn.com');
insert into client (client_ID, companyName, contactName, address, city, province, postalCode, country, phoneNumber, email) values (900, 'Cogilith', 'Almeta Dennerly', '0698 Westport Plaza', 'Bombardopolis', 'CA', '1b9 4f6', 'USA', '389-172-3541', 'adennerly8@nydailynews.com');


/*Created 9 initial products, incremental product_ID, all available */

insert into product (UPC, product_ID, name, description, volume, weight, price, status) values (1200012001, 1, 'Cinnamon Fern', 'Osmunda cinnamomea L. var. cinnamomea', 37, 9.28, 121.77, 'Available');
insert into product (UPC, product_ID, name, description, volume, weight, price, status) values (1200012002, 2, 'Leafless Ghostplant', 'Voyria aphylla (Jacq.) Pers.', 61, 26.81, 237.18, 'Available');
insert into product (UPC, product_ID, name, description, volume, weight, price, status) values (1200012003, 3, 'Gallion Hawthorn', 'Crataegus meridionalis Sarg.', 29, 30.51, 499.71, 'Available');
insert into product (UPC, product_ID, name, description, volume, weight, price, status) values (1200012004, 4, 'Salinas Valley Popcornflower', 'Plagiobothrys uncinatus J.T. Howell', 74, 85.18, 382.93, 'Available');
insert into product (UPC, product_ID, name, description, volume, weight, price, status) values (1200012005, 5, 'Palo De Vaca', 'Dendropanax laurifolius (Marchal ex Urb.) R.C. Schneid.', 100, 64.85, 68.87, 'Available');
insert into product (UPC, product_ID, name, description, volume, weight, price, status) values (1200012006, 6, 'Summer Coralroot', 'Corallorhiza maculata (Raf.) Raf. var. ozettensis E. Tisch', 74, 58.1, 430.9, 'Available');
insert into product (UPC, product_ID, name, description, volume, weight, price, status) values (1200012007, 7, 'Myrrhis', 'Myrrhis Mill.', 8, 56.35, 173.72, 'Available');
insert into product (UPC, product_ID, name, description, volume, weight, price, status) values (1200012008, 8, 'Providence Mountain Milkvetch', 'Astragalus nutans M.E. Jones', 28, 11.2, 41.76, 'Available');
insert into product (UPC, product_ID, name, description, volume, weight, price, status) values (1200012009, 9, 'Western Black Currant', 'Ribes hudsonianum Richardson var. petiolare (Douglas) Jancz.', 73, 99.72, 200.0, 'Available');

/* 1 Contract for every comapny */

insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10000, 100, 'Helenelizabeth Willcot', 1, 1000000001, 1, '2022-01-20', '2022-05-11');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (20000, 200, 'Emmy Giacopini', 2, 1000000002, 1, '2021-12-09', '2022-03-19');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (30000, 300, 'Frances Kike', 3, 1000000003, 1, '2021-09-16', '2022-06-25');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (40000, 400, 'Alfi Boucher', 4, 1000000004, 1, '2021-07-07', '2022-04-27');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (50000, 500, 'Gerladina MacMoyer', 5, 1000000005, 1, '2021-10-18', '2022-03-21');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (60000, 600, 'Dallas Smiley', 6, 1000000006, 1, '2022-02-15', '2022-06-11');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (70000, 700, 'Bette Barrott', 7, 1000000007, 1, '2021-06-07', '2022-06-20');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (80000, 800, 'Wilhelmina Poser', 8, 1000000008, 1, '2021-05-30', '2022-06-14');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (90000, 900, 'Didi Brundall', 9, 1000000009, 1, '2021-09-06', '2022-05-27');

/* Pfizers(company 1)  9 additional contracts, 5 for client 100, 4 for client 200 */

insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10001, 100, 'Nickolai Porch', 1, 1000000001, 1, '2021-05-13', '2022-04-12');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10002, 200, 'Bridget Swann', 1, 1000000001, 1, '2021-01-28', '2022-06-06');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10003, 100, 'Ivie Seers', 1, 1000000001, 1, '2021-12-02', '2022-05-17');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10004, 200, 'Mohandis Hallbird', 1, 1000000001, 1, '2022-02-13', '2022-06-18');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10005, 100, 'Livia Freeth', 1, 1000000001, 1, '2021-09-13', '2022-04-16');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10006, 200, 'Hal Wookey', 1, 1000000001, 1, '2021-06-02', '2022-05-22');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10007, 100, 'Damien Camelia', 1, 1000000001, 1, '2021-02-12', '2022-03-21');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10008, 200, 'Cornelius Setchfield', 1, 1000000001, 1, '2021-10-10', '2022-03-19');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10009, 100, 'Judon Piggott', 1, 1000000001, 1, '2022-02-21', '2022-04-27');

/* 1 purchase for each contract, which corresponds to 1 per company */

insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (1, 1200012001, 87, 43.27, 10000);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (2, 1200012002, 25, 39.35, 20000);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (3, 1200012003, 65, 14.34, 30000);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (4, 1200012004, 80, 5.47, 40000);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (5, 1200012005, 56, 39.98, 50000);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (6, 1200012006, 27, 2.62, 60000);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (7, 1200012007, 70, 23.92, 70000);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (8, 1200012008, 48, 47.81, 80000);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (9, 1200012009, 10, 17.28, 90000);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (101010101, 1200012009, 10, 17.28, 90000);

/* 9 Additional purchase for each extra contract of Pfizer's */

insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (11, 1200012001, 57, 26.24, 10001);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (12, 1200012002, 91, 21.58, 10002);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (13, 1200012003, 29, 20.1, 10003);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (14, 1200012004, 56, 4.6, 10004);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (15, 1200012005, 49, 39.82, 10005);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (16, 1200012006, 7, 24.88, 10006);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (17, 1200012007, 47, 36.34, 10007);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (18, 1200012008, 40, 43.11, 10008);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (19, 1200012009, 5, 38.29, 10009);

/* 9 teams all for pfizer(companyID 1) initially, since most queries revolve around them */

insert into team (team_ID, teamName, company_ID, lead_SSN, position) values (111001, 'Catfish, blue', 1, 1000000101, 2);
insert into team (team_ID, teamName, company_ID, lead_SSN, position) values (111002, 'Grouse, sage', 1, 1000000102, 2);
insert into team (team_ID, teamName, company_ID, lead_SSN, position) values (111003, 'Phalarope, northern', 1, 1000000103, 2);
insert into team (team_ID, teamName, company_ID, lead_SSN, position) values (111004, 'Plover, three-banded', 1, 1000000104, 2);
insert into team (team_ID, teamName, company_ID, lead_SSN, position) values (111005, 'Great skua', 1, 1000000105, 2);
insert into team (team_ID, teamName, company_ID, lead_SSN, position) values (111006, 'White-nosed coatimundi', 1, 1000000106, 2);
insert into team (team_ID, teamName, company_ID, lead_SSN, position) values (111007, 'Mynah, indian', 1, 1000000107, 2);
insert into team (team_ID, teamName, company_ID, lead_SSN, position) values (111008, 'Openbill, asian', 1, 1000000108, 2);
insert into team (team_ID, teamName, company_ID, lead_SSN, position) values (111009, 'Eagle, african fish', 1, 1000000109, 2);

/*Giving each team 1 project for now */

insert into project (project_ID, team_ID, projectName, startDate, endDate) values (11001, 111001, 'Myrmecophaga tridactyla', '2021-04-17', null);
insert into project (project_ID, team_ID, projectName, startDate, endDate) values (11002, 111002, 'Psittacula krameri', '2021-05-17', null);
insert into project (project_ID, team_ID, projectName, startDate, endDate) values (11003, 111003, 'Alouatta seniculus', '2021-03-13', '2022-01-17');
insert into project (project_ID, team_ID, projectName, startDate, endDate) values (11004, 111004, 'Priodontes maximus', '2021-05-26', '2021-08-17');
insert into project (project_ID, team_ID, projectName, startDate, endDate) values (11005, 111005, 'Semnopithecus entellus', '2021-08-30', null);
insert into project (project_ID, team_ID, projectName, startDate, endDate) values (11006, 111006, 'Falco peregrinus', '2021-08-25', '2021-12-17');
insert into project (project_ID, team_ID, projectName, startDate, endDate) values (11007, 111007, 'Drymarchon corias couperi', '2022-01-22', null);
insert into project (project_ID, team_ID, projectName, startDate, endDate) values (11008, 111008, 'Petaurus breviceps', '2021-12-04', null);
insert into project (project_ID, team_ID, projectName, startDate, endDate) values (11009, 111009, 'Sula nebouxii', '2021-03-28', '2021-09-17');

/* all projects now filled with 1 researchAssignment by 1 researcher, still ALL Pfizer */

insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11001, 1, 1000000111, 2, '2022-03-11', null, 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11002, 1, 1000000112, 2, '2022-02-14', null, 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11003, 1, 1000000113, 2, '2022-02-26', null, 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11004, 1, 1000000114, 2, '2022-02-19', null, 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11005, 1, 1000000115, 2, '2022-03-07', null, 1920);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11006, 1, 1000000116, 2, '2022-03-11', null, 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11007, 1, 1000000117, 2, '2022-03-10', null, 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11008, 1, 1000000118, 2, '2022-03-01', null, 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11009, 1, 1000000119, 2, '2022-02-14', null, 960);


/*Give 9 unassigned (for now) researchers, 1 to each */

insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (1, 1000001000, 2, 'Isador', 'Cranmore', '1979-08-20', 'Dari', '1 Memorial Junction', 'Porvoo', 'BC', '0e1 6r8', 'Finland', '888-856-6318', 'icranmore0@altervista.org', 424095.91, 1100, '2015-08-05', '2018-08-05');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (2, 1000002000, 2, 'Aurlie', 'Lucock', '1969-04-22', 'Papiamento', '8 Blaine Drive', 'Pagaden', 'NL', '7k6 1y6', 'Indonesia', '245-127-7570', 'alucock1@cocolog-nifty.com', 533243.95, 1200, '2010-08-10', '2013-08-10');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (3, 1000003000, 2, 'Seward', 'Bennike', '1982-10-22', 'Fijian', '92623 Hazelcrest Park', 'Alençon', 'NS', '9b3 3r6', 'France', '811-476-3466', 'sbennike2@dyndns.org', 513884.76, 1300, '2013-10-11', '2016-10-11');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (4, 1000004000, 2, 'Cecily', 'Bovaird', '1967-03-03', 'Chinese', '73 Clarendon Junction', 'Talzemt', 'NB', '6u9 0l6', 'Morocco', '337-177-6371', 'cbovaird3@vistaprint.com', 879788.54, 1400, '2015-02-27', '2018-02-27');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (5, 1000005000, 2, 'Darbee', 'Rubinivitz', '1962-05-11', 'Hindi', '583 Mitchell Terrace', 'Accha', 'SK', '6z9 0t6', 'Peru', '968-917-0891', 'drubinivitz4@bloomberg.com', 568304.91, 1500, '2013-07-19', '2016-07-19');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (6, 1000006000, 2, 'Nil', 'Sommerville', '1978-10-29', 'Bengali', '377 Old Gate Street', 'Lombog', 'QC', '9z7 5m9', 'Philippines', '250-117-1427', 'nsommerville5@is.gd', 984071.99, 1600, '2015-08-28', '2018-08-28');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (7, 1000007000, 2, 'Reinaldos', 'Silson', '1979-10-14', 'Sotho', '16 Debra Place', 'Pustomyty', 'SK', '1n8 6f0', 'Ukraine', '274-796-2839', 'rsilson6@i2i.jp', 173681.4, 1700, '2007-11-10', '2010-11-10');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (8, 1000008000, 2, 'Efrem', 'Tatham', '1964-07-25', 'Irish Gaelic', '2 Gulseth Avenue', 'Szydłowo', 'NL', '7k2 7l5', 'Poland', '259-297-9280', 'etatham7@bravesites.com', 997537.81, 1800, '2016-03-07', '2019-03-07');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (9, 1000009000, 2, 'Janna', 'Scarse', '1980-02-23', 'Ndebele', '0717 Stang Hill', 'Gayamsari', 'MB', '3d5 5l7', 'Indonesia', '992-845-1858', 'jscarse8@ucsd.edu', 279430.2, 1900, '2011-01-04', '2014-01-04');


/* New research assignment for q19 testing */
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11001, 1, 1000001000, 2, '2022-02-14', null, 480);

/* Extra purchase to test Q15 */
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (10, 1200012002, 12, 19.88, 10000);


/* Populating research assignments with exisitng researchers
	5 times for each SSN, once for each project (they were already included in one)
     */

/* SSN 1000000111 */
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11002, 1, 1000000111, 2, '2008-03-13', '2009-03-13', 1920);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11003, 1, 1000000111, 2, '2010-03-17', '2011-03-17', 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11004, 1, 1000000111, 2, '2012-03-01', '2013-03-01', 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11005, 1, 1000000111, 2, '2014-01-18', '2015-01-18', 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11006, 1, 1000000111, 2, '2016-02-28', '2017-02-28', 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11007, 1, 1000000111, 2, '2018-01-28', '2019-01-28', 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11008, 1, 1000000111, 2, '2020-01-20', '2021-01-20', 1920);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11009, 1, 1000000111, 2, '2022-01-30', null, 960);

/* SSN 1000000113 */
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11001, 1, 1000000113, 2, '2008-03-08', '2009-03-08', 1920);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11002, 1, 1000000113, 2, '2010-02-21', '2011-02-21', 1920);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11004, 1, 1000000113, 2, '2012-01-29', '2013-01-29', 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11005, 1, 1000000113, 2, '2014-02-13', '2015-02-13', 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11006, 1, 1000000113, 2, '2016-01-29', '2017-01-29', 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11007, 1, 1000000113, 2, '2018-03-09', '2019-03-09', 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11008, 1, 1000000113, 2, '2020-02-19', '2021-02-19', 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11009, 1, 1000000113, 2, '2022-03-17', null, 1920);

/* SSN 1000000115 */
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11001, 1, 1000000115, 2, '2008-03-16', '2009-03-16', 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11002, 1, 1000000115, 2, '2010-02-26', '2011-02-26', 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11003, 1, 1000000115, 2, '2012-02-12', '2013-02-12', 1920);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11004, 1, 1000000115, 2, '2014-02-26', '2015-02-26', 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11006, 1, 1000000115, 2, '2016-02-14', '2017-02-14', 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11007, 1, 1000000115, 2, '2018-01-29', '2019-01-29', 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11008, 1, 1000000115, 2, '2020-02-03', '2021-02-03', 1920);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11009, 1, 1000000115, 2, '2022-03-02', null, 960);

/* SSN 1000000117 */
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11001, 1, 1000000117, 2, '2008-03-05', '2009-03-05', 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11002, 1, 1000000117, 2, '2010-01-21', '2011-01-21', 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11003, 1, 1000000117, 2, '2012-02-28', '2013-02-28', 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11004, 1, 1000000117, 2, '2014-03-11', '2015-03-11', 1920);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11005, 1, 1000000117, 2, '2016-02-27', '2017-02-27', 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11006, 1, 1000000117, 2, '2018-03-07', '2019-03-07', 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11008, 1, 1000000117, 2, '2020-02-26', '2021-02-26', 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11009, 1, 1000000117, 2, '2022-02-27', null, 960);

/* SSN 1000000119 */
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11001, 1, 1000000119, 2, '2008-02-25', '2009-02-25', 1920);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11002, 1, 1000000119, 2, '2010-03-16', '2011-03-16', 1920);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11003, 1, 1000000119, 2, '2012-03-02', '2013-03-02', 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11004, 1, 1000000119, 2, '2014-03-01', '2015-03-01', 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11005, 1, 1000000119, 2, '2016-01-28', '2017-01-28', 480);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11006, 1, 1000000119, 2, '2018-01-18', '2019-01-18', 1920);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11007, 1, 1000000119, 2, '2020-03-13', '2021-03-13', 960);
insert into researchAssignment (project_ID, company_ID, researcher_SSN, position, startDate, endDate, totalHours) values (11008, 1, 1000000119, 2, '2022-02-27', null, 480);

/* For Q16 */
/* These are the same researchers created around line 290. Assigned to different companies andf facilities, to work on different contracts */

/* Company 3 */
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (3, 1000000111, 2, 'Marthe', 'Mount', '1975-09-04', 'Tajik', '7 Elmside Alley', 'Kertapura', 'ON', '9y2 6t1', 'Indonesia', '522-965-0698', 'mmount0@fotki.com', 508890.0, 1300, '2006-03-03', '2007-03-03');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (3, 1000000112, 2, 'Sharl', 'Jeandillou', '1986-09-27', 'Italian', '24 Texas Way', 'Banjar Tengah', 'QC', '0b7 3u4', 'Indonesia', '256-642-5953', 'sjeandillou1@behance.net', 778053.93, 1300, '2007-12-09', '2008-12-09');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (3, 1000000113, 2, 'Filmore', 'Basile', '1972-01-20', 'Bosnian', '60 Mendota Plaza', 'Loutráki', 'NT', '3y5 4u1', 'Greece', '925-489-3127', 'fbasile2@nhs.uk', 318407.83, 1300, '2006-05-12', '2007-05-12');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (3, 1000000114, 2, 'Lilla', 'Oppy', '1963-06-19', 'Czech', '5768 Ohio Park', 'Shifo', 'QC', '3s8 1u5', 'China', '778-130-9952', 'loppy3@amazon.co.uk', 687138.58, 1300, '2005-11-14', '2006-11-14');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (3, 1000000115, 2, 'Julee', 'Mattam', '1985-02-09', 'Aymara', '00877 Comanche Place', 'Capatárida', 'YT', '6d8 7b4', 'Venezuela', '155-827-7796', 'jmattam4@deviantart.com', 751221.03, 1300, '2002-02-23', '2003-02-23');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (3, 1000000116, 2, 'Barton', 'Camblin', '1976-08-18', 'Burmese', '139 Weeping Birch Road', 'Malaga', 'PE', '9i9 3d2', 'Spain', '675-806-6123', 'bcamblin5@skype.com', 752704.25, 1300, '2002-08-21', '2003-08-21');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (3, 1000000117, 2, 'Sharl', 'Corkhill', '1985-05-25', 'Haitian Creole', '856 Vernon Way', 'Chivor', 'ON', '6g6 9x9', 'Colombia', '794-826-8759', 'scorkhill6@pinterest.com', 998832.56, 1300, '2010-08-08', '2011-08-08');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (3, 1000000118, 2, 'Tobe', 'Merman', '1986-02-15', 'Marathi', '533 Fairfield Hill', 'Navariya', 'PE', '2g9 9p8', 'Ukraine', '920-694-1322', 'tmerman7@e-recht24.de', 700351.48, 1300, '2007-06-04', '2008-06-04');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (3, 1000000119, 2, 'Elna', 'Wilflinger', '1974-08-16', 'Dhivehi', '417 Crownhardt Avenue', 'Saint David’s', 'NY', '7e9 4e3', 'Grenada', '185-307-9126', 'ewilflinger8@nytimes.com', 270742.71, 1300, '2001-07-18', '2002-07-18');

/* Company 5 */
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (5, 1000000111, 2, 'Marthe', 'Mount', '1975-09-04', 'Tajik', '7 Elmside Alley', 'Kertapura', 'ON', '9y2 6t1', 'Indonesia', '522-965-0698', 'mmount0@fotki.com', 508890.0, 1500, '2008-03-03', '2009-03-03');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (5, 1000000112, 2, 'Sharl', 'Jeandillou', '1986-09-27', 'Italian', '24 Texas Way', 'Banjar Tengah', 'QC', '0b7 3u4', 'Indonesia', '256-642-5953', 'sjeandillou1@behance.net', 778053.93, 1500, '2009-12-09', '2010-12-09');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (5, 1000000113, 2, 'Filmore', 'Basile', '1972-01-20', 'Bosnian', '60 Mendota Plaza', 'Loutráki', 'NT', '3y5 4u1', 'Greece', '925-489-3127', 'fbasile2@nhs.uk', 318407.83, 1500, '2008-05-12', '2009-05-12');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (5, 1000000114, 2, 'Lilla', 'Oppy', '1963-06-19', 'Czech', '5768 Ohio Park', 'Shifo', 'QC', '3s8 1u5', 'China', '778-130-9952', 'loppy3@amazon.co.uk', 687138.58, 1500, '2007-11-14', '2008-11-14');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (5, 1000000115, 2, 'Julee', 'Mattam', '1985-02-09', 'Aymara', '00877 Comanche Place', 'Capatárida', 'YT', '6d8 7b4', 'Venezuela', '155-827-7796', 'jmattam4@deviantart.com', 751221.03, 1500, '2004-02-23', '2005-02-23');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (5, 1000000116, 2, 'Barton', 'Camblin', '1976-08-18', 'Burmese', '139 Weeping Birch Road', 'Malaga', 'PE', '9i9 3d2', 'Spain', '675-806-6123', 'bcamblin5@skype.com', 752704.25, 1500, '2004-08-21', '2005-08-21');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (5, 1000000117, 2, 'Sharl', 'Corkhill', '1985-05-25', 'Haitian Creole', '856 Vernon Way', 'Chivor', 'ON', '6g6 9x9', 'Colombia', '794-826-8759', 'scorkhill6@pinterest.com', 998832.56, 1500, '2012-08-08', '2013-08-08');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (5, 1000000118, 2, 'Tobe', 'Merman', '1986-02-15', 'Marathi', '533 Fairfield Hill', 'Navariya', 'PE', '2g9 9p8', 'Ukraine', '920-694-1322', 'tmerman7@e-recht24.de', 700351.48, 1500, '2008-06-04', '2009-06-04');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (5, 1000000119, 2, 'Elna', 'Wilflinger', '1974-08-16', 'Dhivehi', '417 Crownhardt Avenue', 'Saint David’s', 'NY', '7e9 4e3', 'Grenada', '185-307-9126', 'ewilflinger8@nytimes.com', 270742.71, 1500, '2002-07-18', '2005-07-18');

/* Company 7 */
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (7, 1000000111, 2, 'Marthe', 'Mount', '1975-09-04', 'Tajik', '7 Elmside Alley', 'Kertapura', 'ON', '9y2 6t1', 'Indonesia', '522-965-0698', 'mmount0@fotki.com', 508890.0, 1700, '2010-03-03', '2011-03-03');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (7, 1000000112, 2, 'Sharl', 'Jeandillou', '1986-09-27', 'Italian', '24 Texas Way', 'Banjar Tengah', 'QC', '0b7 3u4', 'Indonesia', '256-642-5953', 'sjeandillou1@behance.net', 778053.93, 1700, '2011-12-09', '2013-12-09');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (7, 1000000113, 2, 'Filmore', 'Basile', '1972-01-20', 'Bosnian', '60 Mendota Plaza', 'Loutráki', 'NT', '3y5 4u1', 'Greece', '925-489-3127', 'fbasile2@nhs.uk', 318407.83, 1700, '2010-05-12', '2011-05-12');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (7, 1000000114, 2, 'Lilla', 'Oppy', '1963-06-19', 'Czech', '5768 Ohio Park', 'Shifo', 'QC', '3s8 1u5', 'China', '778-130-9952', 'loppy3@amazon.co.uk', 687138.58, 1700, '2009-11-14', '2011-11-14');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (7, 1000000115, 2, 'Julee', 'Mattam', '1985-02-09', 'Aymara', '00877 Comanche Place', 'Capatárida', 'YT', '6d8 7b4', 'Venezuela', '155-827-7796', 'jmattam4@deviantart.com', 751221.03, 1700, '2006-02-23', '2007-02-23');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (7, 1000000116, 2, 'Barton', 'Camblin', '1976-08-18', 'Burmese', '139 Weeping Birch Road', 'Malaga', 'PE', '9i9 3d2', 'Spain', '675-806-6123', 'bcamblin5@skype.com', 752704.25, 1700, '2007-08-21', '2008-08-21');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (7, 1000000117, 2, 'Sharl', 'Corkhill', '1985-05-25', 'Haitian Creole', '856 Vernon Way', 'Chivor', 'ON', '6g6 9x9', 'Colombia', '794-826-8759', 'scorkhill6@pinterest.com', 998832.56, 1700, '2015-08-08', '2016-08-08');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (7, 1000000118, 2, 'Tobe', 'Merman', '1986-02-15', 'Marathi', '533 Fairfield Hill', 'Navariya', 'PE', '2g9 9p8', 'Ukraine', '920-694-1322', 'tmerman7@e-recht24.de', 700351.48, 1700, '2010-06-04', '2012-06-04');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (7, 1000000119, 2, 'Elna', 'Wilflinger', '1974-08-16', 'Dhivehi', '417 Crownhardt Avenue', 'Saint David’s', 'NY', '7e9 4e3', 'Grenada', '185-307-9126', 'ewilflinger8@nytimes.com', 270742.71, 1700, '2005-07-18', '2007-07-18');

/*Company 9 */
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (9, 1000000111, 2, 'Marthe', 'Mount', '1975-09-04', 'Tajik', '7 Elmside Alley', 'Kertapura', 'ON', '9y2 6t1', 'Indonesia', '522-965-0698', 'mmount0@fotki.com', 508890.0, 1900, '2012-03-03', '2013-03-03');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (9, 1000000112, 2, 'Sharl', 'Jeandillou', '1986-09-27', 'Italian', '24 Texas Way', 'Banjar Tengah', 'QC', '0b7 3u4', 'Indonesia', '256-642-5953', 'sjeandillou1@behance.net', 778053.93, 1900, '2015-12-09', '2017-12-09');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (9, 1000000113, 2, 'Filmore', 'Basile', '1972-01-20', 'Bosnian', '60 Mendota Plaza', 'Loutráki', 'NT', '3y5 4u1', 'Greece', '925-489-3127', 'fbasile2@nhs.uk', 318407.83, 1900, '2012-05-12', '2013-05-12');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (9, 1000000114, 2, 'Lilla', 'Oppy', '1963-06-19', 'Czech', '5768 Ohio Park', 'Shifo', 'QC', '3s8 1u5', 'China', '778-130-9952', 'loppy3@amazon.co.uk', 687138.58, 1900, '2013-11-14', '2014-11-14');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (9, 1000000115, 2, 'Julee', 'Mattam', '1985-02-09', 'Aymara', '00877 Comanche Place', 'Capatárida', 'YT', '6d8 7b4', 'Venezuela', '155-827-7796', 'jmattam4@deviantart.com', 751221.03, 1900, '2009-02-23', '2011-02-23');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (9, 1000000116, 2, 'Barton', 'Camblin', '1976-08-18', 'Burmese', '139 Weeping Birch Road', 'Malaga', 'PE', '9i9 3d2', 'Spain', '675-806-6123', 'bcamblin5@skype.com', 752704.25, 1900, '2009-08-21', '2015-08-21');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (9, 1000000117, 2, 'Sharl', 'Corkhill', '1985-05-25', 'Haitian Creole', '856 Vernon Way', 'Chivor', 'ON', '6g6 9x9', 'Colombia', '794-826-8759', 'scorkhill6@pinterest.com', 998832.56, 1900, '2016-08-08', '2017-08-08');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (9, 1000000118, 2, 'Tobe', 'Merman', '1986-02-15', 'Marathi', '533 Fairfield Hill', 'Navariya', 'PE', '2g9 9p8', 'Ukraine', '920-694-1322', 'tmerman7@e-recht24.de', 700351.48, 1900, '2014-06-04', '2015-06-04');
insert into employee (company_ID, SSN, position, firstName, lastName, dateOfBirth, citizenship, address, city, province, postalCode, country, phoneNumber, email, salary, facility, startDate, endDate) values (9, 1000000119, 2, 'Elna', 'Wilflinger', '1974-08-16', 'Dhivehi', '417 Crownhardt Avenue', 'Saint David’s', 'NY', '7e9 4e3', 'Grenada', '185-307-9126', 'ewilflinger8@nytimes.com', 270742.71, 1900, '2008-07-18', '2009-07-18');



/* Extra Contracts and purchases for Q20 */

insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10010, 900, 'Sherilyn Pawelski', 1, 1000000001, 1, '2021-12-19', '2022-03-16');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10011, 200, 'Marlin Kellen', 2, 1000000002, 1, '2019-01-31', '2022-03-11');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10012, 400, 'Anestassia MacCarlich', 3, 1000000003, 1, '2019-11-28', '2022-03-15');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10013, 800, 'Ilse Ronnay', 4, 1000000004, 1, '2019-11-12', '2022-02-20');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10014, 200, 'Hilly Burfield', 5, 1000000005, 1, '2019-12-23', '2022-02-08');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10015, 400, 'Wash Boggis', 6, 1000000006, 1, '2019-07-14', '2022-03-07');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10016, 100, 'Ardys Rosborough', 7, 1000000007, 1, '2019-08-10', '2022-03-23');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10017, 800, 'Tana Beekmann', 8, 1000000008, 1, '2019-11-04', '2022-03-21');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10018, 900, 'Palm Chaikovski', 9, 1000000009, 1, '2019-06-29', '2022-02-10');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10019, 100, 'Rayshell Gostick', 1, 1000000001, 1, '2020-02-07', '2022-03-22');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10020, 600, 'Mattias Tansley', 2, 1000000002, 1, '2020-08-19', '2022-03-09');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10021, 600, 'Amory Attwoul', 3, 1000000003, 1, '2020-09-14', '2022-03-18');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10022, 300, 'Daven Goodie', 4, 1000000004, 1, '2020-05-20', '2022-02-23');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10023, 700, 'Carlene Aldridge', 5, 1000000005, 1, '2020-03-04', '2022-02-16');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10024, 300, 'Gypsy Lockyer', 6, 1000000006, 1, '2020-04-30', '2022-02-07');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10025, 900, 'Vanny Gaisford', 7, 1000000007, 1, '2020-09-03', '2022-03-19');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10026, 200, 'Denny Winger', 8, 1000000008, 1, '2020-10-30', '2022-03-08');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10027, 300, 'Herta Perham', 9, 1000000009, 1, '2020-06-29', '2022-02-20');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10028, 300, 'Harmon Kimmel', 1, 1000000001, 1, '2021-06-29', '2022-03-01');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10029, 100, 'Dael Hazley', 2, 1000000002, 1, '2021-10-16', '2022-03-21');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10030, 100, 'Dolley Fabbro', 3, 1000000003, 1, '2021-06-12', '2022-02-20');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10031, 100, 'Far Djokovic', 4, 1000000004, 1, '2021-05-28', '2022-02-22');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10032, 900, 'Shirline Cordoba', 5, 1000000005, 1, '2021-08-09', '2022-02-04');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10033, 200, 'Mervin Pautard', 6, 1000000006, 1, '2021-12-28', '2022-03-25');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10034, 400, 'Kurt Keepe', 7, 1000000007, 1, '2021-06-17', '2022-03-02');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10035, 300, 'Kailey Feldheim', 8, 1000000008, 1, '2021-05-04', '2022-03-08');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10036, 100, 'Gayle Velte', 9, 1000000009, 1, '2021-11-11', '2022-03-18');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10037, 600, 'Omero Linck', 1, 1000000001, 1, '2022-01-13', '2022-03-17');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10038, 300, 'Elvin Martinek', 2, 1000000002, 1, '2022-01-22', '2022-03-12');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10039, 700, 'Anett Kipling', 3, 1000000003, 1, '2022-01-13', '2022-02-24');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10040, 400, 'Lance Pirson', 4, 1000000004, 1, '2022-01-05', '2022-03-16');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10041, 800, 'Gloriane Pickover', 5, 1000000005, 1, '2022-01-25', '2022-03-08');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10042, 500, 'Wit Luthwood', 6, 1000000006, 1, '2022-01-09', '2022-02-03');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10043, 900, 'Starlene Macci', 7, 1000000007, 1, '2022-01-07', '2022-03-17');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10044, 700, 'Jobye Scandwright', 8, 1000000008, 1, '2022-01-26', '2022-02-02');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10045, 900, 'Marilee Mapp', 9, 1000000009, 1, '2022-01-03', '2022-02-23');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10046, 200, 'Athena Paydon', 1, 1000000001, 1, '2021-10-23', '2022-02-20');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10047, 300, 'Phip Pessel', 2, 1000000002, 1, '2020-11-21', '2022-02-26');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10048, 700, 'Rickert Guare', 3, 1000000003, 1, '2021-05-14', '2022-03-11');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10049, 900, 'Dru Alekhov', 4, 1000000004, 1, '2019-12-31', '2022-03-05');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10050, 200, 'Nora Pounsett', 5, 1000000005, 1, '2021-02-04', '2022-02-17');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10051, 400, 'Emlyn Stallard', 6, 1000000006, 1, '2021-05-08', '2022-02-14');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10052, 400, 'Grant Yegorchenkov', 7, 1000000007, 1, '2020-02-28', '2022-02-21');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10053, 200, 'Ilsa Eiler', 8, 1000000008, 1, '2020-01-25', '2022-02-24');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10054, 200, 'Debora Frenzel;', 9, 1000000009, 1, '2020-04-04', '2022-03-15');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10055, 100, 'Vachel Romme', 1, 1000000001, 1, '2019-01-23', '2022-03-23');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10056, 700, 'Ninetta Oldall', 2, 1000000002, 1, '2020-04-01', '2022-03-23');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10057, 300, 'Byram Chadburn', 3, 1000000003, 1, '2022-01-27', '2022-02-28');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10058, 600, 'Edie Worsam', 4, 1000000004, 1, '2020-07-25', '2022-02-14');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10059, 800, 'Emlynne Parfrey', 5, 1000000005, 1, '2020-08-22', '2022-02-24');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10060, 600, 'Antonius MacAllister', 6, 1000000006, 1, '2020-07-01', '2022-02-21');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10061, 300, 'Amberly Lysons', 7, 1000000007, 1, '2019-12-08', '2022-03-16');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10062, 500, 'Hortensia Alastair', 8, 1000000008, 1, '2021-03-17', '2022-03-01');
insert into contract (contract_ID, client_ID, clientname, company_ID, employee_SSN, position, contractDate, deliveryDate) values (10063, 900, 'Janeva Gabbitus', 9, 1000000009, 1, '2020-11-14', '2022-03-05');

/* Noww the purchases associated to above contracts */

insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (31, 1200012004, 54, 33.45, 10010);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (32, 1200012005, 24, 16.56, 10011);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (33, 1200012003, 3, 33.27, 10012);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (34, 1200012007, 52, 39.37, 10013);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (35, 1200012001, 38, 26.79, 10014);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (36, 1200012001, 65, 18.37, 10015);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (37, 1200012002, 73, 21.04, 10016);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (38, 1200012005, 24, 18.44, 10017);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (39, 1200012003, 81, 10.4, 10018);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (40, 1200012002, 48, 49.5, 10019);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (41, 1200012004, 56, 16.9, 10020);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (42, 1200012003, 6, 14.1, 10021);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (43, 1200012007, 63, 44.28, 10022);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (44, 1200012008, 78, 47.42, 10023);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (45, 1200012002, 90, 36.51, 10024);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (46, 1200012005, 58, 21.19, 10025);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (47, 1200012005, 60, 1.29, 10026);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (48, 1200012001, 10, 25.22, 10027);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (49, 1200012005, 86, 8.7, 10028);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (50, 1200012003, 97, 26.23, 10029);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (51, 1200012007, 49, 40.62, 10030);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (52, 1200012008, 4, 1.67, 10031);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (53, 1200012008, 32, 38.11, 10032);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (54, 1200012007, 76, 35.97, 10033);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (55, 1200012006, 40, 8.7, 10034);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (56, 1200012004, 74, 19.39, 10035);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (57, 1200012002, 7, 1.9, 10036);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (58, 1200012006, 57, 24.82, 10037);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (59, 1200012008, 16, 16.79, 10038);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (60, 1200012003, 1, 32.11, 10039);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (61, 1200012001, 93, 40.26, 10040);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (62, 1200012005, 39, 21.25, 10041);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (63, 1200012009, 59, 48.01, 10042);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (64, 1200012005, 82, 16.04, 10043);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (65, 1200012008, 90, 29.0, 10044);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (66, 1200012003, 18, 3.37, 10045);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (67, 1200012004, 20, 27.9, 10046);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (68, 1200012008, 69, 6.84, 10047);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (69, 1200012006, 45, 8.21, 10048);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (70, 1200012005, 28, 24.19, 10049);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (71, 1200012007, 98, 12.21, 10050);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (72, 1200012005, 95, 49.61, 10051);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (73, 1200012009, 98, 29.02, 10052);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (74, 1200012004, 60, 30.28, 10053);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (75, 1200012006, 1, 3.99, 10054);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (76, 1200012003, 96, 16.11, 10055);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (77, 1200012007, 54, 39.79, 10056);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (78, 1200012005, 56, 27.71, 10057);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (79, 1200012005, 73, 17.36, 10058);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (80, 1200012006, 70, 22.25, 10059);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (81, 1200012002, 3, 49.37, 10060);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (82, 1200012004, 85, 25.25, 10061);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (83, 1200012002, 43, 37.23, 10062);
insert into purchase (purchase_ID, product_ID, quantity, unitPrice, contract_ID) values (84, 1200012002, 22, 23.71, 10063);


/* ---------------------------------------------- */
/*

Creating Triggers

Ended up coding them PHP sided because of issue with PHP version on the server

DELIMITER $$

Create Trigger updateHeadOffice before update on headOffice  
for each row begin
if new.company_ID not in (select pharmaCompany.company_ID from pharmaCompany) then
	signal sqlstate '45000' set message_text = 'Warning: No Company with that ID exists$';
elseif new.CEO_SSN not in (select employee.SSN from employee) then
	signal sqlstate '45000' set message_text = 'Warning: No Employee with that SSN exists$';
elseif new.CEO_SSN = (select CEO_SSN from headOffice join pharmaCompany on headOffice.company_ID = pharmaCompany.company_ID where pharmaCompany.company_ID = new.company_ID) then
	signal sqlstate '45000' set message_text = 'Warning: This Employee is already CEO of this company$';
end if;
end$$

Create Trigger insertEmployee before insert on employee  
for each row begin
if new.company_ID not in (select pharmaCompany.company_ID from pharmaCompany) then
	signal sqlstate '45000' set message_text = 'Warning: No Company with that ID exists$';
elseif new.SSN in (select employee.SSN from employee where SSN = new.SSN and position=(select position_ID from jobPosition where jobTitle="CEO") and (endDate is null or endDate >=	current_Date()) 
and employee.company_ID = new.company_ID) then
	signal sqlstate '45000' set message_text = 'Warning: Employee is already CEO$';
end if;
end$$
	

Create Trigger insertResearcher before insert on researchAssignment  
for each row begin
if new.researcher_SSN not in (select employee.SSN from employee) then
	signal sqlstate '45000' set message_text = 'Warning: No Employee with that SSN exists$';
elseif new.company_ID not in (select pharmaCompany.company_ID from pharmaCompany) then
	signal sqlstate '45000' set message_text = 'Warning: No Company with that ID exists$';
elseif new.project_ID not in (select project_ID from project) then
	signal sqlstate '45000' set message_text = 'Warning: No Project with that ID exists$';
elseif new.researcher_SSN not in (select employee.SSN from employee where position=(select position_ID from jobPosition where jobTitle="Researcher")) then
	signal sqlstate '45000' set message_text = 'Warning: Employee with this SSN is not a Researcher$';
elseif new.researcher_SSN not in (select employee.SSN from employee where (endDate > current_Date() or endDate is null) and SSN = new.researcher_ssn) then
	signal sqlstate '45000' set message_text = 'Warning: Employee no longer works here';
elseif new.researcher_SSN in (select researcher_SSN from researchAssignment where researcher_SSN = new.researcher_SSN and project_ID = new.project_ID and company_ID = new.company_ID) then
	signal sqlstate '45000' set message_text = 'Warning: Employee is already a member of this project$';
elseif new.company_ID not in (select pharmaCompany.company_ID from pharmaCompany join employee on pharmaCompany.company_ID = employee.company_ID where SSN = new.researcher_SSN and (endDate > current_Date() or endDate is null)) then
	signal sqlstate '45000' set message_text = 'Warning: Researcher does not work for this company$';
end if;
end$$
DELIMITER ;
*/
/*----------------------------------------------- */