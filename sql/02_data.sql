INSERT INTO department VALUES (1,'ICE','Block A'),(2,'CSE','Block B'),(3,'EEE','Block C');
INSERT INTO instructor VALUES (1,'Dr. Rahman',1,90000),(2,'Dr. Akter',1,85000),(3,'Dr. Hasan',2,95000),(4,'Dr. Noor',3,80000),(5,'Dr. Islam',2,70000);
INSERT INTO student VALUES (1,'Anika',1,4),(2,'Bashir',1,3),(3,'Chaity',2,2),(4,'Dipu',2,4),(5,'Eva',3,1),(6,'Farhan',1,4),(7,'Gita',3,3),(8,'Hasib',2,1);
INSERT INTO course VALUES ('ICE-4107','Cryptography',3,1),('ICE-4101','Networking',3,1),('CSE-2201','Algorithms',3,2),('CSE-3101','Databases',3,2),('EEE-1101','Circuits',3,3),('ICE-2201','Data Structures',3,1);
INSERT INTO teaches VALUES (1,'ICE-4107'),(2,'ICE-4101'),(3,'CSE-2201'),(3,'CSE-3101'),(4,'EEE-1101'),(1,'ICE-2201');
INSERT INTO enrollment VALUES (1,'ICE-4107',3.75),(1,'ICE-4101',3.5),(2,'ICE-4107',3.0),(2,'ICE-2201',2.75),(3,'CSE-2201',3.25),(4,'CSE-3101',4.0),(4,'CSE-2201',3.5),(5,'EEE-1101',2.5),(6,'ICE-4107',3.9),(6,'ICE-4101',3.6),(7,'EEE-1101',3.0),(8,'CSE-2201',NULL);
