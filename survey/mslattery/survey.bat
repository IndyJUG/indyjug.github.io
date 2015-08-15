@rem \sss\jdk\bin\java -cp c:\mystuff\dload\saxon\;c:\mystuff\dload\saxon\saxon.jar com.icl.saxon.StyleSheet -o survey.html survey.xml survey.xsl
@rem start survey.html
@rem \sss\jdk\bin\java -cp c:\mystuff\dload\saxon\;c:\mystuff\dload\saxon\saxon.jar com.icl.saxon.StyleSheet -o survey-mail.txt survey.xml survey-email.xsl
@rem \sss\jdk\bin\java -cp c:\mystuff\dload\saxon\;c:\mystuff\dload\saxon\saxon.jar com.icl.saxon.StyleSheet -o survey-sql.txt survey.xml survey-sql.xsl
\sss\jdk\bin\java -cp c:\mystuff\dload\saxon\;c:\mystuff\dload\saxon\saxon.jar com.icl.saxon.StyleSheet -o SurveyReader.java survey.xml survey-reader.xsl
\sss\jdk\bin\javac SurveyReader.java
\sss\jdk\bin\java SurveyReader survey-input.txt > survey.out