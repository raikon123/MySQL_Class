-- Nick Johnson
-- Ch. 7

-- 7.1
select vendor_name 
from vendors
where vendor_id in 
	(select vendor_id from invoices)
    
order by vendor_name;


-- 7.2 
select invoice_number, invoice_total
from invoices
where payment_total > (select avg(payment_total) from invoices
						where payment_total > 0) 
order by invoice_total desc;


-- 7.3
select account_number, account_description
from general_ledger_accounts as gla
where not exists 
	(select * from invoice_line_items where account_number = gla.account_number)
order by account_number;

-- 7.4
select v.vendor_name, i.invoice_id, li.invoice_sequence, li.line_item_amount
from vendors as v
	inner join invoices as i 
    on i.vendor_id = v.vendor_id
    inner join invoice_line_items as li 
    on li.invoice_id = i.invoice_id
where exists (select* from invoice_line_items where invoice_id = i.invoice_id
				group by invoice_id having count(*) > 1);
                
-- 7.5
-- max unpaid invoice
select vendor_id, max(invoice_total) as max_inv
from invoices as i 
where invoice_total - (credit_total + payment_total) > 0
group by vendor_id;

-- sum
select sum(max_inv) 
from (select vendor_id, max(invoice_total) as max_inv
		from invoices as i where invoice_total - (credit_total + payment_total) > 0 
			group by vendor_id) as t;

-- 7.6
select v.vendor_name, v.vendor_city, v.vendor_state
from vendors as v
	left join vendors as vs 
	on vs.vendor_city = v.vendor_city
    and vs.vendor_state = v.vendor_state
    and vs.vendor_id <> v.vendor_id
where vs.vendor_id is null 
order by v.vendor_state, v.vendor_city;

-- 7.7 
select v.vendor_name, i.invoice_number, i.invoice_date, i.invoice_total
from vendors as v
	inner join invoices as i
    on i.vendor_id  = v.vendor_id
where i.invoice_date = (select min(invoice_date) from invoices where vendor_id = v.vendor_id) 
order by v.vendor_name;

-- 7.8 
select v.vendor_name, i.invoice_number, i.invoice_date, i.invoice_total
from vendors as v
	inner join (select vendor_id, min(invoice_date) as min_date from invoices
					group by vendor_id) as old 
	on old.vendor_id = v.vendor_id
    inner join invoices as i
    on i.vendor_id = old.vendor_id 
    and i.invoice_date = old.min_date;
    