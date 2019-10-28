--In this section you will begin the process of working with the Oracle Chinook database
--1.0 Setting up Oracle Chinook
--Task � Open the Chinook_Oracle.sql file and execute the scripts within.
--
-- Okay, done 
--
--2.0 SQL Queries
--In this section you will be performing various queries against the Oracle Chinook database.
--2.1 SELECT
--Task � Select all records from the Employee table.
SELECT * FROM employee;
--Task � Select all records from the Employee table where last name is King.
SELECT * FROM employee WHERE lastname = 'King';
--Task � Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
SELECT * FROM employee WHERE firstname = 'Andrew' AND reportsto IS NULL;
--2.2 ORDER BY
--Task � Select all albums in Album table and sort result set in descending order by title.
SELECT * FROM album ORDER BY title DESC;
--Task � Select first name from Customer and sort result set in ascending order by city
SELECT firstname FROM customer ORDER BY firstname ASC;
--2.3 INSERT INTO
--Task � Insert two new records into Genre table
INSERT INTO genre (genreid, name) VALUES (101, 'Metalcore');
INSERT INTO genre (genreid, name) VALUES (102, 'Folk Metal');
--Task � Insert two new records into Employee table
INSERT INTO employee (employeeid, lastname, firstname, title, reportsto, birthdate, hiredate, address, city, state, country, postalcode, phone, fax, email)
VALUES (9, 'Spencer', 'Kris', 'IT Staff', 6, '06-JUN-91', '05-MAY-06', '1221 Fake ST', 'Edmonton', 'AB', 'Canada', 'T5K 2N1', '+1 (780) 555-3344', '+1 (234) 235-2362', 'spenc_k545@chinookcorp.com');
INSERT INTO employee (employeeid, lastname, firstname, title, reportsto, birthdate, hiredate, address, city, state, country, postalcode, phone, fax, email)
VALUES (10, 'Johnson', 'Patrick', 'Sales Support Agent', 2, '05-MAY-92', '05-MAY-06', '1221 Fake ST', 'Edmonton', 'AB', 'Canada', 'T5k 2N1',  '+1 (780) 555-3344', '+1 (234) 235-2362', 'John_p488@chinookcorpg.com');
--Task � Insert two new records into Customer table
INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode, phone, fax, email, supportrepid)
VALUES (60, 'Bob', 'Dunn', null, '234 Some ST', 'Redmon', 'WA', 'USA', '98052-8300', '+1 (425) 555-4878', null, 'Dude@blah.com', 3);
INSERT INTO customer (customerid, firstname, lastname, company, address, city, state, country, postalcode, phone, fax, email, supportrepid)
VALUES (61, 'Elain', 'Dunn', null, '234 Some ST', 'Redmon', 'WA', 'USA', '98052-8300', '+1 (425) 555-4878', null, 'Lady@blah.com', 3);
--2.4 UPDATE
--Task � Update Aaron Mitchell in Customer table to Robert Walter
UPDATE customer
SET firstname = 'Rober', lastname = 'Walter'
WHERE firstname = 'Aaron' AND lastname = 'Mitchell';
--Task � Update name of artist in the Artist table �Creedence Clearwater Revival� to �CCR�
UPDATE artist
SET name = 'CCR'
WHERE name = 'Creedence Clearwater Revival';
--2.5 LIKE
--Task � Select all invoices with a billing address like �T%�
SELECT * FROM invoice
WHERE billingaddress LIKE 'T%';
--2.6 BETWEEN
--Task � Select all invoices that have a total between 15 and 50
SELECT * FROM invoice
WHERE total BETWEEN 15 AND 50;
--Task � Select all employees hired between 1st of June 2003 and 1st of March 2004
SELECT * FROM employee
WHERE hiredate BETWEEN '01-JUN-03' AND '01-MAR-04';
--2.7 DELETE
--Task � Delete a recordin Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
--NOTE: the name was in there wrong...
UPDATE customer
SET firstname = 'Robert'
WHERE firstname = 'Rober';

