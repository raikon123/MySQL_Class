-- HW #7
-- Nick Johnson


-- #8.1
select invoice_total, format(invoice_total, 1) as formatted, convert(invoice_total, signed) as converted,
cast(invoice_total as signed) as casted
	from invoices;


-- #8.2
select invoice_date, cast(invoice_date as datetime) as 'datetime', cast(invoice_date as char(7)) as 'year_month'
	from invoices;


-- #9.1
select invoice_total, round(invoice_total, 1) as one_decimal, round(invoice_total, 0) as no_decimal
	from invoices;


-- #9.2
select start_date, date_format(start_date,'%b%m/%d/%y') as month_date, 
				   date_format(start_date, '%c/%e/%y') as no_zeroes,
				   date_format(start_date, '%I:%i%p') as time_only,
                   date_format(start_date, '%c/%e/%y%I:%i%p') as date_time
    from ex.date_sample;
    
    
-- #9.3
/*select vendor_name, upper(vendor_name) as uppercase, vendor_phone, right(vendor_phone, 4) as 4_digit_phone
from vendors;

select vendor_name, upper(vendor_name) as uppercase, vendor_phone, 
	if(vendor_phone is null, null, concat_ws('.', mid(vendor_phone, 2, 3), mid(vendor_phone, 7, 3), right(vendor_phone, 4))) as phone,
    mid(vendor_name, locate(' ', vendor_name), locate(' ', vendor_name, position(' ' in vendor_name)+1) -locate(' ',vendor_name)) as middle
from vendors;*/

select vendor_name,
	upper(vendor_name) as Upper_Case,
    vendor_phone,
    right(vendor_phone, 4) as Last_Four,
    replace(replace(replace(vendor_phone,'(', ' '),') ', '.'),'-', '.') phone_dots,
    case when vendor_name like '% %'
		then substring_index(substring_index(vendor_name, ' ', 2), ' ', -1)
	else ' ' end as second_word
from ap.vendors;

    

-- #9.4
select invoice_number, invoice_date, date_add(invoice_date, interval 30 day)as 'plus 30 days', 
	   payment_date, datediff(payment_date,invoice_date) as 'days to pay', 
	   month(invoice_date) as 'month', 
       year(invoice_date) as 'year' 
from invoices;
