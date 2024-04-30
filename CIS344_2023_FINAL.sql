create database Banks_Portal;
create table accounts (
	accountID int not null unique primary key auto_increment,
    ownerName varchar(45) not null,
    owner_ssn int not null,
    balance decimal(10,2) default 0.00,
    account_status varchar(45)
);

create table Transactions (
	transactionID int not null unique primary key auto_increment,
    accountID int not null,
    transactionType varchar(45) not null,
    transactionAmount decimal(10,2) not null
);
insert into accounts (ownerName, owner_ssn, balance, account_status)
values	("Maria Jozef", 123456789, 10000.00, "active"),
		("Linda Jones", 987654321, 2600.00, "inactive"),
        ("John McGrail", 222222222, 100.50, "active"),
        ("Patty Luna", 111111111, 509.75, "inactive");
select * from accounts;
insert into Transactions (accountID, transactionType, transactionAmount) 
values	(1, "deposit", 650.98),
		(3, "withdraw", 899.87),
        (3, "deposit", 350.00);
select * from Transactions;

DELIMITER //
CREATE PROCEDURE accountTransactions()
BEGIN
	SELECT * FROM accounts;
END //
DELIMITER ;
CALL accountTransactions();

DELIMITER //

CREATE PROCEDURE deposit(IN accountID_param INT, IN amount_param DECIMAL(10,2))
BEGIN
    DECLARE current_balance DECIMAL(10,2);
    SELECT balance INTO current_balance FROM accounts WHERE accountID = accountID_param;
    UPDATE accounts SET balance = balance + amount_param WHERE accountID = accountID_param;
    INSERT INTO Transactions (accountID, transactionType, transactionAmount)
    VALUES (accountID_param, 'deposit', amount_param);
    SELECT * FROM accounts WHERE accountID = accountID_param;
END //
DELIMITER ;
CALL deposit(1, 500.00);

DELIMITER //
CREATE PROCEDURE withdraw(IN accountID_param INT, IN amount_param DECIMAL(10,2))
BEGIN
    DECLARE current_balance DECIMAL(10,2);
    SELECT balance INTO current_balance FROM accounts WHERE accountID = accountID_param;
    IF current_balance >= amount_param THEN
        UPDATE accounts SET balance = balance - amount_param WHERE accountID = accountID_param;
        INSERT INTO Transactions (accountID, transactionType, transactionAmount)
        VALUES (accountID_param, 'withdraw', amount_param);
        SELECT * FROM accounts WHERE accountID = accountID_param;
    ELSE
        SELECT 'Insufficient balance' AS Message;
    END IF;
END //
DELIMITER ;






     

    
    
    
    
    