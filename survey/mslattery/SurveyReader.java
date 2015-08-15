
  //text: This is the result of the web-based survey of IndyJUG members.
//--------------------------------------------------------

import java.util.*;
import java.io.*;

public class SurveyReader
{
  public static void main(String[] args)
    throws Exception
  {
    if(args.length < 1 ) 
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
      for(int i=0; i < values.size(); i++)
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

  //Group: xxx
  readLine(); readLine(); readLine();

  
  readLine
  (6, "city");

  readLine
  (10, "areacode");

  //Group: xxx
  readLine(); readLine(); readLine();

  
  readLine
  (85, "present");

  readLineValues
  (71, "speakers");

  //Group: xxx
  readLine(); readLine(); readLine();

  
  readLine
  (54, "attendances");

  readLine
  (44, "often");

  readLine
  (47, "day");

  readLine
  (63, "time");

  readLine
  (53, "earliest");

  readLine
  (51, "latest");

  //Group: xxx
  readLine(); readLine(); readLine();

  
  readLine
  (44, "volunteer");

  readLineValues
  (14, "volunteer_how");

  //Group: xxx
  readLine(); readLine(); readLine();

  
  readLine
  (32, "understand_OO");

  readLine
  (50, "methodology_OO");

  readLine
  (40, "learn_OO");

  readLine
  (36, "catagory");

  readLine
  (42, "language");

  readLine
  (45, "programmer_months");

  readLine
  (44, "java_months");

  readLine
  (55, "java_skill");

  readLineValues
  (39, "familar_list");

  readLineValues
  (42, "learn_list");

  readLine
  (34, "opensource_use");

  readLine
  (53, "opensource_contrib");

  //Group: xxx
  readLine(); readLine(); readLine();

  
  readLine
  (31, "ide");

  readLine
  (43, "server");

  readLine
  (21, "os");

  //Group: xxx
  readLine(); readLine(); readLine();

  
    //The following information is optional
    readLine(); readLine(); readLine();
  
  readLine
  (32, "position");

  readLine
  (74, "seeking");

  readLine
  (37, "available");

  readLine
  (54, "hiring");

  readLine
  (32, "hiring_type");

  readLine
  (34, "contract_months");

      endRecord();
      return true;
    }
    return false;
  }
}
