<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="section"/>
    <xsl:param name="domain"/>

    <xsl:output method="text" encoding="UTF-8"/>

    <xsl:template match="/">
        <!-- CSV-Kopfzeile -->
        <xsl:text>host,domain,local,ip,client_id,hwaddr,lease_time,ignore,set_tag,descr,aliases&#10;</xsl:text>

        <!-- Verarbeite staticmap unter dhcpd/section -->
        <xsl:apply-templates select="//dhcpd/*[name() = $section]/staticmap"/>
    </xsl:template>

    <xsl:template match="staticmap">
        <xsl:value-of select="hostname"/>
        <xsl:text>,</xsl:text>
        <xsl:value-of select="$domain"/>
        <xsl:text>,</xsl:text>
        <xsl:text>1,</xsl:text><!-- local -->
        <xsl:value-of select="ipaddr"/>
        <xsl:text>,</xsl:text>
        <xsl:text>,</xsl:text> <!-- client_id leer -->
        <xsl:value-of select="mac"/>
        <xsl:text>,</xsl:text>
        <xsl:text>,</xsl:text> <!-- lease_time leer -->
        <xsl:text>0</xsl:text> <!-- ignore = 0 -->
        <xsl:text>,</xsl:text>
        <xsl:text>PLACEHOLDER_SETTAG</xsl:text>
        <xsl:text>,</xsl:text>
        <xsl:value-of select="descr"/>
        <xsl:text>,</xsl:text>
        <xsl:text>&quot;&quot;</xsl:text> <!-- aliases leer -->
        <xsl:text>&#10;</xsl:text>
    </xsl:template>
</xsl:stylesheet>

