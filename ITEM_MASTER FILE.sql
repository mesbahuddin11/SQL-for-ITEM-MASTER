select sim.Prod as  'Product No',
       tmp.SEQ_NUM, 
	   tmp.ITEM_ID,
	   tmp.DESCRIPTION, 
	   tmp.OPT_INFO_2 as 'Package_Type', 
	   tmp.NET_LENGTH as 'Item_Length', 
	   tmp.NET_WIDTH as 'Item_Width', 
	   tmp.NET_HEIGHT as 'Item_Height' , 
	   tmp.NET_VOLUME as 'Item Volume', 
	   tmp.NET_WEIGHT as 'Item_Weight', 
	   tmp.DIM_UNIT, 
	   tmp.WGT_UNIT,
	   tmp.OPT_INFO_3 as 'UOM',
	   tmp.OPT_INFO_4 as 'Conv_Factor',
       sim.[Qty on Hand],   
       sim.[Usage Rate] as 'Usage per Month',
	   sim.[Curr Usage] as 'Usage of Cur Month',
       fp.location_id
	    
from sx_item_master sim
join (select *, ROW_NUMBER () over 
	       (partition by OPT_INFO_1 
		     order by case 
						when OPT_INFO_2= 'UCC' then 1
						When OPT_INFO_2= 'UPC' then 2
						else 3
					end ASC, 
				 TIME_STAMP

		     ) as t1

       from ITEM_INFO ii 
	   Where UPDATED = 'Y'
	   )  tmp

on sim.Prod = tmp.OPT_INFO_1
join t_fwd_pick fp
on sim.Prod= fp.item_number

------ Filter only Active and stock
where PStat = 'A'
   and WStat ='S'
   