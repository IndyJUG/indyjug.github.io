<?xml version='1.0'?>

<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 version="1.0">
<!-- xmlns:saxon="http://icl.com/saxon">-->

<xsl:strip-space elements="*"/>

<xsl:template match="/">
  --text: This is the result of the web-based survey of IndyJUG members.
  drop table survey;
  create table survey(
    id int,
  <xsl:apply-templates mode="main"/>
    primary key(id)
  );
  <xsl:apply-templates mode="children"/>
</xsl:template>

<xsl:template match="*|@*|node()" mode="children">
</xsl:template>

<xsl:template match="survey" mode="children">
  <xsl:apply-templates mode="children"/>
</xsl:template>

<xsl:template match="group" mode="children">
  --Group: <xsl:value-of select="translate(@name,'-','_')"/>

  <xsl:apply-templates mode="children"/>
</xsl:template>

<xsl:template match="field" mode="children">
  <xsl:if test="@type[.='multiple-choice']">
  drop table <xsl:value-of select="translate(@name,'-','_')"/>;
  create table <xsl:value-of select="translate(@name,'-','_')"/> (
    id int,
    <xsl:value-of select="translate(@name,'-','_')"/> varchar(50),
    primary key(id, <xsl:value-of select="translate(@name,'-','_')"/>)
  );
  </xsl:if>
</xsl:template>

<!-- ------------------------------- -->

<xsl:template match="*|@*|node()" mode="main">
</xsl:template>

<xsl:template match="survey" mode="main">
  <xsl:apply-templates mode="main"/>
</xsl:template>

<xsl:template match="group" mode="main">
  --Group: <xsl:value-of select="translate(@name,'-','_')"/> --
  <xsl:apply-templates mode="main"/>
</xsl:template>

<!-- <xsl:template match="@type[.='choice']" mode="main"> -->


<xsl:template match="field" mode="main">
  <xsl:if test="@type[.!='multiple-choice']">
    <xsl:value-of select="translate(@name,'-','_')"/> varchar(50),
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
