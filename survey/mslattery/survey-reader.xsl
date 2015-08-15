<?xml version='1.0'?>

<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 version="1.0">
<!-- xmlns:saxon="http://icl.com/saxon">-->

<xsl:strip-space elements="*"/>

<xsl:output method="text"/>

<xsl:template match="/">
  //text: This is the result of the web-based survey of IndyJUG members.
//--------------------------------------------------------
<xsl:text disable-output-escaping="yes">
import java.util.*;
import java.io.*;

public class SurveyReader
{
  public static void main(String[] args)
    throws Exception
  {
    if(args.length &lt; 1 ) 
    {
      throw new Exception("Argument expected");
    }
    SurveyReader reader = new SurveyReader(args[0]);
    reader.readFile();
  }

  BufferedReader reader;
  Hashtable record;
  Hashtable children;
  int recordNum = 1;
  public SurveyReader(String filename)
    throws IOException
  {
    reader = new BufferedReader(new FileReader(filename));
  }
 
  public void readFile()
    throws IOException
  {
    while(readRecord());
    reader.close();
  }

  public void startRecord()
    throws IOException
  {
    record = new Hashtable();
    children = new Hashtable();
  }
  
  public void endRecord()
    throws IOException
  {
    recordNum++;
  
    StringBuffer sb = new StringBuffer();
    sb.append("insert into survey(\nid");
  
    Enumeration keys = record.keys();
    while(keys.hasMoreElements())
    {
      Object key = keys.nextElement();
      
      sb.append(',');
      sb.append( (String)key );
    }
    
    sb.append(")\nvalues\n(");
    sb.append(String.valueOf(recordNum));
          
    keys = record.keys();
    while(keys.hasMoreElements())
    {
      Object key = keys.nextElement();
      String value = (String)record.get(key);
      if( value.length() > 0 )
      {
        if( value.charAt(value.length()-1) == ',' )
        {
          value = value.substring(0, value.length()-1);
        }
        sb.append(",'");
        sb.append( value );
        sb.append('\'');
      }
      else
      {
        sb.append(",null");
      }
    }
    sb.append(")");
    System.out.println(sb.toString());
    
    sb = new StringBuffer();
    keys = children.keys();
    while(keys.hasMoreElements())
    {
      Object key = (String)keys.nextElement();
      Vector values = (Vector)children.get(key);
      for(int i=0; i &lt; values.size(); i++)
      {
        sb = new StringBuffer();
        sb.append("insert into ");
        sb.append(key);
        sb.append("(id,");
        sb.append(key);
        sb.append(") values (");
        sb.append(String.valueOf(recordNum));
        sb.append(",\'");
        sb.append(values.elementAt(i));
        sb.append("')");
        System.out.println(sb.toString());
      }
    }
  }
  
  public String readLine()
    throws IOException
  {
    return reader.readLine();
  }
  public void readLine(int index, String name)
    throws IOException
  {
    String line = reader.readLine();
    record.put(name, line.substring(index).trim());
  }
  public void readLineValues(int index, String name)
    throws IOException
  {
    Vector values = new Vector();
    String line = reader.readLine();
    StringTokenizer toker = new StringTokenizer(line.substring(index), ",");
    while( toker.hasMoreTokens() )
    {
      String value = toker.nextToken().toString().trim();
      if( value.length() > 0 )
      {
        values.addElement(value);
      }
    }
    children.put(name, values);
  }
  
  public boolean readRecord()
    throws IOException
  {
    startRecord();
    String firstLine = readLine();
    if( firstLine.equals("This is the result of the web-based survey of IndyJUG members") )
    {
      System.out.println("First line out of wack.");
      return false;
    }
    if( firstLine != null || firstLine.equals("Done."))
    {
</xsl:text>
  <xsl:apply-templates/>
      endRecord();
      return true;
    }
    return false;
  }
}
</xsl:template>

<xsl:template match="*|@*|node()">
</xsl:template>

<xsl:template match="survey">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="group">
  //Group: xxx
  readLine(); readLine(); readLine();

  <xsl:if test="@name='Employment'">
    //The following information is optional
    readLine(); readLine(); readLine();
  </xsl:if>

  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="field">
  readLine<xsl:if test="@type[.='multiple-choice']">Values</xsl:if>
  (<xsl:choose>
    <xsl:when test="@caption"><xsl:value-of select="string-length(@caption)+2"/></xsl:when>
    <xsl:otherwise><xsl:value-of select="string-length(@name)+2"/></xsl:otherwise>
  </xsl:choose>, "<xsl:value-of select="translate(@name,'-','_')"/>");
</xsl:template>

</xsl:stylesheet>
