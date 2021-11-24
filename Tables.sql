use cloudcomputingDB;

create table paymentInformation(
    payID varchar(20) primary key,
    methodType varchar(20));

create table authorization(
    authID varchar(20) primary key,
    userName varchar(20), 
    password varchar(20));

create table storage(
    storageID varchar(20) primary key,
    size int,
    type varchar(20),
    price int);

create table computing(
    computeID varchar(20) primary key,
    coreCount int,
    ram int,
    gpu varchar(20),
    price int);

create table instance(
    instanceID varchar(20) primary key,
    zone varchar(20),
    instanceType varchar(20),
    allocated bool,
    computeID varchar(20),
    storageID varchar(20),
    foreign key (storageID) references storage (storageID) on delete cascade,
    foreign key (computeID) references computing (computeID)on delete cascade);

create table user(
    userID varchar(20) primary key, 
    name varchar(20),
    email varchar(40),
    payID varchar(20),
    authID varchar(20),
    contactNumber varchar(20),
    foreign key(payID) references paymentInformation (payID) on delete cascade,
    foreign key(authID) references authorization (authID) on delete cascade);

create table subscription(
    subscriptionID varchar(20) primary key,
    userID varchar(20),
    instanceID varchar(20),
    startDate datetime,
    endDate datetime,
    foreign key (userID) references user (userID) on delete cascade,
    foreign key (instanceID) references instance (instanceID) on delete cascade);

create table billing(
    billID varchar(20) primary key,
    amount int,
    billDate date,
    dueDate date,
    subscriptionID varchar(20),
    foreign key(subscriptionID) references subscription(subscriptionID)on delete cascade);
    
create table logs(
    logID varchar(20) primary key,
    description varchar(20),
    timestamp timestamp,
    errorCode int,
    instanceID varchar(20),
    foreign key (instanceID) references instance (instanceID) on delete cascade);