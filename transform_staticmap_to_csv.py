#! /usr/bin/python
import sys
from lxml import etree

# Check auf Parameter
if len(sys.argv) < 6:
    print("Usage: python transform_staticmap_to_csv.py <set_tag> <section> <domain> <input_file.xml> <output_file.csv>")
    sys.exit(1)

set_tag = sys.argv[1]
section = sys.argv[2]
domain = sys.argv[3]
input_file = sys.argv[4]
output_file = sys.argv[5]
xslt_file = "transform_staticmap_to_csv.xslt"

# Lade XML und XSLT
xml_tree = etree.parse(input_file)
xslt_tree = etree.parse(xslt_file)
transform = etree.XSLT(xslt_tree)

# Transformation mit Parametern
result_tree = transform(xml_tree,
                        section=etree.XSLT.strparam(section),
                        domain=etree.XSLT.strparam(domain))

# String der Transformation auslesen
output_str = str(result_tree)

# Ersetze den SET_TAG Platzhalter
output_str = output_str.replace("PLACEHOLDER_SETTAG", set_tag)

# Schreibe Ausgabe in CSV
with open(output_file, "w", encoding="utf-8") as f:
    f.write(output_str)

print(f"CSV-Datei erstellt: {output_file}")

