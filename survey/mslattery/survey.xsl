<?xml version='1.0'?>

<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 version="1.0">
<!-- xmlns:saxon="http://icl.com/saxon">-->

<xsl:output method="html"/>

<xsl:template match="/">
  <html>
  <xsl:comment>
  This file was generated via XSL
  Author: Michael Slattery, mslattery@searchsoft.net
  Modified by: Keith Musser, kmusser@idisys.com
  </xsl:comment>
  <head>
  <script>
  <xsl:comment>
  <xsl:text>
    function statusbar(msg)
    {
      window.status = msg;
    }
    function msg(amsg)
    {
      statusbar(amsg);
      alert(amsg);
    }
    function checkNumber(field)
    {
      while( field.value.indexOf('$') > -1 || field.value.indexOf(',') > -1 ||  field.value.indexOf(')') > -1 || field.value.indexOf('(') > -1)
      {
        field.value = field.value.replace('$', '');
        field.value = field.value.replace(',', '');
        field.value = field.value.replace(')', '');
        field.value = field.value.replace('(', '');
      }
            
      if(! isValidNumber(field.value) )
      {
        msg("An invalid number was entered");
      }
      else
        statusbar("");
    }
    function checkDate(field)
    {
      var regex = new RegExp("-", "g");
      field.value = field.value.replace(regex, '/');
      var li = field.value.lastIndexOf("/");
      if( field.value.length - li == 3 )
      {
        var cent = "20";
        var yr = field.value.substring(li+1, li+3);
        if( yr > "30" )
          cent = "19";
        field.value = field.value.substring(0,li+1) + cent + yr;
      }
      
      if( ! isValidDate(field.value) )
        msg("An invalid date was entered.  Use Month Date Year Format MM/DD/YYYY.");
      else
        statusbar("");
    }
    function isValidNumber(num)
    {
      var i, dc, j = 0;
      
      num.value = num.replace('$', "");
      num.value = num.replace(',', "");
      
      if( num.value != "" )
      {
        i = 0;
        if( num.charAt(0) == '-' )
          i = 1;
        dc = 0;
        for(; i &lt; num.length; i++)
        {
          if( num.charAt(i) == '.')
          {
            if( dc > 0 || i == (num.length - 1) || i==0 )
              return false;
            dc++;
          }
          else if( num.charAt(i) &lt; '0' || num.charAt(i) > '9')
            return false;
        }
      }
      return true;
    }
    function isValidDate(date)
    {
      var month, day, year, i;
  
      if( date != "" )
      {
        i = date.indexOf('/');
        if( i &lt; 1 )
          return false;
        month = date.substring(0,i);
        if( month.length &lt; 1 || month.length > 2 || month.charAt(0) &lt; '0' || month.charAt(0) > '9')
          return false;
        month = parseInt(month);
  
        date = date.substring(i+1);
        i = date.indexOf('/');
        if( i &lt; 1 )
          return false;
        day = date.substring(0,i);
        if( day.length &lt; 1 || day.length > 2 || day.charAt(0) &lt; '0' || day.charAt(0) > '9')
          return false;
        day = parseInt(day);
  
        year = date.substring(i+1);
        if( year.length != 4 || year.charAt(0) &lt; '0' || year.charAt(0) > '9')
          return false;
        year = parseInt(year);
  
        if( (month &lt; 1 || month> 12 || day &lt; 1 || day > 31 || year &lt; 1900 || year > 2100)
          || (month == 2 &amp;&amp; day > 29)
          || (month == 2 &amp;&amp; day == 29 &amp;&amp; (year % 4)!=0 )
          || (month == 4 &amp;&amp; day > 30)
          || (month == 6 &amp;&amp; day > 30)
          || (month == 9 &amp;&amp; day > 30)
          || (month == 11 &amp;&amp; day > 30) )
          return false;
      }
      return true;
    }
  </xsl:text>
  //</xsl:comment>
  </script>
  </head>
  <body>
    <xsl:comment> START KLM MODIFICATIONS </xsl:comment>
    <center><img src="../images/JUGLogo.gif"/></center>
    <h1>Indy JUG Survey</h1>
    <p>
      Please fill out out all of the following questions.
      All information is confidential.  Only statistical information will be made public.
      We are not asking for your name, so please only submit information once.  We will
      post results to this website.
    </p>
    <form action="../cgi-bin/cgiemail/survey/survey-mail.txt">
      <INPUT TYPE="hidden" NAME="success" VALUE="http://www.indyjug.net/survey/success.html"/>
    <xsl:comment> END KLM MODIFICATIONS </xsl:comment>

    <xsl:apply-templates/>
    <center>
      <input type="submit" name="Submit" value="Submit"/>
      <input type="reset" name="Reset" value="Reset"/>
    </center>
  </form></body></html>
</xsl:template>

<xsl:template match="*|@*|node()">
</xsl:template>

<xsl:template match="survey">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="group">
  <center><h2><xsl:value-of select="@name"/></h2>

  <xsl:if test="@name='Employment'">
    <table><tr><td bgcolor="White">The following information is optional.</td></tr></table>
  </xsl:if>

  <table border="1">
    <xsl:apply-templates/>
  </table>
  </center>
</xsl:template>

<xsl:template match="field">
  <tr>
  <td valign="top" bgcolor="LightYellow">
  <xsl:choose>
    <xsl:when test="@caption">
      <xsl:value-of select="@caption"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="@name"/>
    </xsl:otherwise>
  </xsl:choose>
  </td>
  <td bgcolor="LightGrey">
  <xsl:apply-templates select="@type"/>
  </td>
  </tr>
</xsl:template>


<xsl:template match="@type[.='text']|@type[.='date']|@type[.='number']|@type[.='time']">
  <xsl:if test=".='time'">
    (hh:mm)
  </xsl:if>
  <xsl:if test=".='date'">
    (mm/dd/yyyy)
  </xsl:if>
  <input type="text" name="{../@name}">
  <xsl:if test=".='number'">
    <xsl:attribute name="onchange">checkNumber(this);</xsl:attribute>
  </xsl:if>
  <xsl:if test=".='date'">
    <xsl:attribute name="onchange">checkDate(this);</xsl:attribute>
  </xsl:if>
  </input>
</xsl:template>

<xsl:template match="@type[.='yn']">
  Yes <input type="radio" name="{../@name}" value="Y"/>
  No <input type="radio" name="{../@name}" value="N"/>
</xsl:template>

<xsl:template match="@type[.='choice']">
  <select name="{../@name}">
    <xsl:if test="not(../@required)">
    <option></option>
    </xsl:if>
    <xsl:for-each select="../option">
    <option value="{text()},"><xsl:value-of select="text()"/></option>
    </xsl:for-each>
  </select>
  <xsl:if test="../other">
    Other: <input type="text" name="{../@name}"/>
  </xsl:if>
</xsl:template>

<xsl:template match="@type[.='multiple-choice']">
  <table>
  <xsl:for-each select="../option">
    <tr>
    <td><xsl:value-of select="text()"/></td>
    <td><input type="checkbox" name="{../@name}" value="{text()},"/></td>
    </tr>
  </xsl:for-each>
  </table>
  <xsl:if test="../other">
    Other: <input type="text" name="{../@name}"/>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
