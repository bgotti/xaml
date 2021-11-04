/*
** Copyright Microsoft, Inc. 1994 - 2000
** All Rights Reserved.
*/

DROP TABLE IF EXISTS "Orders";
DROP TABLE IF EXISTS "Products";
DROP TABLE IF EXISTS "Categories";
DROP TABLE IF EXISTS "Customers";
DROP TABLE IF EXISTS "Employees";

CREATE TABLE "Employees" (
	"EmployeeID" INTEGER PRIMARY KEY,
	"LastName" nvarchar (20) NOT NULL ,
	"FirstName" nvarchar (10) NOT NULL ,
	"Title" nvarchar (30) NULL ,
	"DateOfBirth" "datetime" NULL ,
	"HiringDate" "datetime" NULL ,
	"Address" nvarchar (60) NULL ,
	"State" nvarchar (15) NULL ,
	"ZipCode" nvarchar (10) NULL ,
	"Country" nvarchar (15) NULL ,
	"Telephone" nvarchar (24) NULL ,
	"Extension" nvarchar (4) NULL ,
	"Notes" "ntext" NULL 
);

CREATE INDEX "LastName" ON "Employees"("LastName");

CREATE INDEX "ZipCodeEmployees" ON "Employees"("ZipCode");

CREATE TABLE "Categories" (
	"CategoryID" INTEGER PRIMARY KEY,
	"CategoryName" nvarchar (15) NOT NULL ,
	"Description" "ntext" NULL ,
	"Photo" "image" NULL
);

CREATE INDEX "CategoryName" ON "Categories"("CategoryName");

CREATE TABLE "Customers" (
	"CustomerID" nchar (5) NOT NULL ,
	"CompanyName" nvarchar (40) NOT NULL ,
	"CompanyContact" nvarchar (30) NULL ,
	"ContactTitle" nvarchar (30) NULL ,
	"Address" nvarchar (60) NULL ,
	"State" nvarchar (15) NULL ,
	"ZipCode" nvarchar (10) NULL ,
	"Country" nvarchar (15) NULL ,
	"Telephone" nvarchar (24) NULL ,
	"Fax" nvarchar (24) NULL ,
	CONSTRAINT "PK_Customers" PRIMARY KEY  
	(
		"CustomerID"
	)
);

CREATE INDEX "State" ON "Customers"("State");

CREATE INDEX "CompanyNameCustomers" ON "Customers"("CompanyName");

CREATE INDEX "ZipCodeCustomers" ON "Customers"("ZipCode");

CREATE TABLE "Orders" (
	"OrderID" INTEGER PRIMARY KEY,
	"CustomerID" nchar (5) NULL ,
	"EmployeeID" "int" NULL ,
	"OrderDate" "datetime" NULL ,
	"RequiredDate" "datetime" NULL ,
	"DateOrigin" "datetime" NULL ,
	"AddressOrigin" nvarchar (60) NULL ,
	"CityOrigin" nvarchar (15) NULL ,
	"ZipCodeOrigin" nvarchar (10) NULL ,
	"CountryOrigin" nvarchar (15) NULL ,
	CONSTRAINT "FK_Orders_Customers" FOREIGN KEY 
	(
		"CustomerID"
	) REFERENCES "Customers" (
		"CustomerID"
	),
	CONSTRAINT "FK_Orders_Employees" FOREIGN KEY 
	(
		"EmployeeID"
	) REFERENCES "Employees" (
		"EmployeeID"
	)	
);

CREATE INDEX "CustomerID" ON "Orders"("CustomerID");
CREATE INDEX "CustomersOrders" ON "Orders"("CustomerID");
CREATE INDEX "EmployeeID" ON "Orders"("EmployeeID");
CREATE INDEX "EmployeesOrders" ON "Orders"("EmployeeID");
CREATE INDEX "OrderDate" ON "Orders"("OrderDate");
CREATE INDEX "DateOrigin" ON "Orders"("DateOrigin");
CREATE INDEX "ZipCodeOrigin" ON "Orders"("ZipCodeOrigin");

CREATE TABLE "Products" (
	"ProductID" INTEGER PRIMARY KEY,
	"ProductName" nvarchar (40) NOT NULL ,
	"CategoryID" "int" NULL ,
	"QuantityPerUnit" nvarchar (20) NULL ,
	"UnitPrice" "money" NULL CONSTRAINT "DF_Products_UnitPrice" DEFAULT (0),
	"UnitsInStock" "smallint" NULL CONSTRAINT "DF_Products_UnitsInStock" DEFAULT (0),
	"UnitsPerOrder" "smallint" NULL CONSTRAINT "DF_Products_UnitsPerOrder" DEFAULT (0),
	"Discontinued" "bit" NOT NULL CONSTRAINT "DF_Products_Discontinued" DEFAULT (0),
	CONSTRAINT "FK_Products_Categories" FOREIGN KEY 
	(
		"CategoryID"
	) REFERENCES "Categories" (
		"CategoryID"
	),
	
	CONSTRAINT "CK_Products_UnitPrice" CHECK (UnitPrice >= 0),
	CONSTRAINT "CK_UnitsInStock" CHECK (UnitsInStock >= 0),
	CONSTRAINT "CK_UnitsPerOrder" CHECK (UnitsPerOrder >= 0)
);

CREATE INDEX "CategoriesProducts" ON "Products"("CategoryID");
CREATE INDEX "CategoryID" ON "Products"("CategoryID");
CREATE INDEX "ProductName" ON "Products"("ProductName");

INSERT INTO "Categories"("CategoryID","CategoryName","Description","Photo") 
VALUES(1,'Beverages','Soft drinks, coffees, teas, beers, and ales',null),
(2,'Condiments','Sweet and savory sauces, relishes, spreads, and seasonings',null),
(3,'Confections','Desserts, candies, and sweet breads',null),
(4,'Dairy Products','Cheeses',null),
(5,'Grains/Cereals','Breads, crackers, pasta, and cereal',null),
(6,'Meat/Poultry','Prepared meats',null),
(7,'Produce','Dried fruit and bean curd',null),
(8,'Seafood','Seaweed and fish',null);

