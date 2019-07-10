-- HW #4 Ch. 6 1-7
-- Nick Johnson

-- 6-1) group by vendor_id
select vendor_id, sum(invoice_total)
from invoices
group by vendor_id;


-- 6-2) join on vendor_id, sort by 2nd column in desc order
select vend.vendor_name, sum(inv.payment_total)
from vendors as vend
left join invoices as inv 
on inv.vendor_id = vend.vendor_id
group by vend.vendor_name
order by 2 desc;

-- 6-3) join on vendor_id from vendors and invoices
select vend.vendor_name, count(inv.invoice_id) as invoices_count, sum(inv.payment_total) as invoices_total
from vendors as vend
left join invoices as inv
on inv.vendor_id = vend.vendor_id
group by vend.vendor_id
order by invoices_count desc;



-- 6-4) include having cluase for count of items
select gl.account_description, count(li.line_item_description) as items_count, sum(li.line_item_amount) as total_item_amount
from general_ledger_accounts as gl
inner join invoice_line_items as li
on li.account_number = gl.account_number 
group by gl.account_description 
having items_count > 1
order by total_item_amount;

-- 6-5) 
select gl.account_description, count(li.line_item_description) as items_count, sum(li.line_item_amount) as total_item_amount 
from general_ledger_accounts as gl 
inner join  invoice_line_items as li 
on li.account_number = gl.account_number 
inner join invoices as i on i.invoice_id = li.invoice_id 
where i.invoice_date between '2011-04-1' and '2011-06-30' 
group by gl.account_description 
having items_count > 1 
order by total_item_amount desc;

-- 6-6) with rollup function
select li.account_number, sum(li.line_item_amount)
from general_ledger_accounts as gl 
inner join invoice_line_items as li
on li.account_number=gl.account_number 
group by li.account_number with rollup;


-- 6-7) 
select v.vendor_name, count(distinct gl.account_number) as accounts_count 
from vendors as v 
inner join invoices as i 
on i.vendor_id=v.vendor_id 
inner join invoice_line_items as li 
on li.invoice_id = i.invoice_id 
inner join general_ledger_accounts as gl 
on gl.account_number = li.account_number 
group by v.vendor_name having accounts_count > 1


