use cloudcomputingDB;


DROP VIEW IF EXISTS top5SellingComputing;

CREATE VIEW `top5SellingComputing` AS select computing.computeID,count(distinct subscription.subscriptionID),computing.price, sum(amount)
from billing join subscription on billing.subscriptionID = subscription.subscriptionID
join instance on subscription.instanceID = instance.instanceID
inner join computing on computing.computeID = instance.computeID
where computing.computeID != '0'
group by computing.computeID
order by sum(amount) desc limit 5;


DROP VIEW IF EXISTS top5SellingStorage;

CREATE VIEW `top5SellingStorage` AS select storage.storageID, count(distinct subscription.subscriptionID), storage.price, sum(amount)
from billing join subscription on billing.subscriptionID = subscription.subscriptionID
join instance on subscription.instanceID = instance.instanceID
inner join storage on storage.storageID = instance.storageID
where storage.storageID != '0'
group by storage.storageID
order by sum(amount) desc limit 5;

DROP VIEW IF EXISTS storagesubs;

CREATE VIEW storagesubs AS
select * from (Select w2.userID, w1.storageID, w2.counts from storage w1 join
(select userID, storageID, count(1) as counts from subscription natural join
            instance where instanceType = 'STO' group by storageID) w2) as joined
natural join storage;
       
DROP VIEW IF EXISTS computesubs;

CREATE VIEW computesubs AS
select * from (Select w2.userID, w1.computeID, w2.counts from computing w1 join
(select userID, computeID, count(1) as counts from subscription natural join
            instance where instanceType = 'COM' group by computeID) w2) as joined
natural join computing;