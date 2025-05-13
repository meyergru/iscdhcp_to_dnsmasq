import sys
from lxml import etree

if len(sys.argv) < 3:
    print("Usage: python transform_unboundplus_to_dnsmasq_csv.py <input_file.xml> <output_file.csv>")
    sys.exit(1)

input_file = sys.argv[1]
output_file = sys.argv[2]
xslt_file = "transform_unboundplus_to_dnsmasq_csv.xslt"

xml_tree = etree.parse(input_file)
xslt_tree = etree.parse(xslt_file)
transform = etree.XSLT(xslt_tree)

result_tree = transform(xml_tree)

with open(output_file, "w", encoding="utf-8") as f:
    f.write(str(result_tree))

print(f"dnsmasq CSV exportiert nach: {output_file}")

