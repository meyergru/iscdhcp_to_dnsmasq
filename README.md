# iscdhcp_to_dnsmasq
Scripts to facilitate ISC DHCP and Unbound migration to DNSmasq for OpnSense



You can add DNS names and aliases from Unbound like so from "input.xml", which is your saved config.xml:

python3 transform_unboundplus_to_dnsmasq_csv.py input.xml output.csv.

Then, you have to create the static map reservations with a tag UUID that ypu can glean from your config.xml after you created it in DNSmasq.
Then you call the staticmap conversion script multiple times for each DHCP range like so:

python3 ./transform_staticmap_to_csv.py f456106d-e2c0-4d81-8309-83e1f0ee054d lan mgsoft input.xml lan.csv
python3 ./transform_staticmap_to_csv.py 0b521991-963c-43bd-ad91-cee2b31f9403 opt6 iot input.xml iot.csv

Then, you import those files with output.csv first, in order to import aliases for DHCP reservations.

That is, if you have both xxx.yyy as DNS entry with aliases aaa.yyy and bbb.yyy and a DHCP reservation for xxx.yyy with MAC aa:bb:cc:dd:ee:ff, you have to import the DNS entry first and then blend in the DHCP reservation.