INSERT INTO "Customers" VALUES('ALFKI', 'Alfreds Futterkiste', 	'Maria Anders', 	'Sales Representative', 	'Obere Str. 57', 	NULL, 	'12209', 	'Germany', 	'030-0074321', 	'030-0076545')	;
INSERT INTO "Customers" VALUES('ANATR', 'Ana Trujillo Emparedados y helados', 	'Ana Trujillo', 	'Owner', 	'Avda. de la Constituci�n 2222', 	NULL, 	'05021', 	'Mexico', 	'(5) 555-4729', 	'(5) 555-3745')	;
INSERT INTO "Customers" VALUES('ANTON', 'Antonio Moreno Taquer�a', 	'Antonio Moreno', 	'Owner', 	'Mataderos  2312', 	NULL, 	'05023', 	'Mexico', 	'(5) 555-3932', 	NULL)	;
INSERT INTO "Customers" VALUES('AROUT', 'Around the Horn', 	'Thomas Hardy', 	'Sales Represative', 	'120 Hanover Sq.', 	NULL, 	'WA1 1DP', 	'UK', 	'(171) 555-7788', 	'(171) 555-6750')	;
INSERT INTO "Customers" VALUES('BERGS', 'Berglunds snabbk�p', 	'Christina Berglund', 	'Order Administrator', 	'Berguvsv�gen  8', 	NULL, 	'S-958 22', 	'Sweden', 	'0921-12 34 65', 	'0921-12 34 67')	;
INSERT INTO "Customers" VALUES('BLAUS', 'Blauer See Delikatessen', 	'Hanna Moos', 	'Sales Representative', 	'Forsterstr. 57', 	NULL, 	'68306', 	'Germany', 	'0621-08460', 	'0621-08924')	;
INSERT INTO "Customers" VALUES('BOTTM', 'Bottom-Dollar Markets', 	'Elizabeth Lincoln', 	'Accounting Manager', 	'23 Tsawassen Blvd.', 	'BC', 	'T2F 8M4', 	'Canada', 	'(604) 555-4729', 	'(604) 555-3745')	;
INSERT INTO "Customers" VALUES('BSBEV', 'B''s Beverages', 	'Victoria Ashworth', 	'Sales Representative', 	'Fauntleroy Circus', 	NULL, 	'EC2 5NT', 	'UK', 	'(171) 555-1212', 	NULL)	;
INSERT INTO "Customers" VALUES('CACTU', 'Cactus Comidas para llevar', 	'Patricio Simpson', 	'Sales Agent', 	'Cerrito 333', 	NULL, 	'1010', 	'Argentina', 	'(1) 135-5555', 	'(1) 135-4892')	;
INSERT INTO "Customers" VALUES('CENTC', 'Centro comercial Moctezuma', 	'Francisco Chang', 	'Marketing Manager', 	'Sierras de Granada 9993', 	NULL, 	'05022', 	'Mexico', 	'(5) 555-3392', 	'(5) 555-7293')	;
INSERT INTO "Customers" VALUES('CHOPS', 'Chop-suey Chinese', 	'Yang Wang', 	'Owner', 	'Hauptstr. 29', 	NULL, 	'3012', 	'Switzerland', 	'0452-076545', 	NULL)	;
INSERT INTO "Customers" VALUES('COMMI', 'Com�rcio Mineiro', 	'Pedro Afonso', 	'Sales Associate', 	'Av. dos Lus�adas', 	'Sao Paulo', 	'SP', 	'05432-043', 'Brazil', '(11) 555-7647');
INSERT INTO "Customers" VALUES('CONSH', 'Consolidated Holdings', 	'Elizabeth Brown', 	'Sales Representative', 	'Berkeley Gardens 12  Brewery', 	NULL, 	'WX1 6LT', 	'UK', 	'(171) 555-2282', 	'(171) 555-9199');
INSERT INTO "Customers" VALUES('DRACD', 'Drachenblut Delikatessen', 	'Sven Ottlieb', 	'Order Administrator', 	'Walserweg 21', 	NULL, 	'52066', 	'Germany', 	'0241-039123', 	'0241-059428');
INSERT INTO "Customers" VALUES('EASTC', 'Eastern Connection', 	'Ann Devon', 	'Sales Agent', 	'35 King George', 	NULL, 	'WX3 6FW', 	'UK', 	'(171) 555-0297', 	'(171) 555-3373');	
INSERT INTO "Customers" VALUES('ERNSH', 'Ernst Handel', 	'Roland Mendel', 	'Sales Manager', 	'Kirchgasse 6', 	NULL, 	'8010', 	'Austria', 	'7675-3425', 	'7675-3426')	;
INSERT INTO "Customers" VALUES('FISSA', 'FISSA Fabrica Inter. Salchichas S.A.', 	'Diego Roel', 	'Accounting Manager', 	'C/ Moralzarzal', 	'Madrid', 	'28034', 	'Spain', 	'(91) 555 94 44',	'(91) 555 55 93');
INSERT INTO "Customers" VALUES('FOLKO', 'Folk och f� HB', 	'Maria Larsson', 	'Owner', 	'�kergatan 24', 	NULL, 	'S-844 67', 	'Sweden', 	'0695-34 67 21', 	NULL);
INSERT INTO "Customers" VALUES('FRANS', 'Franchi S.p.A.', 	'Paolo Accorti', 	'Sales Representative', 	'Via Monte Bianco 34', 	NULL, 	'10100', 	'Italy', 	'011-4988260', 	'011-4988261');
INSERT INTO "Customers" VALUES('FURIB', 'Furia Bacalhau e Frutos do Mar', 	'Lino Rodriguez', 	'Sales Manager', 	'Jardim das rosas n. 32', 	NULL, 	'1675', 	'Portugal', 	'(1) 354-2534', 	'(1) 354-2535');
INSERT INTO "Customers" VALUES('HUNGO', 'Hungry Owl All-Night Grocers', 	'Patricia McKenna', 	'Sales Associate', 	'8 Johnstown Road', 	'Co. Cork', 	NULL, 	'Ireland', 	'2967 542', 	'2967 3333');	
INSERT INTO "Customers" VALUES('ISLAT', 'Island Trading', 	'Helen Bennett', 	'Marketing Manager', 	'Garden House Crowther Way', 	'Isle of Wight', 	'PO31 7PJ', 	'UK', 	'(198) 555-8888', 	NULL);	
INSERT INTO "Customers" VALUES('KOENE', 'K�niglich Essen', 	'Philip Cramer', 	'Sales Associate', 	'Maubelstr. 90', 	NULL, 	'14776', 	'Germany', 	'0555-09876', 	NULL);
INSERT INTO "Customers" VALUES('LACOR', 'La corne d''abondance', 	'Daniel Tonini', 	'Sales Representative', 	'67', 	'Versailles', 	'78000', 	'France', 	'30.59.84.10',	'30.59.85.11');
INSERT INTO "Customers" VALUES('LAUGB', 'Laughing Bacchus Wine Cellars', 	'Yoshi Tannamuri', 	'Marketing Assistant', 	'1900 Oak St.', 	'BC', 	'V3F 2K1', 	'Canada', 	'(604) 555-3392', 	'(604) 555-7293');
INSERT INTO "Customers" VALUES('LAZYK', 'Lazy K Kountry Store', 	'John Steel', 	'Marketing Manager', 	'12 Orchestra Terrace', 	'WA', 	'99362', 	'USA', 	'(509) 555-7969', 	'(509) 555-6221');
INSERT INTO "Customers" VALUES('LEHMS', 'Lehmanns Marktstand', 	'Renate Messner', 	'Sales Representative', 	'Magazinweg 7', 	NULL, 	'60528', 	'Germany', 	'069-0245984', 	'069-0245874');	
INSERT INTO "Customers" VALUES('LETSS', 'Let''s Stops N Shop', 	'Jaime Yorres', 	'Owner', 	'87 Polk St. Suite 5', 	'CA', 	'94117', 	'USA', 	'(415) 555-5938', 	NULL);
INSERT INTO "Customers" VALUES('LILAS', 'LILA-Supermercado', 	'Carlos Gonz�lez', 	'Accounting Manager', 	'Carrera 52 con Ave. Bol�var #65-98 Llano Largo', 	'Lara', 	'3508', 	'Venezuela', 	'(9) 331-6954', 	'(9) 331-7256');
INSERT INTO "Customers" VALUES('LINOD', 'LINO-Delicateses', 	'Felipe Izquierdo', 	'Owner', 	'Ave. 5 de Mayo Porlamar', 	'Nueva Esparta', 	'4980', 	'Venezuela', 	'(8) 34-56-12', 	'(8) 34-93-93');
INSERT INTO "Customers" VALUES('LONEP', 'Lonesome Pine Restaurant', 	'Fran Wilson', 	'Sales Manager', 	'89 Chiaroscuro Rd.', 	'ORL', 	'97219', 	'USA', 	'(503) 555-9573', 	'(503) 555-9646');
INSERT INTO "Customers" VALUES('MAGAA', 'Magazzini Alimentari', 	'Giovanni Rovelli', 	'Marketing Manager', 	'Via Ludovico il Moro 22', 	NULL, 	'24100', 	'Italy', 	'035-640230', 	'035-640231');
INSERT INTO "Customers" VALUES('MAISD', 'Maison Dewey', 	'Catherine Dewey', 	'Sales Agent', 	'Rue Joseph-Bens 532', 	NULL, 	'B-1180', 	'Belgium', 	'(02) 201 24 67', 	'(02) 201 24 68');
INSERT INTO "Customers" VALUES('MEREP', 'M�re Paillarde', 	'Jean Fresni�re', 	'Marketing Assistant', 	'43 rue St. Laurent', 	'Qu�bec', 	'H1J 1C3', 	'Canada', 	'(514) 555-8054', 	'(514) 555-8055');
INSERT INTO "Customers" VALUES('MORGK', 'Morgenstern Gesundkost', 	'Alexander Feuer', 	'Marketing Assistant', 	'Heerstr. 22', 	NULL, 	'04179', 	'Germany', 	'0342-023176', 	NULL);
INSERT INTO "Customers" VALUES('NORTS', 'North/South', 	'Simon Crowther', 	'Sales Associate', 	'South House 300 Queensbridge', 	NULL, 	'SW7 1RZ', 	'UK', 	'(171) 555-7733', 	'(171) 555-2530');
INSERT INTO "Customers" VALUES('OCEAN', 'Oc�ano Atl�ntico Ltda.', 	'Yvonne Moncada', 	'Sales Agent', 	'Ing. Gustavo Moncada 8585 Piso 20-A', 	NULL, 	'1010', 	'Argentina', 	'(1) 135-5333', 	'(1) 135-5535');
INSERT INTO "Customers" VALUES('OLDWO', 'Old World Delicatessen', 	'Rene Phillips', 	'Sales Representative', 	'2743 Bering St.', 	'AK', 	'99508', 	'USA', 	'(907) 555-7584', 	'(907) 555-2880');
INSERT INTO "Customers" VALUES('OTTIK', 'Ottilies K�seladen', 	'Henriette Pfalzheim', 	'Owner', 	'Mehrheimerstr. 369', 	NULL, 	'50739', 	'Germany', 	'0221-0644327', 	'0221-0765721');
INSERT INTO "Customers" VALUES('PARIS', 'Paris sp�cialit�s', 	'Marie Bertrand', 	'Owner', 	'265', 	'Paris',  	'75012', 	'France', 	'42.34.22.66',	'42.34.22.77');
INSERT INTO "Customers" VALUES('PERIC', 'Pericles Comidas cl�sicas', 	'Guillermo Fern�ndez', 	'Sales Representative', 	'Calle Dr. Jorge Cash 321', 	NULL, 	'05033', 	'Mexico', 	'(5) 552-3745', '545-3745');
INSERT INTO "Customers" VALUES('PICCO', 'Piccolo und mehr', 	'Georg Pipps', 	'Sales Manager', 	'Geislweg 14', 	NULL, 	'5020', 'Austria', 	'6562-9722', 	'6562-9723');
INSERT INTO "Customers" VALUES('PRINI', 'Princesa Isabel Vinhos', 	'Isabel de Castro', 	'Sales Representative', 'Estrada da sa�de n. 58', 	NULL, 	'1756', 	'Portugal', 	'(1) 356-5634', 	NULL)	
INSERT INTO "Customers" VALUES('QUICK', 'QUICK-Stops', 	'Horst Kloss', 	'Accounting Manager', 	'Taucherstra�e 10', 	NULL, 	'01307', 	'Germany', 	'0372-035188', 	NULL);	
INSERT INTO "Customers" VALUES('RANCH', 'Rancho grande', 	'Sergio Guti�rrez', 'Sales Representative', 	'Av. del Libertador 900', 	NULL, 	'1010', 	'Argentina', 	'(1) 123-5555', 	'(1) 123-5556');
INSERT INTO "Customers" VALUES('RATTC', 'Rattlesnake Canyon Grocery', 'Paula Wilson', 	'Assistant Sales Representative', 	'2817 Milton Dr.', 	'NM', 	'87110', 	'USA', 	'(505) 555-5939', 	'(505) 555-3620');
INSERT INTO "Customers" VALUES('REGGC', 'Reggiani Caseifici', 'Maurizio Moroni', 	'Sales Associate', 	'Strada Provinciale 124', 	NULL, 	'42100', 	'Italy', 	'0522-556721', 	'0522-556722');
INSERT INTO "Customers" VALUES('RICSU', 'Richter Supermarkt', 	'Michael Holz', 	'Sales Manager', 	'Grenzacherweg 237', 	NULL, 	'1203', 	'Switzerland', 	'0897-034214', 	NULL);
INSERT INTO "Customers" VALUES('SANTG', 'Sant� Gourmet', 'Jonas Bergulfsen', 'Owner', 	'Erling Skakkes gate 78', 	NULL, 	'4110', 	'Norway', 	'07-98 92 35', 	'07-98 92 47');
INSERT INTO "Customers" VALUES('SAVEA', 'Save-a-lot Markets', 	'Jose Pavarotti', 	'Sales Representative', 	'187 Suffolk Ln.', 	'ID', 	'83720', 	'USA', 	'(208)555-8097', 	NULL);	
INSERT INTO "Customers" VALUES('SEVES', 'Seven Seas Imports', 	'Hari Kumar', 	'Sales Manager', 	'90 Wadhurst Rd.', 	NULL, 	'OX15 4NB', 	'UK', 	'(171)555-1717', 	'(171) 555-5646');
INSERT INTO "Customers" VALUES('SIMOB', 'Simons bistro', 	'Jytte Petersen', 	'Owner', 	'Vinb�ltet 34', 	NULL, 	'1734', 	'Denmark', 	'31 12 34 56', 	'31 13 35 57');	
INSERT INTO "Customers" VALUES('SPECD', 'Sp�cialit�s du monde', 'Dominique Perrier', 	'Marketing Manager', 	'25', 	'Paris', 	'75016', 	'France', 	'47.55.60.10',	'47.55.60.20');
INSERT INTO "Customers" VALUES('SPLIR', 'Split Rail Beer & Ale', 	'Art Braunschweiger', 	'Sales Manager', 	'P.O. Box 555', 	'WY', 	'82520', 	'USA', 	'(307) 555-4680', 	'(307) 555-6525');
INSERT INTO "Customers" VALUES('SUPRD', 'Supr�mes d�lices', 	'Pascale Cartrain', 	'Accounting Manager', 	'Boulevard Tirou', 	'Charleroi', 	'B-6000', 	'Belgium', 	' 23 67 22 20',	'23 67 22 21');
INSERT INTO "Customers" VALUES('THEBI', 'The Big Cheese', 'Liz Nixon', 	'Marketing Manager', 	'89 Jefferson Way Suite 2', 	'OR', 	'97201', 	'USA', 	'(503) 555-3612', 	NULL);	
INSERT INTO "Customers" VALUES('THECR', 'The Cracker Box',	'Liu Wong', 	'Marketing Assistant', 	'55 Grizzly Peak Rd.', 	'MT', 	'59801', 	'USA', 	'(406) 555-5834', 	'(406) 555-8083');	
INSERT INTO "Customers" VALUES('TOMSP', 'Toms Spezialit�ten',	'Karin Josephs', 	'Marketing Manager', 	'Luisenstr. 48', 	NULL, 	'44087', 	'Germany', 	'0251-031259', 	'0251-035695');
INSERT INTO "Customers" VALUES('TORTU', 'Tortuga Restaurante',	'Miguel Angel Paolino', 'Owner', 	'Avda. Azteca 123', 	NULL, 	'05033', 	'Mexico', 	'(5) 555-2933', 	NULL);	
INSERT INTO "Customers" VALUES('TRADH', 'Tradi��o Hipermercados', 'Anabela Domingues', 	'Sales RepreOriginative', 	'Av. In�s de Castro', 	'SP', 	'05634-030', 	'Brazil', 	'(11) 555-2167','(11) 555-2168');
INSERT INTO "Customers" VALUES('TRAIH', 'Trail''s Head Gourmet Provisioners', 	'Helvetius Nagy', 	'Sales Associate', 	'722 DaVinci Blvd.', 	'WA', 	'98034', 	'USA', 	'(206) 555-8257', 	'(206) 555-2174');	
INSERT INTO "Customers" VALUES('VAFFE', 'Vaffeljernet', 	'Palle Ibsen', 	'Sales Manager', 	'Smagsloget 45', 	NULL, 	'8200', 	'Denmark', 	'86 21 32 43', 	'86 22 33 44');	
INSERT INTO "Customers" VALUES('VICTE', 'Victuailles en stock', 	'Mary Saveley', 	'Sales Agent', 	'2', 	'Lyon', '69004', 	'France', '78.32.54.86','78.32.54.87');
INSERT INTO "Customers" VALUES('WANDK', 'Die Wandernde Kuh', 	'Rita M�ller', 	'Sales Representative', 	'Adenauerallee 900', 	 null,	'70563', 	'Germany', 	'0711-020361', 	'0711-035428');	
INSERT INTO "Customers" VALUES('WARTH', 'Wartian Herkku', 	'Pirkko Koskitalo', 	'Accounting Manager', 	'Torikatu 38', 	 null,	'90110', 	'Finland', 	'981-443655', 	'981-443655');
INSERT INTO "Customers" VALUES('WELLI', 'Wellington Importadora', 	'Paula Parente', 	'Sales Manager', 'Rua do Mercado',	'Resende', 	'SP', 	'08737-363', 'Brazil', '555-8122');
INSERT INTO "Customers" VALUES('WHITC', 'White Clover Markets', 	'Karl Jablonski', 	'Owner', 	'305 - 14th Ave. S. Suite 3B', 	'WA', 	'98128', 	'USA', 	'(206) 555-4112', 	'(206) 555-4115');
INSERT INTO "Customers" VALUES('WILMK', 'Wilman Kala', 	'Matti Karttunen', 	'Owner/Marketing Assistant', 	'Keskuskatu 45', 	null, 	'21240', 	'Finland', 	'90-224 8858', 	'90-224 8858');
INSERT INTO "Customers" VALUES('WOLZA', 'Wolski  Zajazd', 	'Zbyszek Piestrzeniewicz', 	'Owner', 	'ul. Filtrowa 68', 	null,	'01-012', 	'Poland', 	'(26) 642-7012', 	'(26) 642-7012');	


