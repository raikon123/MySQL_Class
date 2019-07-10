-- Nick Johnson
-- 1
-- create a view named open_itmes that shows the invoices that haven't been paid. 
use ap;

create view open_items as
select v.vendor_name, i.invoice_number, i.invoice_total, (invoice_total-payment_total-credit_total) as balance_due
from invoices i 
join vendors v 
on i.vendor_id = v.vendor_id
where (invoice_total-payment_total-credit_total) > 0 and i.payment_total = 0
order by vendor_name;

select * 
from open_items;

-- 2
-- write a select statement that returns all the columns in the open_itmes view with one row for each balance due is greater than 1000$

select * 
from open_items
where balance_due > 1000;


-- 3
-- create a view named open_items_summary that returns one summary row for each vendor that has invoices that haven't been paid.

create view open_items_summary as
select vendor_name, count(balance_due) as open_item_count, sum(balance_due) as open_item_total
from open_items
group by vendor_name
order by open_item_total desc;


select *
from open_items_summary;

-- 4
-- write a SQL statement that returns just the first 5 rows from the open_items_summary view.

select * from open_items_summary
limit 5;


-- 5
-- create an updateable view named vendor_address that returns the vendor_id column and all the address columns for each vendor.
drop view if exists vendor_address;

create  view vendor_address
as select vendor_id, vendor_name, vendor_address1, vendor_address2, vendor_city, vendor_state, vendor_zip_code 
from vendors
with check option;

select *
from vendor_address;

-- 1990 Westwood Blvd Ste 260

-- 6
-- write an update statement that changes vendor_id 4 so that ste 260 is in address 2.

Update vendor_address
set vendor_address2 = "Ste 260", vendor_address1 = "1990 Westwood Blvd"
where vendor_id = 4;

-- check changes
select *
from vendor_address;





















