#! /usr/bin/env bash

cd ~
if [ ! -d "reon" ]; then 
	mkdir reon
fi
cd reon
if [ ! -e "products.txt" ]; then 
	touch products.txt
fi
echo "requesting reondistrict..."
curl -s --dump-header -G http://reondistrict.com/Product/Category/list/cid/12 | grep -E --only-matching "\/product\/.+\/\d+\/cid\/\d{1,4}" | sort --unique --dictionary-order --output="products.new.txt"
diff products.new.txt products.txt > new.txt
mv ./products.new.txt ./products.txt 
if [ $(wc -l new.txt | grep -E -o "\d+") == "0" ]; then echo "no new products"
else  echo "new products found, check new.txt"
fi