INSERT INTO "Employees"("EmployeeID","LastName","FirstName","Title","DateOfBirth","HiringDate","Address","State","ZipCode","Country","Telephone","Extension","Notes") VALUES(1,'Davolio','Nancy','Sales RepreOriginative','12/08/1948','05/01/1992','507 - 20th Ave. E.Apt. 2A','WA','98122','USA','(206) 555-9857','5467','Education includes a BA in psychology from Colorado State University in 1970.  She also completed "The Art of the Cold Call."  Nancy is a member of Toastmasters International.');
INSERT INTO "Employees"("EmployeeID","LastName","FirstName","Title","DateOfBirth","HiringDate","Address","State","ZipCode","Country","Telephone","Extension","Notes") VALUES(2,'Fuller','Andrew','Vice President, Sales','02/19/1952','08/14/1992','908 W. Capital Way','WA','98401','USA','(206) 555-9482','3457','Andrew received his BTS commercial in 1974 and a Ph.D. in international marketing from the University of Dallas in 1981.  He is fluent in French and Italian and reads German.  He joined the company as a sales representative, was promoted to sales manager in January 1992 and to vice president of sales in March 1993.  Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.');
INSERT INTO "Employees"("EmployeeID","LastName","FirstName","Title","DateOfBirth","HiringDate","Address","State","ZipCode","Country","Telephone","Extension","Notes") VALUES(3,'Leverling','Janet','Sales Representative','08/30/1963','04/01/1992','722 Moss Bay Blvd.','WA','98033','USA','(206) 555-3412','3355','Janet has a BS degree in chemistry from Boston College (1984).  She has also completed a certificate program in food retailing management.  Janet was hired as a sales associate in 1991 and promoted to sales representative in February 1992.');
INSERT INTO "Employees"("EmployeeID","LastName","FirstName","Title","DateOfBirth","HiringDate","Address","State","ZipCode","Country","Telephone","Extension","Notes") VALUES(4,'Peacock','Margaret','Sales Representative','09/19/1937','05/03/1993','4110 Old Redmond Rd.','WA','98052','USA','(206) 555-8122','5176','Margaret holds a BA in English literature from Concordia College (1958) and an MA from the American Institute of Culinary Arts (1966).  She was assigned to the London office temporarily from July through November 1992.');
INSERT INTO "Employees"("EmployeeID","LastName","FirstName","Title","DateOfBirth","HiringDate","Address","State","ZipCode","Country","Telephone","Extension","Notes") VALUES(5,'Buchanan','Steven','Sales Manager','03/04/1955','10/17/1993','14 Garrett Hill',NULL,'SW1 8JR','UK','(71) 555-4848','3453','Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree in 1976.  Upon joining the company as a sales representative in 1992, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London.  He was promoted to sales manager in March 1993.  Mr. Buchanan has completed the courses "Successful Telemarketing" and "International Sales Management."  He is fluent in French.');
INSERT INTO "Employees"("EmployeeID","LastName","FirstName","Title","DateOfBirth","HiringDate","Address","State","ZipCode","Country","Telephone","Extension","Notes") VALUES(6,'Suyama','Michael','Sales Representative','07/02/1963','10/17/1993','Coventry HouseMiner Rd.',NULL,'EC2 7JR','UK','(71) 555-7773','428','Michael is a graduate of Sussex University (MA, ecoLastNameics, 1983) and the University of California at Los Angeles (MBA, marketing, 1986).  He has also taken the courses "Multi-Cultural Selling" and "Time Management for the Sales Professional."  He is fluent in Japanese and can read and write French, Portuguese, and Spanish.');
INSERT INTO "Employees"("EmployeeID","LastName","FirstName","Title","DateOfBirth","HiringDate","Address","State","ZipCode","Country","Telephone","Extension","Notes") VALUES(7,'King','Robert','Sales Representative','05/29/1960','01/02/1994','Edgeham HollowWinchester Way',NULL,'RG1 9SP','UK','(71) 555-5598','465','Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan in 1992, the year he joined the company.  After completing a course enTitled "Selling in Europe," he was transferred to the London office in March 1993.');
INSERT INTO "Employees"("EmployeeID","LastName","FirstName","Title","DateOfBirth","HiringDate","Address","State","ZipCode","Country","Telephone","Extension","Notes") VALUES(8,'Callahan','Laura','Inside Sales Coordinator','01/09/1958','03/05/1994','4726 - 11th Ave. N.E.','WA','98105','USA','(206) 555-1189','2344','Laura received a BA in psychology from the University of Washington.  She has also completed a course in business French.  She reads and writes French.');
INSERT INTO "Employees"("EmployeeID","LastName","FirstName","Title","DateOfBirth","HiringDate","Address","State","ZipCode","Country","Telephone","Extension","Notes") VALUES(9,'Dodsworth','Anne','Sales Representative','01/27/1966','11/15/1994','7 Houndstooth Rd.',NULL,'WG2 7LT','UK','(71) 555-4444','452','Anne has a BA degree in English from St. Lawrence College.  She is fluent in French and German.');


INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10724,'MEREP',8,'10/30/1997','12/11/1997','11/5/1997', 
	'43 rue St. Laurent','Qu�bec',
	 'H1J 1C3','Canada');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10332,'MEREP',3,'10/17/1996','11/28/1996','10/21/1996', 
	 '43 rue St. Laurent',
	'Qu�bec','H1J 1C3','Canada');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10249,'TOMSP',6,'7/5/1996','8/16/1996','7/10/1996', 
	 'Luisenstr. 48','M�nster', '44087','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10251,'VICTE',3,'7/8/1996','8/5/1996','7/15/1996', 
	 '2, rue du Commerce','Lyon',
	 '69004','France');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10252,'SUPRD',4,'7/9/1996','8/6/1996','7/11/1996', 
	 'Boulevard Tirou, 255','Charleroi',
	 'B-6000','Belgium');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10254,'CHOPS',5,'7/11/1996','8/8/1996','7/23/1996',
	 'Hauptstr. 31','Bern',
	 '3012','Switzerland');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10255,'RICSU',9,'7/12/1996','8/9/1996','7/15/1996', 
	 'Starenweg 5','Gen�ve',
	 '1204','Switzerland');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10256,'WELLI',3,'7/15/1996','8/12/1996','7/17/1996',
	'Rua do Mercado, 12','Resende',
	'08737-363','Brazil');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10258,'ERNSH',1,'7/17/1996','8/14/1996','7/23/1996', 
	 'Kirchgasse 6','Graz',
	 '8010','Austria');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10259,'CENTC',4,'7/18/1996','8/15/1996','7/25/1996', 
	 'Sierras de Granada 9993','M�xico D.F.',
	 '05022','Mexico');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10260,'OTTIK',4,'7/19/1996','8/16/1996','7/29/1996', 
	 'Mehrheimerstr. 369','K�ln',
	 '50739','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10262,'RATTC',8,'7/22/1996','8/19/1996','7/25/1996',
	'2817 Milton Dr.','Albuquerque',
	'87110','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10263,'ERNSH',9,'7/23/1996','8/20/1996','7/31/1996', 
	 'Kirchgasse 6','Graz',
	 '8010','Austria');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10264,'FOLKO',6,'7/24/1996','8/21/1996','8/23/1996', 
	 '�kergatan 24','Br�cke',
	 'S-844 67','Sweden');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10266,'WARTH',3,'7/26/1996','9/6/1996','7/31/1996', 
	 'Torikatu 38','Oulu',
	 '90110','Finland');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10269,'WHITC',5,'7/31/1996','8/14/1996','8/9/1996', 
	 '1029 - 12th Ave. S.','Seattle',
	 '98124','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10270,'WARTH',1,'8/1/1996','8/29/1996','8/2/1996',
	 'Torikatu 38','Oulu',
	 '90110','Finland');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10271,'SPLIR',6,'8/1/1996','8/29/1996','8/30/1996',
	 'P.O. Box 555','Lander',
	 '82520','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10272,'RATTC',6,'8/2/1996','8/30/1996','8/6/1996',
	 '2817 Milton Dr.','Albuquerque',
	 '87110','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10273,'QUICK',3,'8/5/1996','9/2/1996','8/12/1996',
	 'Taucherstra�e 10','Cunewalde',
	 '01307','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10274,'VINET',6,'8/6/1996','9/3/1996','8/16/1996',
	 '59 rue de l''Abbaye','Reims',
	 '51100','France');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10275,'MAGAA',1,'8/7/1996','9/4/1996','8/9/1996',
	 'Via Ludovico il Moro 22','Bergamo',
	 '24100','Italy');


INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10276,'TORTU',8,'8/8/1996','8/22/1996','8/14/1996',
	 'Avda. Azteca 123','M�xico D.F.',
	 '05033','Mexico');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10277,'MORGK',2,'8/9/1996','9/6/1996','8/13/1996',
	 'Heerstr. 22','Leipzig',
	 '04179','Germany');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10278,'BERGS',8,'8/12/1996','9/9/1996','8/16/1996',
	 'Berguvsv�gen  8','Lule�',
	 'S-958 22','Sweden');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10279,'LEHMS',8,'8/13/1996','9/10/1996','8/16/1996',
	 'Magazinweg 7','Frankfurt a.M.',
	 '60528','Germany');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10280,'BERGS',2,'8/14/1996','9/11/1996','9/12/1996',
	 'Berguvsv�gen  8','Lule�',
	 'S-958 22','Sweden');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10283,'LILAS',3,'8/16/1996','9/13/1996','8/23/1996',
	 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto',
	 '3508','Venezuela');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10286,'QUICK',8,'8/21/1996','9/18/1996','8/30/1996',
	 'Taucherstra�e 10','Cunewalde',
	 '01307','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10288,'REGGC',4,'8/23/1996','9/20/1996','9/3/1996',
	 'Strada Provinciale 124','Reggio Emilia',
	 '42100','Italy');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10289,'BSBEV',7,'8/26/1996','9/23/1996','8/28/1996',
	 'Fauntleroy Circus','London',
	 'EC2 5NT','UK');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10290,'COMMI',8,'8/27/1996','9/24/1996','9/3/1996',
	 'Av. dos Lus�adas, 23','Sao Paulo',
	 '05432-043','Brazil');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10292,'TRADH',1,'8/28/1996','9/25/1996','9/2/1996',
	 'Av. In�s de Castro, 414','Sao Paulo',
	 '05634-030','Brazil');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10304,'TORTU',1,'9/12/1996','10/10/1996','9/17/1996',
	 'Avda. Azteca 123','M�xico D.F.',
	 '05033','Mexico');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10310,'THEBI',8,'9/20/1996','10/18/1996','9/27/1996',
	 '89 Jefferson Way Suite 2','Portland',
	 '97201','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10312,'WANDK',2,'9/23/1996','10/21/1996','10/3/1996',
	 'Adenauerallee 900','Stuttgart',
	 '70563','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10313,'QUICK',2,'9/24/1996','10/22/1996','10/4/1996',
	 'Taucherstra�e 10','Cunewalde',
	 '01307','Germany');  
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10314,'RATTC',1,'9/25/1996','10/23/1996','10/4/1996',
	 '2817 Milton Dr.','Albuquerque',
	'87110','USA');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10315,'ISLAT',4,'9/26/1996','10/24/1996','10/3/1996',
	 'Garden House Crowther Way','Cowes',
	 'PO31 7PJ','UK');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10316,'RATTC',1,'9/27/1996','10/25/1996','10/8/1996',
	 '2817 Milton Dr.','Albuquerque',
	 '87110','USA');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10317,'LONEP',6,'9/30/1996','10/28/1996','10/10/1996',
	 '89 Chiaroscuro Rd.','Portland',
	 '97219','USA');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10318,'ISLAT',8,'10/1/1996','10/29/1996','10/4/1996',
	 'Garden House Crowther Way','Cowes',
	 'PO31 7PJ','UK');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10319,'TORTU',7,'10/2/1996','10/30/1996','10/11/1996',
	 'Avda. Azteca 123','M�xico D.F.',
	 '05033','Mexico');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10320,'WARTH',5,'10/3/1996','10/17/1996','10/18/1996',
	 'Torikatu 38','Oulu',
	 '90110','Finland');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10321,'ISLAT',3,'10/3/1996','10/31/1996','10/11/1996',
	 'Garden House Crowther Way','Cowes',
	 'PO31 7PJ','UK');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10322,'PERIC',7,'10/4/1996','11/1/1996','10/23/1996',
	 'Calle Dr. Jorge Cash 321','M�xico D.F.',
	 '05033','Mexico');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10323,'KOENE',4,'10/7/1996','11/4/1996','10/14/1996',
	 'Maubelstr. 90','Brandenburg',
	 '14776','Germany');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10324,'SAVEA',9,'10/8/1996','11/5/1996','10/10/1996',
	'187 Suffolk Ln.','Boise',
	'83720','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10325,'KOENE',1,'10/9/1996','10/23/1996','10/14/1996', 
	 'Maubelstr. 90','Brandenburg',
	 '14776','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10326,'BOLID',4,'10/10/1996','11/7/1996','10/14/1996', 
	 'C/ Araquil, 67','Madrid',
	 '28023','Spain');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10327,'FOLKO',2,'10/11/1996','11/8/1996','10/14/1996', 
     '�kergatan 24','Br�cke',
	 'S-844 67','Sweden');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10328,'FURIB',4,'10/14/1996','11/11/1996','10/17/1996', 
	 'Jardim das rosas n. 32','Lisboa',
	 '1675','Portugal');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10329,'SPLIR',4,'10/15/1996','11/26/1996','10/23/1996', 
	 'P.O. Box 555','Lander',
	 '82520','USA');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10330,'LILAS',3,'10/16/1996','11/13/1996','10/28/1996', 
	 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto',
	 '3508','Venezuela');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10333,'WARTH',5,'10/18/1996','11/15/1996','10/25/1996', 
	 'Torikatu 38','Oulu',
	 '90110','Finland');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10334,'VICTE',8,'10/21/1996','11/18/1996','10/28/1996', 
	 '2, rue du Commerce','Lyon',
	 '69004','France');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10335,'HUNGO',7,'10/22/1996','11/19/1996','10/24/1996', 
	 '8 Johnstown Road','Cork',
	 NULL,'Ireland');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10336,'PRINI',7,'10/23/1996','11/20/1996','10/25/1996', 
	 'Estrada da sa�de n. 58','Lisboa',
	 '1756','Portugal');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10338,'OLDWO',4,'10/25/1996','11/22/1996','10/29/1996', 
	 '2743 Bering St.','Anchorage',
	 '99508','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10339,'MEREP',2,'10/28/1996','11/25/1996','11/4/1996', 
	 '43 rue St. Laurent', 
	'Qu�bec','H1J 1C3','Canada');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10341,'SIMOB',7,'10/29/1996','11/26/1996','11/5/1996', 
	 'Vinb�ltet 34','Kobenhavn',
	 '1734','Denmark');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10343,'LEHMS',4,'10/31/1996','11/28/1996','11/6/1996', 
	 'Magazinweg 7','Frankfurt a.M.',
	 '60528','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10344,'WHITC',4,'11/1/1996','11/29/1996','11/5/1996', 
	 '1029 - 12th Ave. S.','Seattle',
	 '98124','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10345,'QUICK',2,'11/4/1996','12/2/1996','11/11/1996', 
	 'Taucherstra�e 10','Cunewalde',
	 '01307','Germany');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10346,'RATTC',3,'11/5/1996','12/17/1996','11/8/1996', 
	 '2817 Milton Dr.','Albuquerque',
	 '87110','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10726,'EASTC',4,'11/3/1997','11/17/1997','12/5/1997', 
	 '35 King George','London',
	 'WX3 6FW','UK');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10727,'REGGC',2,'11/3/1997','12/1/1997','12/5/1997', 
	 'Strada Provinciale 124','Reggio Emilia',
	 '42100','Italy');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10729,'LINOD',8,'11/4/1997','12/16/1997','11/14/1997', 
	 'Ave. 5 de Mayo Porlamar','I. de Margarita',
	  '4980','Venezuela');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10840,'LINOD',4,'1/19/1998','3/2/1998','2/16/1998', 
	 'Ave. 5 de Mayo Porlamar','I. de Margarita',
	 '4980','Venezuela');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10841,'SUPRD',5,'1/20/1998','2/17/1998','1/29/1998', 
	 'Boulevard Tirou, 255','Charleroi',
	 'B-6000','Belgium');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10842,'TORTU',1,'1/20/1998','2/17/1998','1/29/1998', 
	 'Avda. Azteca 123','M�xico D.F.',
	 '05033','Mexico');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10843,'VICTE',4,'1/21/1998','2/18/1998','1/26/1998', 
	 '2, rue du Commerce','Lyon',
	 '69004','France');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10844,'PICCO',8,'1/21/1998','2/18/1998','1/26/1998', 
	 'Geislweg 14','Salzburg',
	 '5020','Austria');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10845,'QUICK',8,'1/21/1998','2/4/1998','1/30/1998', 
	 'Taucherstra�e 10','Cunewalde',
	 '01307','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10846,'SUPRD',2,'1/22/1998','3/5/1998','1/23/1998', 
	 'Boulevard Tirou, 255','Charleroi',
	 'B-6000','Belgium');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10847,'SAVEA',4,'1/22/1998','2/5/1998','2/10/1998', 
	 '187 Suffolk Ln.','Boise',
	 '83720','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10848,'CONSH',7,'1/23/1998','2/20/1998','1/29/1998', 
	 'Berkeley Gardens 12  Brewery','London',
	 'WX1 6LT','UK');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10849,'KOENE',9,'1/23/1998','2/20/1998','1/30/1998', 
	 'Maubelstr. 90','Brandenburg',
	 '14776','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10880,'FOLKO',7,'2/10/1998','3/24/1998','2/18/1998', 
	 '�kergatan 24','Br�cke',
	 'S-844 67','Sweden');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10881,'CACTU',4,'2/11/1998','3/11/1998','2/18/1998', 
	 'Cerrito 333','Buenos Aires',
	 '1010','Argentina');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10882,'SAVEA',4,'2/11/1998','3/11/1998','2/20/1998', 
	 '187 Suffolk Ln.','Boise',
	 '83720','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10883,'LONEP',8,'2/12/1998','3/12/1998','2/20/1998', 
	 '89 Chiaroscuro Rd.','Portland',
	 '97219','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10884,'LETSS',4,'2/12/1998','3/12/1998','2/13/1998',
	'87 Polk St. Suite 5','San Francisco',
	'94117','USA');



INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10891,'LEHMS',7,'2/17/1998','3/17/1998','2/19/1998',
	'Magazinweg 7','Frankfurt a.M.',
	 '60528','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10892,'MAISD',4,'2/17/1998','3/17/1998','2/19/1998',
	'Rue Joseph-Bens 532','Bruxelles',
	 'B-1180','Belgium');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10893,'KOENE',9,'2/18/1998','3/18/1998','2/20/1998',
	'Maubelstr. 90','Brandenburg',
	 '14776','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10894,'SAVEA',1,'2/18/1998','3/18/1998','2/20/1998',
	'187 Suffolk Ln.','Boise',
	'83720','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10895,'ERNSH',3,'2/18/1998','3/18/1998','2/23/1998',
	'Kirchgasse 6','Graz',
	 '8010','Austria');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10896,'MAISD',7,'2/19/1998','3/19/1998','2/27/1998',
	'Rue Joseph-Bens 532','Bruxelles',
	 'B-1180','Belgium');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10899,'LILAS',5,'2/20/1998','3/20/1998','2/26/1998',
	'Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto',
	'3508','Venezuela');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10900,'WELLI',1,'2/20/1998','3/20/1998','3/4/1998',
	'Rua do Mercado, 12','Resende',
	'08737-363','Brazil');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10946,'VAFFE',1,'3/12/1998','4/9/1998','3/19/1998',
	'Smagsloget 45','�rhus',
	 '8200','Denmark');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10947,'BSBEV',3,'3/13/1998','4/10/1998','3/16/1998',
	'Fauntleroy Circus','London',
	 'EC2 5NT','UK');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10950,'MAGAA',1,'3/16/1998','4/13/1998','3/23/1998', 
	'Via Ludovico il Moro 22','Bergamo',
	 '24100','Italy');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10951,'RICSU',9,'3/16/1998','4/27/1998','4/7/1998',
	'Starenweg 5','Gen�ve',
	 '1204','Switzerland');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10952,'ALFKI',1,'3/16/1998','4/27/1998','3/24/1998',
	'Obere Str. 57','Berlin',
	 '12209','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10955,'FOLKO',8,'3/17/1998','4/14/1998','3/20/1998',
	'�kergatan 24','Br�cke',
	 'S-844 67','Sweden');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (10956,'BLAUS',6,'3/17/1998','4/28/1998','3/20/1998',
	'Forsterstr. 57','Mannheim',
	 '68306','Germany');


INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (11063,'HUNGO',3,'4/30/1998','5/28/1998','5/6/1998',
	'8 Johnstown Road','Cork',
	NULL,'Ireland');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (11064,'SAVEA',1,'5/1/1998','5/29/1998','5/4/1998',
	'187 Suffolk Ln.','Boise',
	'83720','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (11066,'WHITC',7,'5/1/1998','5/29/1998','5/4/1998',
	'1029 - 12th Ave. S.','Seattle',
	 '98124','USA');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (11067,'DRACD',1,'5/4/1998','5/18/1998','5/6/1998',
	'Walserweg 21','Aachen',
	 '52066','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (11070,'LEHMS',2,'5/5/1998','6/2/1998',NULL, 
	 'Magazinweg 7','Frankfurt a.M.',
	 '60528','Germany');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (11071,'LILAS',1,'5/5/1998','6/2/1998',NULL, 
	 'Carrera 52 con Ave. Bol�var #65-98 Llano Largo','Barquisimeto',
	 '3508','Venezuela');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (11072,'ERNSH',4,'5/5/1998','6/2/1998',  null,
	 'Kirchgasse 6','Graz',  
	 '8010','Austria');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (11073,'PERIC',2,'5/5/1998','6/2/1998',NULL, 
	 'Calle Dr. Jorge Cash 321','M�xico D.F.',
	 '05033','Mexico');
INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (11074,'SIMOB',7,'5/6/1998','6/3/1998',NULL, 
	 'Vinb�ltet 34','Kobenhavn',
	 '1734','Denmark');

INSERT INTO "Orders"
("OrderID","CustomerID","EmployeeID","OrderDate","RequiredDate",
	"DateOrigin", "AddressOrigin","CityOrigin","ZipCodeOrigin","CountryOrigin")
VALUES (11075,'RICSU',8,'5/6/1998','6/3/1998',NULL, 
	 'Starenweg 5','Gen�ve',
	 '1204','Switzerland');

INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(1	,'Chai' , 	1 , 	'10 boxes x 20 bags',	18,	39,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(2	,'Chang' , 	1 , 	'24 - 12 oz bottles',	19,	17,	40,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(3	,'Aniseed Syrup' , 	2 , 	'12 - 550 ml bottles',	10,	13,	70,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(4	,'Chef Anton''s Cajun Seasoning' , 	2 , 	'48 - 6 oz jars',	22,	53,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(5	,'Chef Anton''s Gumbo Mix' , 	2 , 	'36 boxes',	21.35,	0,	0,	1);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(6	,'Grandma''s Boysenberry Spread' , 	2 , 	'12 - 8 oz jars',	25,	120,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(7	,'Uncle Bob''s Organic Dried Pears' , 	7 , 	'12 - 1 lb pkgs.',	30,	15,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(8	,'Northwoods Cranberry Sauce' , 	2 , 	'12 - 12 oz jars',	40,	6,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(9	,'Mishi Kobe Niku' , 	6 , 	'18 - 500 g pkgs.',	97,	29,	0,	1);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(10	,'Ikura' , 	8 , 	'12 - 200 ml jars',	31,	31,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(11	,'Queso Cabrales' , 	4 , 	'1 kg pkg.',	21,	22,	30,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(12	,'Queso Manchego La Pastora' , 	4 , 	'10 - 500 g pkgs.',	38,	86,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(13	,'Konbu' , 	8 , 	'2 kg box',	6,	24,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(14	,'Tofu' , 	7 , 	'40 - 100 g pkgs.',	23.25,	35,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(15	,'Genen Shouyu' , 	2 , 	'24 - 250 ml bottles',	15.5,	39,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(16	,'Pavlova' , 	3 , 	'32 - 500 g boxes',	17.45,	29,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(17	,'Alice Mutton' , 	6 , 	'20 - 1 kg tins',	39,	0,	0,	1);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(18	,'Carnarvon Tigers' , 	8 , 	'16 kg pkg.',	62.5,	42,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(19	,'Teatime Chocolate Biscuits' , 	3 , 	'10 boxes x 12 pieces',	9.2,	25,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(20	,'Sir Rodney''s Marmalade' , 	3 , 	'30 gift boxes',	81,	40,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(21	,'Sir Rodney''s Scones' , 	3 , 	'24 pkgs. x 4 pieces',	10,	3,	40,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(22	,'Gustaf''s Kn�ckebr�d' , 	5 , 	'24 - 500 g pkgs.',	21,	104,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(23	,'Tunnbr�d' , 	5 , 	'12 - 250 g pkgs.',	9,	61,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(24	,'Guaran� Fant�stica' , 	1 , 	'12 - 355 ml cans',	4.5,	20,	0,	1);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(25	,'NuNuCa Nu�-Nougat-Creme' , 	3 , 	'20 - 450 g glasses',	14,	76,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(26	,'Gumb�r Gummib�rchen' , 	3 , 	'100 - 250 g bags',	31.23,	15,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(27	,'Schoggi Schokolade' , 	3 , 	'100 - 100 g pieces',	43.9,	49,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(28	,'R�ssle Sauerkraut' , 	7 , 	'25 - 825 g cans',	45.6,	26,	0,	1);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(29	,'Th�ringer Rostbratwurst' , 	6 , 	'50 bags x 30 sausgs.',	123.79,	0,	0,	1);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(30	,'Nord-Ost Matjeshering' , 	8 , 	'10 - 200 g glasses',	25.89,	10,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(31	,'Gorgonzola Telino' , 	4 , 	'12 - 100 g pkgs',	12.5,	0,	70,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(32	,'Mascarpone Fabioli' , 	4 , 	'24 - 200 g pkgs.',	32,	9,	40,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(33	,'Geitost' , 	4 , 	'500 g',	2.5,	112,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(35	,'Steeleye Stout' , 	1 , 	'24 - 12 oz bottles',	18,	20,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(37	,'Gravad lax' , 	8 , 	'12 - 500 g pkgs.',	26,	11,	50,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(39	,'Chartreuse verte' , 	1 , 	'750 cc per bottle',	18,	69,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(40	,'Boston Crab Meat' , 	8 , 	'24 - 4 oz tins',	18.4,	123,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(41	,'Jack''s New England Clam Chowder' , 	8 , 	'12 - 12 oz cans',	9.65,	85,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(42	,'Singaporean Hokkien Fried Mee' , 	5 , 	'32 - 1 kg pkgs.',	14,	26,	0,	1);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(43	,'Ipoh Coffee' , 	1 , 	'16 - 500 g tins',	46,	17,	10,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(44	,'Gula Malacca' , 	2 , 	'20 - 2 kg bags',	19.45,	27,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(45	,'Rogede sild' , 	8 , 	'1k pkg.',	9.5,	5,	70,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(46	,'Spegesild' , 	8 , 	'4 - 450 g glasses',	12,	95,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(47	,'Zaanse koeken' , 	3 , 	'10 - 4 oz boxes',	9.5,	36,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(48	,'Chocolade' , 	3 , 	'10 pkgs.',	12.75,	15,	70,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(49	,'Maxilaku' , 	3 , 	'24 - 50 g pkgs.',	20,	10,	60,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(50	,'Valkoinen suklaa' , 	3 , 	'12 - 100 g bars',	16.25,	65,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(51	,'Manjimup Dried Apples' , 	7 , 	'50 - 300 g pkgs.',	53,	20,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(52	,'Filo Mix' , 	5 , 	'16 - 2 kg boxes',	7,	38,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(53	,'Perth Pasties' , 	6 , 	'48 pieces',	32.8,	0,	0,	1);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(54	,'Tourti�re' , 	6 , 	'16 pies',	7.45,	21,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(55	,'P�t� chinois' , 	6 , 	'24 boxes x 2 pies',	24,	115,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(56	,'Gnocchi di nonna Alice' , 	5 , 	'24 - 250 g pkgs.',	38,	21,	10,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(57	,'Ravioli Angelo' , 	5 , 	'24 - 250 g pkgs.',	19.5,	36,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(58	,'Escargots de Bourgogne' , 	8 , 	'24 pieces',	13.25,	62,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(59	,'Raclette Courdavault' , 	4 , 	'5 kg pkg.',	55,	79,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(60	,'Camembert Pierrot' , 	4 , 	'15 - 300 g rounds',	34,	19,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued") 	VALUES(61	,'Sirop d''�rable' , 	2 , 	'24 - 500 ml bottles',	28.5,	113,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(62	,'Tarte au sucre' , 	3 , 	'48 pies',	49.3,	17,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(63	,'Vegie-spread' , 	2 , 	'15 - 625 g jars',	43.9,	24,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(64	,'Wimmers gute Semmelkn�del' , 	5 , 	'20 bags x 4 pieces',	33.25,	22,	80,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(65	,'Louisiana Fiery Hot Pepper Sauce' , 	2 , 	'32 - 8 oz bottles',	21.05,	76,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(66	,'Louisiana Hot Spiced Okra' , 	2 , 	'24 - 8 oz jars',	17,	4,	100,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(67	,'Laughing Lumberjack Lager' , 	1 , 	'24 - 12 oz bottles',	14,	52,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(68	,'Scottish Longbreads' , 	3 , 	'10 boxes x 8 pieces',	12.5,	6,	10,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(69	,'Gudbrandsdalsost' , 	4 , 	'10 kg pkg.',	36,	26,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(70	,'Outback Lager' , 	1 , 	'24 - 355 ml bottles',	15,	15,	10,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(71	,'Flotemysost' , 	4 , 	'10 - 500 g pkgs.',	21.5,	26,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")VALUES(72	,'Mozzarella di Giovanni' , 	4 , 	'24 - 200 g pkgs.',	34.8,	14,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(73	,'R�d Kaviar' , 	8 , 	'24 - 150 g jars',	15,	101,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(74	,'Longlife Tofu' , 	7 , 	'5 kg pkg.',	10,	4,	20,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(75	,'Rh�nbr�u Klosterbier' , 	1 , 	'24 - 0.5 l bottles',	7.75,	125,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")VALUES(76	,'Lakkalik��ri' , 	1 , 	'500 ml',	18,	57,	0,	0);
INSERT INTO "Products"("ProductID","ProductName","CategoryID","QuantityPerUnit","UnitPrice","UnitsInStock","UnitsPerOrder","Discontinued")	VALUES(77	,'Original Frankfurter gr�ne So�e' , 	2 , 	'12 boxes',	13,	32,	0,	0);


CREATE TABLE [Territories] 
	([TerritoryID] [nvarchar] (20) NOT NULL ,
	[TerritoryDescription] [nchar] (50) NOT NULL ,
        [StateID] [int] NOT NULL
);

CREATE TABLE [EmployeeTerritories] 
	([EmployeeID] [int] NOT NULL,
	[TerritoryID] [nvarchar] (20) NOT NULL 
);

Insert Into Territories Values ('01581','Westboro',1);
Insert Into Territories Values ('01730','Bedford',1);
Insert Into Territories Values ('01833','Georgetow',1);
Insert Into Territories Values ('02116','Boston',1);
Insert Into Territories Values ('02139','Cambridge',1);
Insert Into Territories Values ('02184','Braintree',1);
Insert Into Territories Values ('02903','Providence',1);
Insert Into Territories Values ('03049','Hollis',3);
Insert Into Territories Values ('03801','Portsmouth',3);
Insert Into Territories Values ('06897','Wilton',1);
Insert Into Territories Values ('07960','Morristown',1);
Insert Into Territories Values ('08837','Edison',1);
Insert Into Territories Values ('10019','New York',1);
Insert Into Territories Values ('10038','New York',1);
Insert Into Territories Values ('11747','Mellvile',1);
Insert Into Territories Values ('14450','Fairport',1);
Insert Into Territories Values ('19428','Philadelphia',3);
Insert Into Territories Values ('19713','Neward',1);
Insert Into Territories Values ('20852','Rockville',1);
Insert Into Territories Values ('27403','Greensboro',1);
Insert Into Territories Values ('27511','Cary',1);
Insert Into Territories Values ('29202','Columbia',4);
Insert Into Territories Values ('30346','Atlanta',4);
Insert Into Territories Values ('31406','Savannah',4);
Insert Into Territories Values ('32859','Orlando',4);
Insert Into Territories Values ('33607','Tampa',4);
Insert Into Territories Values ('40222','Louisville',1);
Insert Into Territories Values ('44122','Beachwood',3);
Insert Into Territories Values ('45839','Findlay',3);
Insert Into Territories Values ('48075','Southfield',3);
Insert Into Territories Values ('48084','Troy',3);
Insert Into Territories Values ('48304','Bloomfield Hills',3);
Insert Into Territories Values ('53404','Racine',3);
Insert Into Territories Values ('55113','Roseville',3);
Insert Into Territories Values ('55439','Minneapolis',3);
Insert Into Territories Values ('60179','Hoffman Estates',2);
Insert Into Territories Values ('60601','Chicago',2);
Insert Into Territories Values ('72716','Bentonville',4);
Insert Into Territories Values ('75234','Dallas',4);
Insert Into Territories Values ('78759','Austin',4);
Insert Into Territories Values ('80202','Denver',2);
Insert Into Territories Values ('80909','Colorado Springs',2);
Insert Into Territories Values ('85014','Phoenix',2);
Insert Into Territories Values ('85251','Scottsdale',2);
Insert Into Territories Values ('90405','Santa Monica',2);
Insert Into Territories Values ('94025','Menlo Park',2);
Insert Into Territories Values ('94105','San Francisco',2);
Insert Into Territories Values ('95008','Campbell',2);
Insert Into Territories Values ('95054','Santa Clara',2);
Insert Into Territories Values ('95060','Santa Cruz',2);
Insert Into Territories Values ('98004','Bellevue',2);
Insert Into Territories Values ('98052','Redmond',2);
Insert Into Territories Values ('98104','Seattle',2);

Insert Into EmployeeTerritories Values (1,'06897');
Insert Into EmployeeTerritories Values (1,'19713');
Insert Into EmployeeTerritories Values (2,'01581');
Insert Into EmployeeTerritories Values (2,'01730');
Insert Into EmployeeTerritories Values (2,'01833');
Insert Into EmployeeTerritories Values (2,'02116');
Insert Into EmployeeTerritories Values (2,'02139');
Insert Into EmployeeTerritories Values (2,'02184');
Insert Into EmployeeTerritories Values (2,'40222');
Insert Into EmployeeTerritories Values (3,'30346');
Insert Into EmployeeTerritories Values (3,'31406');
Insert Into EmployeeTerritories Values (3,'32859');
Insert Into EmployeeTerritories Values (3,'33607');
Insert Into EmployeeTerritories Values (4,'20852');
Insert Into EmployeeTerritories Values (4,'27403');
Insert Into EmployeeTerritories Values (4,'27511');
Insert Into EmployeeTerritories Values (5,'02903');
Insert Into EmployeeTerritories Values (5,'07960');
Insert Into EmployeeTerritories Values (5,'08837');
Insert Into EmployeeTerritories Values (5,'10019');
Insert Into EmployeeTerritories Values (5,'10038');
Insert Into EmployeeTerritories Values (5,'11747');
Insert Into EmployeeTerritories Values (5,'14450');
Insert Into EmployeeTerritories Values (6,'85014');
Insert Into EmployeeTerritories Values (6,'85251');
Insert Into EmployeeTerritories Values (6,'98004');
Insert Into EmployeeTerritories Values (6,'98052');
Insert Into EmployeeTerritories Values (6,'98104');
Insert Into EmployeeTerritories Values (7,'60179');
Insert Into EmployeeTerritories Values (7,'60601');
Insert Into EmployeeTerritories Values (7,'80202');
Insert Into EmployeeTerritories Values (7,'80909');
Insert Into EmployeeTerritories Values (7,'90405');
Insert Into EmployeeTerritories Values (7,'94025');
Insert Into EmployeeTerritories Values (7,'94105');
Insert Into EmployeeTerritories Values (7,'95008');
Insert Into EmployeeTerritories Values (7,'95054');
Insert Into EmployeeTerritories Values (7,'95060');
Insert Into EmployeeTerritories Values (8,'19428');
Insert Into EmployeeTerritories Values (8,'44122');
Insert Into EmployeeTerritories Values (8,'45839');
Insert Into EmployeeTerritories Values (8,'53404');
Insert Into EmployeeTerritories Values (9,'03049');
Insert Into EmployeeTerritories Values (9,'03801');
Insert Into EmployeeTerritories Values (9,'48075');
Insert Into EmployeeTerritories Values (9,'48084');
Insert Into EmployeeTerritories Values (9,'48304');
Insert Into EmployeeTerritories Values (9,'55113');
Insert Into EmployeeTerritories Values (9,'55439');
