<?xml version='1.0'?>

<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 version="1.0">
<!-- xmlns:saxon="http://icl.com/saxon">-->

<xsl:strip-space elements="*"/>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="*|@*|node()">
</xsl:template>

<xsl:template match="survey">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="group">
  Group: <xsl:value-of select="@name"/><xsl:text>&#xA;&#xA;</xsl:text>

  <xsl:if test="@name='Employment'">
    The following information is optional.<xsl:text>&#xA;&#xA;</xsl:text>
  </xsl:if>

  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="field">
  <xsl:choose>
    <xsl:when test="@caption">
      <xsl:value-of select="@caption"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="@name"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:text>&#x20;&#x20;</xsl:text>[<xsl:value-of select="@name"/>]
</xsl:template>

</xsl:stylesheet>
