
/**
 * $Header: /tools/PerfLab/src/PerfLab/StringTest.java 4     5/31/01 4:07p Kkirkham $
 * $History: StringTest.java $
 * 
 * *****************  Version 4  *****************
 * User: Kkirkham     Date: 5/31/01    Time: 4:07p
 * Updated in $/tools/PerfLab/src/PerfLab
 * Experimentation
 *
 * *****************  Version 3  *****************
 * User: Kkirkham     Date: 5/31/01    Time: 1:45p
 * Updated in $/tools/PerfLab/src/PerfLab
 * Experimentation
 *
 * *****************  Version 2  *****************
 * User: Kkirkham     Date: 4/30/01    Time: 12:41p
 * Updated in $/tools/PerfLab/src/PerfLab
 * Standardize
 *
 */


package PerfLab;

// import appropriate package
import PerfLab.*;

/**
 * Title:        String Test<p>
 * Description:  Test of String performance<p>
 * Copyright:    Copyright (c) Kurt Kirkham<p>
 * Company:      Sallie Mae<p>
 * @author Kurt Kirkham
 * @version 1.0
 */


public class StringTest {

    // Performance Lab reference, one for Strings and Two for String Buffers
    protected PerformanceLab m_objStrings = new PerformanceLab("String Concatination");
    protected PerformanceLab m_objStringBuffers = new PerformanceLab("String Buffer Concatination Test 1");
    protected PerformanceLab m_objStringBuffers2 = new PerformanceLab("String Buffer Concatination Test 2");

    public StringTest(int p_nNumberOfTimes) {

        // ** STRING PORTION **

         // Get Timings for Strings
         m_objStrings.setStartTime();

        // Setup the variables
        String strConcat = new String();

        // Loop through adding up the concatinations
        for (int i=0; i < p_nNumberOfTimes; i++) {
            strConcat += "X";
        }

        // Get End Timing
        m_objStrings.setEndTime();



        // ** STRING BUFFER PORTION Test 1**

        // Get Timings for Strings
         m_objStringBuffers.setStartTime();

        // Setup the variables
        StringBuffer strbufConcat = new StringBuffer();

        // Loop through adding up the concatinations
        for (int i=0; i < p_nNumberOfTimes; i++) {
            strbufConcat.append("X");
        }

        // Move String Buffer to String
        strConcat = strbufConcat.toString();

        // Get End Timing
        m_objStringBuffers.setEndTime();


        // ** STRING BUFFER PORTION Test 2**

        // Get Timings for Strings
         m_objStringBuffers2.setStartTime();

        // Setup the variables
        StringBuffer strbufConcat2 = new StringBuffer(p_nNumberOfTimes);

        // Loop through adding up the concatinations
        for (int i=0; i < p_nNumberOfTimes; i++) {
            strbufConcat2.append("X");
        }

        // Move String Buffer to String
        strConcat = strbufConcat2.toString();

        // Get End Timing
        m_objStringBuffers2.setEndTime();

        // Show Differences
        m_objStrings.calculateTimeDifference();
        m_objStringBuffers.calculateTimeDifference();
        m_objStringBuffers2.calculateTimeDifference();

        // Compare Test Results
        PerformanceLab.compareTests(m_objStrings,m_objStringBuffers);
        PerformanceLab.compareTests(m_objStrings,m_objStringBuffers2);
        PerformanceLab.compareTests(m_objStringBuffers,m_objStringBuffers2);

    }

    public static void main(String[] args) {
        StringTest objStringtest = new StringTest(25000);
    }
}