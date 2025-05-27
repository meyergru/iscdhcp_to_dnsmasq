<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Output as text (CSV) -->
  <xsl:output method="text" encoding="UTF-8"/>

  <!-- Root template -->
  <xsl:template match="/">
    <!-- CSV Header -->
    <xsl:text>host,domain,local,ip,client_id,hwaddr,lease_time,ignore,set_tag,descr,aliases&#10;</xsl:text>

    <!-- Process each enabled host -->
    <xsl:for-each select="//unboundplus/hosts/host[enabled='1']">
      <xsl:variable name="uuid" select="@uuid"/>
      <xsl:variable name="host" select="hostname"/>
      <xsl:variable name="domain" select="domain"/>
      <xsl:variable name="ip" select="server"/>
      <xsl:variable name="descr" select="description"/>

      <!-- Derive tag UUID from domain name mapping -->
      <xsl:variable name="domain_uc" select="translate($domain, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
      <xsl:variable name="set_tag_uuid"
        select="//dnsmasq/dhcp_tags[tag=$domain_uc]/@uuid"/>

      <!-- Output fields -->
      <xsl:value-of select="$host"/><xsl:text>,</xsl:text>
      <xsl:value-of select="$domain"/><xsl:text>,</xsl:text>
      <xsl:text>1,</xsl:text> <!-- local -->
      <xsl:value-of select="$ip"/><xsl:text>,</xsl:text>
      <xsl:text>,</xsl:text> <!-- client_id -->
      <xsl:text>,</xsl:text> <!-- hwaddr -->
      <xsl:text>,</xsl:text> <!-- lease_time -->
      <xsl:text>0,</xsl:text> <!-- ignore -->
      <xsl:value-of select="$set_tag_uuid"/><xsl:text>,</xsl:text>
      <xsl:value-of select="$descr"/><xsl:text>,</xsl:text>

      <!-- Aliases -->
      <xsl:variable name="aliases" select="//unboundplus/aliases/alias[enabled='1' and host=$uuid]"/>
      <xsl:choose>
        <xsl:when test="count($aliases) &gt; 0">
          <xsl:text>"</xsl:text>
          <xsl:for-each select="$aliases">
            <xsl:variable name="alias_short" select="hostname"/>
            <xsl:variable name="alias_fqdn" select="concat(hostname, '.', $domain)"/>
            <xsl:value-of select="$alias_short"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of select="$alias_fqdn"/>
            <xsl:if test="position() != last()">
              <xsl:text>,</xsl:text>
            </xsl:if>
          </xsl:for-each>
          <xsl:text>"</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>""</xsl:text>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:text>&#10;</xsl:text>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>

