USING AxUnit;
USING AxUnit.Assert;
USING System.Strings;

NAMESPACE Simatic.Ax.Conversion.Float
    {TestFixture}
    CLASS LRealToWStringTest
    VAR
        str : WSTRING;
        res : BOOL;
    END_VAR   
           
        // Basic positive integer tests
        {Test(value := LREAL#0.0, expectedStr := WSTRING#'0', success := TRUE)}
        {Test(value := LREAL#1.0, expectedStr := WSTRING#'1', success := TRUE)}
        {Test(value := LREAL#10.0, expectedStr := WSTRING#'10', success := TRUE)}
        {Test(value := LREAL#123.0, expectedStr := WSTRING#'123', success := TRUE)}
        // Negative integer tests
        {Test(value := LREAL#-0.0, expectedStr := WSTRING#'0', success := TRUE)}
        {Test(value := LREAL#-1.0, expectedStr := WSTRING#'-1', success := TRUE)}
        {Test(value := LREAL#-10.0, expectedStr := WSTRING#'-10', success := TRUE)}
        {Test(value := LREAL#-123.0, expectedStr := WSTRING#'-123', success := TRUE)}
        // Decimal number tests
        {Test(value := LREAL#0.5, expectedStr := WSTRING#'0.5', success := TRUE)}
        {Test(value := LREAL#1.25, expectedStr := WSTRING#'1.25', success := TRUE)}
        {Test(value := LREAL#-3.14159, expectedStr := WSTRING#'-3.14159', success := TRUE)}
        {Test(value := LREAL#3.14159, expectedStr := WSTRING#'3.14159', success := TRUE)}
        {Test(value := LREAL#3.85, expectedStr := WSTRING#'3.85', success := TRUE)}
        {Test(value := LREAL#123.456, expectedStr := WSTRING#'123.456', success := TRUE)}
        // Scientific notation tests
        {Test(value := LREAL#1.23e+5, expectedStr := WSTRING#'123000', success := TRUE)}
        {Test(value := LREAL#-4.56e-3, expectedStr := WSTRING#'-0.00456', success := TRUE)}
        // Extreme value tests
        {Test(value := LREAL#1.7976931348623157e+308, expectedStr := WSTRING#'1.7976931348623157E+308', success := TRUE)}
        {Test(value := LREAL#-1.7976931348623157e+308, expectedStr := WSTRING#'-1.7976931348623157E+308', success := TRUE)}
        {Test(value := LREAL#1.1976931348623157e+308, expectedStr := WSTRING#'1.1976931348623157E+308', success := TRUE)}
        {Test(value := LREAL#-1.1976931348623157e+308, expectedStr := WSTRING#'-1.1976931348623157E+308', success := TRUE)}
        {Test(value := LREAL#1.193432E+229, expectedStr := WSTRING#'1.193432E+229', success := TRUE)}
        {Test(value := LREAL#-1.193432E+229, expectedStr := WSTRING#'-1.193432E+229', success := TRUE)}
        {Test(value := LREAL#1.793432E+29, expectedStr := WSTRING#'1.793432E+29', success := TRUE)}
        {Test(value := LREAL#-1.793432E+29, expectedStr := WSTRING#'-1.793432E+29', success := TRUE)}
        // More test cases 
        {Test(value := LREAL#2.225073858507201E-308, expectedStr := WSTRING#'2.225073858507201E-308', success := TRUE)}
        {Test(value := LREAL#-2.225073858507201E-308, expectedStr := WSTRING#'-2.225073858507201E-308', success := TRUE)}
        {Test(value := LREAL#1.234567890123456E+100, expectedStr := WSTRING#'1.234567890123456E+100', success := TRUE)}
        {Test(value := LREAL#-1.234567890123456E+100, expectedStr := WSTRING#'-1.234567890123456E+100', success := TRUE)}
        {Test(value := LREAL#9.999999999999999E+200, expectedStr := WSTRING#'9.999999999999999E+200', success := TRUE)}
        {Test(value := LREAL#-9.999999999999999E+200, expectedStr := WSTRING#'-9.999999999999999E+200', success := TRUE)}
        {Test(value := LREAL#1.000000000000001E+250, expectedStr := WSTRING#'1.000000000000001E+250', success := TRUE)}
        {Test(value := LREAL#-1.000000000000001E+250, expectedStr := WSTRING#'-1.000000000000001E+250', success := TRUE)}
        {Test(value := LREAL#5.555555555555555E+150, expectedStr := WSTRING#'5.555555555555555E+150', success := TRUE)}
        {Test(value := LREAL#-5.555555555555555E+150, expectedStr := WSTRING#'-5.555555555555555E+150', success := TRUE)}
        {Test(value := LREAL#1.234567890123456E+016, expectedStr := WSTRING#'1.234567890123456E+16', success := TRUE)}
        {Test(value := LREAL#-1.234567890123456E+016, expectedStr := WSTRING#'-1.234567890123456E+16', success := TRUE)}
        METHOD PUBLIC Convert_Positive_Integers
            VAR_INPUT
                value : LREAL;
                expectedStr : WSTRING;
                success : BOOL;
            END_VAR       
            VAR
                i : INT;
                expectedLen : INT;
                actualLen : INT;
                expectedStringTemp : String;
                actualStringTemp : String;                
            END_VAR
            res := LRealToWString(value := value, str => str);
            
            //CHECK RETURN RESULT VALUE
            Equal(expected := success, actual := res);            
            expectedLen := TO_INT(LengthOf(expectedStr));
            actualLen := TO_INT(LengthOf(str));
            // // Check expected and actual string Length
            // Equal(actualLen, expectedLen);             
            // get output in STRING form for fail message
            Conversion.Strings.ToString(expectedStr, expectedStringTemp);            
            Conversion.Strings.ToString(str, actualStringTemp);

            // Then compare each character
            FOR i := 1 TO expectedLen DO
                Assert.Equal(expected := expectedStr[i], actual := str[i], messageOnFail := CONCAT(CONCAT('actual: ', actualStringTemp),CONCAT('expected: ', expectedStringTemp)  )  );                
            END_FOR;          
        END_METHOD        
        
    END_CLASS    
    
END_NAMESPACE