DELETE FROM invoiceline
WHERE invoiceid IN (SELECT invoiceid FROM invoice
                    WHERE customerid = (SELECT customerid FROM customer
                                        WHERE firstname = 'Robert' AND lastname = 'Walter'));
DELETE FROM invoice
WHERE customerid = (SELECT customerid FROM customer
                    WHERE firstname = 'Robert' AND lastname = 'Walter');
DELETE FROM customer
WHERE firstname = 'Robert' AND lastname = 'Walter';

--3.0 SQL Functions
--In this section you will be using the Oracle system functions, as well as your own functions, to perform various actions against the database
--3.1 System Defined Functions
--Task � Create a function that returns the current time.
SELECT TO_CHAR(CURRENT_DATE, 'HH:MI:SS') FROM dual;
--Task � create a function that returns the length of a mediatype from the mediatype table
SELECT LENGTH(name) AS Lenth_of_media_type FROM mediatype;
--3.2 System Defined Aggregate Functions
--Task � Create a function that returns the average total of all invoices
SELECT '$' || ROUND(AVG(total), 2) AS Avg_Invoice_Total FROM invoice;
--Task � Create a function that returns the most expensive track
SELECT '$' || MAX(unitprice) AS Most_Expensive_Track FROM track;
--3.3 User Defined Scalar Functions
--Task � Create a function that returns the average price of invoiceline items in the invoiceline table
SELECT '$' || ROUND(AVG(unitprice), 2) AS Avg_Item_Price FROM invoiceline;
--3.4 User Defined Table Valued Functions
--Task � Create a function that returns all employees who are born after 1968.
--4.0 Stored Procedures
--In this section you will be creating and executing stored procedures. You will be creating various types of stored procedures that take input and output parameters.
--4.1 Basic Stored Procedure
--Task � Create a stored procedure that selects the first and last names of all the employees.
--4.2 Stored Procedure Input Parameters
--Task � Create a stored procedure that updates the personal information of an employee.
--Task � Create a stored procedure that returns the managers of an employee.
--4.3 Stored Procedure Output Parameters
--Task � Create a stored procedure that returns the name and company of a customer.
--6.0 Triggers
--In this section you will create various kinds of triggers that work when certain DML statements are executed on a table.
--6.1 AFTER/FOR
--Task - Create an after insert trigger on the employee table fired after a new record is inserted into the table.
--Task � Create an after update trigger on the album table that fires after a row is inserted in the table
--Task � Create an after delete trigger on the customer table that fires after a row is deleted from the table.
--Task � Create a trigger that restricts the deletion of any invoice that is priced over 50 dollars.
--7.0 JOINS
--In this section you will be working with combing various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.
--7.1 INNER
--Task � Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
SELECT lastname, firstname, invoiceid FROM customer
INNER JOIN invoice
ON invoice.customerid = customer.customerid
ORDER BY lastname ASC;
--7.2 OUTER
--Task � Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total.
SELECT customer.customerid, lastname, firstname, invoiceid, total from customer
FULL JOIN invoice
ON invoice.customerid = customer.customerid
ORDER BY lastname ASC;
--7.3 RIGHT
--Task � Create a right join that joins album and artist specifying artist name and title.
SELECT album.title, artist.name FROM album
RIGHT JOIN artist
ON album.artistid = artist.artistid
ORDER BY album.title ASC;
--7.4 CROSS
--Task � Create a cross join that joins album and artist and sorts by artist name in ascending order.
SELECT artist.name, album.title FROM artist
CROSS JOIN album
ORDER BY artist.name ASC;
--7.5 SELF
--Task � Perform a self-join on the employee table, joining on the reportsto column.
SELECT t1.lastname || ', ' || t1.firstname AS Employee, t2.lastname || ', ' || t2.firstname AS Manager FROM employee t1
INNER JOIN employee t2
ON t2.employeeid = t1.reportsto
ORDER BY t1.lastname ASC;