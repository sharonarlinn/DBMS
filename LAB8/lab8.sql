-- Lab Experiment 08:
-- Creating,deleting and managing users
-- grant and revoke privileges to users
-- ----------------------------------------------------------------------------------
-- STUDENT NAME: Sharon Arlin
-- USN:1RUA24BCA0081 
-- SECTION:A
-- ----------------------------------------------------------------------------------
SELECT USER(),
       @@hostname AS Host_Name,
       VERSION() AS MySQL_Version,
       NOW() AS Current_Date_Time;

-- Paste the Output below by execution of above command and comment the output by /* Output */.


-- ----------------------------------------------------------------------------------
-- Task 1 : Creating a user

-- creating 5 different users with 5 different passwords
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'Pass@123';
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'Pass@456';
CREATE USER 'user3'@'localhost' IDENTIFIED BY 'Pass@789';
CREATE USER 'user4'@'localhost' IDENTIFIED BY 'Pass@321';
CREATE USER 'user5'@'localhost' IDENTIFIED BY 'Pass@654';

-- Task 2 : Alter / Changing the password
ALTER USER 'user1'@'localhost' IDENTIFIED BY 'NewPass@123';

-- Task 3 : Privileges
GRANT ALL PRIVILEGES ON *.* TO 'user1'@'localhost';
GRANT SELECT, INSERT, UPDATE ON db_lab.* TO 'user2'@'localhost';
SHOW GRANTS FOR 'user1'@'localhost';
SHOW GRANTS FOR 'user2'@'localhost';


-- Task 4 : Switch the user from root to another (NOT DONE)



-- Task 5 : Revoking all permissions (grant must exist for that user for revoke to work)
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'user1'@'localhost';
REVOKE SELECT, INSERT, UPDATE ON db_lab.* FROM 'user2'@'localhost';

SHOW GRANTS FOR 'user1'@'localhost';
SHOW GRANTS FOR 'user2'@'localhost';


-- Task 6 : Drop user
DROP USER 'user1'@'localhost';
DROP USER 'user2'@'localhost';
DROP USER 'user3'@'localhost';
DROP USER 'user4'@'localhost';
DROP USER 'user5'@'localhost';