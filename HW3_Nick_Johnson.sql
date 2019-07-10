-- Homework #3  Ch. 5 1-9
-- 5-1) Insert record
insert into terms(terms_id, terms_description, terms_due_days)
values(6, 'Net due 120 days', 120);

-- 5-2) Update Records
update terms
set terms_description = 'Net due days 125 days', terms_due_days = 125
where terms_id = 6; 

-- 5-3) Remove a Record "Delete"....remove the 6
delete from terms 
where terms_id = 6; 

-- 5-4) Insert, without a list of columns.  Will perform in order of columns present in table.
insert into invoices 
values (default, 32, 'AX-014-027', '2014-08-01', 434.58, 0, 0, 2, '2014-8-31', null);


-- 5-5) Select last value of invoice_id columns......"115"
select max(invoice_id) 
from invoices;

-- insert
insert into invoice_line_items
values (115, 1, 160, 180.23, 'Hard drive'), 
		(115, 2, 527, 254.35, 'Exchange Server update');
        
        
-- 5-6) select last value of invoice_id
select max(invoice_id) 
from invoices;

-- update command
update invoices
set credit_total = invoice_total * 10/100, payment_total = invoice_total-credit_total
where invoice_id = 115;

select * 
from invoices
where invoice_id = 115;

-- 5-7) update record and set column value to 403 when vendor_id = 44
update vendors
set default_account_number = 403
where vendor_id = 44;

-- 5-8) update and join with vendor_id

update invoices as inv
 inner join vendors as vend
 on vend.vendor_id = inv.vendor_id
 set inv.terms_id = 2
 where vend.default_terms_id =3;
 
 
-- 5-9) select last value of invoice_id
select max(invoice_id) 
from invoices;

-- delete a row
delete 
from invoice_line_items
where invoice_id = 115;

-- remove the record from the invoice table
delete
from invoices
where invoices_id = 115;

