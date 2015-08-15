/**
 * $Header: /tools/PerfLab/src/PerfLab/PerformanceLab.java 4     5/31/01 4:07p Kkirkham $
 * $History: PerformanceLab.java $
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

// Locate in appropriate package
package PerfLab;

// Import needed classes
import java.util.*;
import java.io.*;

/**
 * Title:        Performance Lab<p>
 * Description:  A series of classes to assist with java performace experimentation and learning<p>
 * Copyright:    Copyright (c) Kurt Kirkham<p>
 * Company:      Indianapolis Java User's Group<p>
 * @author Kurt Kirkham
 * @version 1.0                                                             <p>
 *
 * To use this class:                                                       <p>
 *
 * 1. Import the package.                                                   <p>
 *    import PerfLab.*;                                                     <p>
 * 2. Instantiate the class.                                                <p>
 *    protected PerformanceLab m_objStringBuffers = new                     <br>
 *      PerformanceLab("Test Description");                                 <p>
 * 3. Execute all setup code that you want outside of the test.             <p>
 * 4. Get the starting time.                                                <p>
 *    m_objStringBuffers.setStartTime();                                    <p>
 * 5. Execute all code that you want to be timed.                           <p>
 * 6. Get the ending time.                                                  <p>
 *    m_objStringBuffers.setEndTime();                                      <p>
 * 7. Calculate and print the results.                                      <p>
 *    m_objStringBuffers.calculateTimeDifference();                         <p>
 * 8. After running all tests, compare the results                          <p>
 *       PerformanceLab.compareTests(m_objStrings,m_objStringBuffers);      <p>
 *
 */

 public class PerformanceLab {

    protected String m_strTestDesc;                      // Test Description
    protected long m_lStartTime;                         // Starting Time
    protected long m_lEndTime;                           // End Time
    protected long m_lTimeDif;                           // Time Difference

   /**
    *  Constructor.
    */

    public PerformanceLab() {
    } // end Constructor

   /**
    *  Constructor passing Test Description.
    *
    *  @param p_strTestDesc Test Description
    */

    public PerformanceLab(String p_strTestDesc) {

        m_strTestDesc = p_strTestDesc;

    } // end Constructor

 /**
  * Set Test Description.
  *
  * @param p_strTestDesc Test Description
  */

  public void setTestDesc(String p_strTestDesc) {

      m_strTestDesc = p_strTestDesc;

      return;

  } // end setTestDesc


 /**
  * Get Test Description.
  *
  * @return Test Description
  *
  */

  public String getTestDesc () {

     return m_strTestDesc;

  } // end getTestDesc


 /**
  * Set Start Time.                                                         <p>
  *
  * The time is set as the current time.
  *
  */

  public void setStartTime () {

    // Set Start Time to Current Time
    m_lStartTime = getCurrentTime();

    return;

  } // end setStartTime


 /**
  * Get Start Time.                                                         <p>
  *
  * @return Start Time of test.
  */

  public long getStartTime () {

    // Get Start Time
    return m_lStartTime;

  } // end getStartTime

 /**
  * Set End Time.                                                         <p>
  *
  * The time is set as the current time.
  *
  */

  public void setEndTime () {

    // Set End Time to Current Time
    m_lEndTime = getCurrentTime();

    return;

  } // end setEndTime

 /**
  * Get End Time.                                                          <p>
  */

  public long getEndTime () {

    // Get End Time
    return m_lEndTime;

  } // end getEndTime

 /**
  * Set Time Difference.                                                    <p>
  *
  * The time difference is set.
  *
  * @param p_lTimeDif Time Difference.
  *
  */

  public void setTimeDifference (long p_lTimeDif) {

    // Set End Time to Current Time
    m_lTimeDif = p_lTimeDif;

    return;

  } // end setTimeDifference

 /**
  * Get Time Difference.                                                    <p>
  */

  public long getTimeDifference () {

    // Get Time Difference
    return m_lTimeDif;

  } // end getTimeDifference


 /**
  * Get current time.
  *
  * @return Current Time
  *
  */

  public static long getCurrentTime () {

    return System.currentTimeMillis();

  } // end getCurrentTime

 /**
   * Compare two times and print the difference.
   *
   * @param p_lStartTime Starting Time
   * @param p_lEndTime Ending Time
   * @return Difference between Ending Time and Starting Time
   *
   */
  public static long compareTimes(long p_lStartTime, long p_lEndTime) {

    long lTimeDif;                             // Time Difference holder

    // compare the times
    lTimeDif = p_lEndTime - p_lStartTime;

    return lTimeDif;

  } // end compareAndPrintTime

 /**
   * Compare two times and print the difference.
   *
   * @return Difference between Ending Time and Starting Time
   *
   */
  public void calculateTimeDifference() {

     long lTimeDif;                             // Time Difference holder

     // Calculate the difference in Start and End Times
     lTimeDif = compareTimes(this.getStartTime(), this.getEndTime());

     this.setTimeDifference(lTimeDif);

     printResults(this.getTestDesc(), this.getStartTime(), this.getEndTime(),
         this.getTimeDifference());

     return;

  } // end calculateTimedifference

 /**
   * Compare two test results and print the difference.
   *
   * @param p_objTest1 Test 1 Performance Lab
   * @param p_objTest2 Test 2 performance Lab
   *
   */
  public static void compareTests (PerformanceLab p_objTest1, PerformanceLab p_objTest2 ) {

     long lTestDif1;                            // Test 1 time difference
     long lTestDif2;                            // Test 2 time difference

     long lDifTime;                             // Temp Time Diff Holder
     float fPctDif;                             // Temp Pct Dif

     // Store the differences
     lTestDif1 = p_objTest1.getTimeDifference();
     lTestDif2 = p_objTest2.getTimeDifference();

     // compare the times
     lDifTime = lTestDif1 - lTestDif2;

     if (lTestDif1 >= lTestDif2) {
        fPctDif = ((float) lDifTime / (float) lTestDif1) * 100;
     }
     else {
        fPctDif = ((float) lDifTime / (float) lTestDif2) * 100;
     }

     System.out.println("\nDifference between " + p_objTest1.getTestDesc() +
         " and " + p_objTest2.getTestDesc());
     System.out.println("Test 1 Time: " + lTestDif1);
     System.out.println("Test 2 Time: " + lTestDif2);
     System.out.println("Difference: " + lDifTime);
     System.out.println("Savings Percent: " + fPctDif);

     return;

  } // end compareTests

  /**
   * Print Results.
   */

  public static void printResults (String p_strTestDesc, long p_lStartTime,
      long p_lEndTime, long p_lTimeDif) {

    if (p_strTestDesc != null) {
        System.out.println(p_strTestDesc);
    }

    System.out.println("Start Time: "+ p_lStartTime);
    System.out.println("End Time: "+ p_lEndTime);
    System.out.println("Difference: "+ p_lTimeDif + "\n");

    return;

  } // end printresults

} // end PerformanceLab