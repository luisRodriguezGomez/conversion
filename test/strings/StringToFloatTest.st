USING AxUnit.Assert;
USING System.Strings;


NAMESPACE Simatic.Ax.Conversion.Strings

    {TestFixture}
    CLASS ToFloatTest
        VAR
            res : BOOL;
            val : REAL;
            lval : LREAL;
        END_VAR
    
        // Basic positive float tests
        {Test(str := STRING#'6', value := REAL#6.0, success := TRUE)}
        {Test(str := STRING#'7', value := REAL#7.0, success := TRUE)}
        {Test(str := STRING#'8', value := REAL#8.0, success := TRUE)}
        {Test(str := STRING#'9', value := REAL#9.0, success := TRUE)}
        {Test(str := STRING#'10', value := REAL#10.0, success := TRUE)}
        {Test(str := STRING#'15', value := REAL#15.0, success := TRUE)}
        METHOD PUBLIC Convert_STRING_TO_REAL
            VAR_INPUT
                str : STRING;
                value : REAL;
                success : BOOL;
            END_VAR
            VAR_TEMP
                resVal : REAL;
            END_VAR
            res := ToFloat(str := str, value => resVal);
            Equal(expected := value, actual := resVal);
            Equal(expected := success, actual := res);
        END_METHOD
    
        // Basic negative float tests
        {Test(str := STRING#'-6', value := REAL#-6.0, success := TRUE)}
        {Test(str := STRING#'-7', value := REAL#-7.0, success := TRUE)}
        {Test(str := STRING#'-8', value := REAL#-8.0, success := TRUE)}
        {Test(str := STRING#'-9', value := REAL#-9.0, success := TRUE)}
        {Test(str := STRING#'-10', value := REAL#-10.0, success := TRUE)}
        {Test(str := STRING#'-15', value := REAL#-15.0, success := TRUE)}
        METHOD PUBLIC Convert_NEGATIVE_STRING_TO_REAL
            VAR_INPUT
                str : STRING;
                value : REAL;
                success : BOOL;
            END_VAR
            VAR_TEMP
                resVal : REAL;
            END_VAR
            res := ToFloat(str := str, value => resVal);
            Equal(expected := value, actual := resVal);
            Equal(expected := success, actual := res);
        END_METHOD
    
        // Scientific notation tests for REAL
        {Test(str := STRING#'1.23e+2', value := REAL#123.0, success := TRUE)}
        {Test(str := STRING#'-1.23e-2', value := REAL#-0.0123, success := TRUE)}
        {Test(str := STRING#'2.5e+3', value := REAL#2500.0, success := TRUE)}
        {Test(str := STRING#'-2.5e-3', value := REAL#-0.0025, success := TRUE)}
        METHOD PUBLIC Convert_SCIENTIFIC_NOTATION_TO_REAL
            VAR_INPUT
                str : STRING;
                value : REAL;
                success : BOOL;
            END_VAR
            VAR_TEMP
                resVal : REAL;
            END_VAR
            res := ToFloat(str := str, value => resVal);
            Equal(expected := value, actual := resVal);
            Equal(expected := success, actual := res);
        END_METHOD
    
        // LREAL conversion tests
        {Test(str := STRING#'6', value := LREAL#6.0, success := TRUE)}
        {Test(str := STRING#'7', value := LREAL#7.0, success := TRUE)}
        {Test(str := STRING#'8', value := LREAL#8.0, success := TRUE)}
        {Test(str := STRING#'9', value := LREAL#9.0, success := TRUE)}
        {Test(str := STRING#'10', value := LREAL#10.0, success := TRUE)}
        {Test(str := STRING#'15', value := LREAL#15.0, success := TRUE)}
        METHOD PUBLIC Convert_STRING_TO_LREAL
            VAR_INPUT
                str : STRING;
                value : LREAL;
                success : BOOL;
            END_VAR
            VAR_TEMP
                resVal : LREAL;
            END_VAR
            res := ToFloat(str := str, value => resVal);
            Equal(expected := value, actual := resVal);
            Equal(expected := success, actual := res);
        END_METHOD
    
        // Boundary value tests
        {Test(str := STRING#'3.402823e+38', value := REAL#3.402823e+38, success := TRUE)}
        {Test(str := STRING#'-3.402823e+38', value := REAL#-3.402823e+38, success := TRUE)}
        {Test(str := STRING#'3.402824e+38', value := REAL#0.0, success := FALSE)}
        {Test(str := STRING#'-3.402824e+38', value := REAL#0.0, success := FALSE)}
        METHOD PUBLIC Convert_REAL_BOUNDARY_VALUES
            VAR_INPUT
                str : STRING;
                value : REAL;
                success : BOOL;
            END_VAR
            VAR_TEMP
                resVal : REAL;
            END_VAR
            res := ToFloat(str := str, value => resVal);
            Equal(expected := value, actual := resVal);
            Equal(expected := success, actual := res);
        END_METHOD
    
        // Empty string
    {Test(str := STRING#'', value := REAL#0.0, success := FALSE)}

    // Invalid characters
    {Test(str := STRING#'abc', value := REAL#0.0, success := FALSE)}    
    {Test(str := STRING#'1e2e3', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1e2.3', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1e', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'e1', value := REAL#0.0, success := FALSE)}

    // Multiple signs
    {Test(str := STRING#'+-123.45', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'--123.45', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'++123.45', value := REAL#0.0, success := FALSE)}

    // Incorrect scientific notation
    {Test(str := STRING#'1.23e', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1.23e+', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1.23e-', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1.23E', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1.23E+', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1.23E-', value := REAL#0.0, success := FALSE)}

    // Extra decimal points
    {Test(str := STRING#'1.2.3', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1..23', value := REAL#0.0, success := FALSE)}

    // Spaces and non-numeric characters
    {Test(str := STRING#' 123.45', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'123.45 ', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'123.45abc', value := REAL#0.0, success := FALSE)}

    // Extreme cases
    {Test(str := STRING#'NaN', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'Infinity', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'-Infinity', value := REAL#0.0, success := FALSE)}
    METHOD PUBLIC Convert_INVALID_INPUTS
        VAR_INPUT
            str : STRING;
            value : REAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : REAL;
        END_VAR
        res := ToFloat(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD
    // Basic positive float tests
    {Test(str := WSTRING#"6", value := REAL#6.0, success := TRUE)}
    {Test(str := WSTRING#"7", value := REAL#7.0, success := TRUE)}
    {Test(str := WSTRING#"8", value := REAL#8.0, success := TRUE)}
    {Test(str := WSTRING#"9", value := REAL#9.0, success := TRUE)}
    {Test(str := WSTRING#"10", value := REAL#10.0, success := TRUE)}
    {Test(str := WSTRING#"15", value := REAL#15.0, success := TRUE)}
    METHOD PUBLIC Convert_WSTRING_TO_REAL
        VAR_INPUT
            str : WSTRING;
            value : REAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : REAL;
        END_VAR
        res := ToFloat(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // Basic negative float tests
    {Test(str := WSTRING#"-6", value := REAL#-6.0, success := TRUE)}
    {Test(str := WSTRING#"-7", value := REAL#-7.0, success := TRUE)}
    {Test(str := WSTRING#"-8", value := REAL#-8.0, success := TRUE)}
    {Test(str := WSTRING#"-9", value := REAL#-9.0, success := TRUE)}
    {Test(str := WSTRING#"-10", value := REAL#-10.0, success := TRUE)}
    {Test(str := WSTRING#"-15", value := REAL#-15.0, success := TRUE)}
    METHOD PUBLIC Convert_NEGATIVE_WSTRING_TO_REAL
        VAR_INPUT
            str : WSTRING;
            value : REAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : REAL;
        END_VAR
        res := ToFloat(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // Scientific notation tests for REAL
    {Test(str := WSTRING#"1.23e+2", value := REAL#123.0, success := TRUE)}
    {Test(str := WSTRING#"-1.23e-2", value := REAL#-0.0123, success := TRUE)}
    {Test(str := WSTRING#"2.5e+3", value := REAL#2500.0, success := TRUE)}
    {Test(str := WSTRING#"-2.5e-3", value := REAL#-0.0025, success := TRUE)}
    METHOD PUBLIC Convert_SCIENTIFIC_NOTATION_WSTRING_TO_REAL
        VAR_INPUT
            str : WSTRING;
            value : REAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : REAL;
        END_VAR
        res := ToFloat(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // LREAL conversion tests
    {Test(str := WSTRING#"6", value := LREAL#6.0, success := TRUE)}
    {Test(str := WSTRING#"7", value := LREAL#7.0, success := TRUE)}
    {Test(str := WSTRING#"8", value := LREAL#8.0, success := TRUE)}
    {Test(str := WSTRING#"9", value := LREAL#9.0, success := TRUE)}
    {Test(str := WSTRING#"10", value := LREAL#10.0, success := TRUE)}
    {Test(str := WSTRING#"15", value := LREAL#15.0, success := TRUE)}
    METHOD PUBLIC Convert_WSTRING_TO_LREAL
        VAR_INPUT
            str : WSTRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := ToFloat(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // Boundary value tests
    {Test(str := WSTRING#"3.402823e+38", value := REAL#3.402823e+38, success := TRUE)}
    {Test(str := WSTRING#"-3.402823e+38", value := REAL#-3.402823e+38, success := TRUE)}
    {Test(str := WSTRING#"3.402824e+38", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"-3.402824e+38", value := REAL#0.0, success := FALSE)}
    METHOD PUBLIC Convert_WSTRING_REAL_BOUNDARY_VALUES
        VAR_INPUT
            str : WSTRING;
            value : REAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : REAL;
        END_VAR
        res := ToFloat(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // Invalid inputs tests
    // Empty string
    {Test(str := WSTRING#"", value := REAL#0.0, success := FALSE)}

    // Invalid characters
    {Test(str := WSTRING#"abc", value := REAL#0.0, success := FALSE)}    
    {Test(str := WSTRING#"1e2e3", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1e2.3", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1e", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"e1", value := REAL#0.0, success := FALSE)}

    // Multiple signs
    {Test(str := WSTRING#"+-123.45", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"--123.45", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"++123.45", value := REAL#0.0, success := FALSE)}

    // Incorrect scientific notation
    {Test(str := WSTRING#"1.23e", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1.23e+", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1.23e-", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1.23E", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1.23E+", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1.23E-", value := REAL#0.0, success := FALSE)}

    // Extra decimal points
    {Test(str := WSTRING#"1.2.3", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1..23", value := REAL#0.0, success := FALSE)}

    // Spaces and non-numeric characters
    {Test(str := WSTRING#" 123.45", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"123.45 ", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"123.45abc", value := REAL#0.0, success := FALSE)}

    // Extreme cases
    {Test(str := WSTRING#"NaN", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"Infinity", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"-Infinity", value := REAL#0.0, success := FALSE)}
    METHOD PUBLIC Convert_INVALID_WSTRING_INPUTS
        VAR_INPUT
            str : WSTRING;
            value : REAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : REAL;
        END_VAR
        res := ToFloat(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    END_CLASS

    
{TestFixture} 
CLASS StringToAnyRealTest 
VAR 
    val : LREAL;
    res : BOOL;
END_VAR
    {Test(str := STRING#'', value := LREAL#0.0, success :=FALSE)}
    {Test(str := STRING#'+', value := LREAL#0.0, success :=FALSE)}
    {Test(str := STRING#'-', value := LREAL#0.0, success :=FALSE)}
    {Test(str := STRING#'0', value := LREAL#0.0, success :=TRUE)}
    {Test(str := STRING#'1', value := LREAL#1.0, success :=TRUE)}
    {Test(str := STRING#'2', value := LREAL#2.0, success :=TRUE)}
    {Test(str := STRING#'3', value := LREAL#3.0, success :=TRUE)}
    {Test(str := STRING#'4', value := LREAL#4.0, success :=TRUE)}
    {Test(str := STRING#'5', value := LREAL#5.0, success :=TRUE)}
    {Test(str := STRING#'6', value := LREAL#6.0, success :=TRUE)}
    {Test(str := STRING#'7', value := LREAL#7.0, success :=TRUE)}
    {Test(str := STRING#'8', value := LREAL#8.0, success :=TRUE)}
    {Test(str := STRING#'9', value := LREAL#9.0, success :=TRUE)}
    {Test(str := STRING#'10', value := LREAL#10.0, success :=TRUE)}
    {Test(str := STRING#'15', value := LREAL#15.0, success :=TRUE)}  
    METHOD PUBLIC Convert_STRING_TO_LREAL
        VAR_INPUT
            str : STRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := StringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    
    {Test(str := STRING#'4.20789', value := LREAL#4.20789, success :=TRUE)}
    {Test(str := STRING#'3.14159', value := LREAL#3.14159, success :=TRUE)}    
    {Test(str := STRING#'5.879658', value := LREAL#5.879658, success :=TRUE)}
    METHOD PUBLIC Convert_STRING_WITH_DECIMAL_TO_LREAL
        VAR_INPUT
            str : STRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := StringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    {Test(str := STRING#'-0', value := LREAL#0.0, success :=TRUE)}
    {Test(str := STRING#'-1', value := LREAL#-1.0, success :=TRUE)}
    {Test(str := STRING#'-2', value := LREAL#-2.0, success :=TRUE)}
    {Test(str := STRING#'-3', value := LREAL#-3.0, success :=TRUE)}
    {Test(str := STRING#'-4', value := LREAL#-4.0, success :=TRUE)}
    {Test(str := STRING#'-5', value := LREAL#-5.0, success :=TRUE)}
    {Test(str := STRING#'-6', value := LREAL#-6.0, success :=TRUE)}
    {Test(str := STRING#'-7', value := LREAL#-7.0, success :=TRUE)}
    {Test(str := STRING#'-8', value := LREAL#-8.0, success :=TRUE)}
    {Test(str := STRING#'-9', value := LREAL#-9.0, success :=TRUE)}
    {Test(str := STRING#'-10', value := LREAL#-10.0, success :=TRUE)}
    {Test(str := STRING#'-15', value := LREAL#-15.0, success :=TRUE)}
    METHOD PUBLIC Convert_NEGATIVE_STRING_TO_LREAL
        VAR_INPUT
            str : STRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := StringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    {Test(str := STRING#'-0.0', value := LREAL#0.0, success :=TRUE)}
    {Test(str := STRING#'-1.5', value := LREAL#-1.5, success :=TRUE)}
    {Test(str := STRING#'-2.75', value := LREAL#-2.75, success :=TRUE)}
    {Test(str := STRING#'-3.14159', value := LREAL#-3.14159, success :=TRUE)}
    {Test(str := STRING#'-4.20', value := LREAL#-4.20, success :=TRUE)}
    {Test(str := STRING#'-5.001', value := LREAL#-5.001, success :=TRUE)}
    METHOD PUBLIC Convert_NEGATIVE_STRING_WITH_DECIMAL_TO_LREAL
        VAR_INPUT
            str : STRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := StringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    {Test(str := STRING#'+0', value := LREAL#0.0, success :=TRUE)}
    {Test(str := STRING#'+1', value := LREAL#1.0, success :=TRUE)}
    {Test(str := STRING#'+2', value := LREAL#2.0, success :=TRUE)}
    {Test(str := STRING#'+3', value := LREAL#3.0, success :=TRUE)}
    {Test(str := STRING#'+4', value := LREAL#4.0, success :=TRUE)}
    {Test(str := STRING#'+5', value := LREAL#5.0, success :=TRUE)}
    {Test(str := STRING#'+6', value := LREAL#6.0, success :=TRUE)}
    {Test(str := STRING#'+7', value := LREAL#7.0, success :=TRUE)}
    {Test(str := STRING#'+8', value := LREAL#8.0, success :=TRUE)}
    {Test(str := STRING#'+9', value := LREAL#9.0, success :=TRUE)}
    METHOD PUBLIC Convert_PLUS_STRING_TO_LREAL
        VAR_INPUT
            str : STRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := StringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    {Test(str := STRING#'+0.0', value := LREAL#0.0, success :=TRUE)}
    {Test(str := STRING#'+1.5', value := LREAL#1.5, success :=TRUE)}
    {Test(str := STRING#'+2.75', value := LREAL#2.75, success :=TRUE)}
    {Test(str := STRING#'+3.14159', value := LREAL#3.14159, success :=TRUE)}
    {Test(str := STRING#'+4.20', value := LREAL#4.20, success :=TRUE)}
    {Test(str := STRING#'+5.001', value := LREAL#5.001, success :=TRUE)}
    METHOD PUBLIC Convert_PLUS_STRING_WITH_DECIMAL_TO_LREAL
        VAR_INPUT
            str : STRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := StringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    {Test(str := STRING#'18446744073709551600', value := LREAL#18446744073709551600.0, success :=TRUE)}
    {Test(str := STRING#'18446744073709551601', value := LREAL#18446744073709551601.0, success :=TRUE)}
    {Test(str := STRING#'18446744073709551602', value := LREAL#18446744073709551602.0, success :=TRUE)}
    {Test(str := STRING#'18446744073709551603', value := LREAL#18446744073709551603.0, success :=TRUE)}
    {Test(str := STRING#'18446744073709551604', value := LREAL#18446744073709551604.0, success :=TRUE)}
    {Test(str := STRING#'18446744073709551605', value := LREAL#18446744073709551605.0, success :=TRUE)}
    METHOD PUBLIC Convert_LARGE_POSITIVE_INTEGER_TO_LREAL
        VAR_INPUT
            str : STRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := StringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

  
   {Test(str := STRING#'1.7976931348623157e+308', value := LREAL#1.7976931348623157e+308, success :=TRUE)}
   {Test(str := STRING#'1.7976931348623157e+309', value := LREAL#0.0, success :=FALSE)}
   {Test(str := STRING#'1.7976931348623157e+310', value := LREAL#0.0, success :=FALSE)}
   {Test(str := STRING#'1.8e+309', value := LREAL#0.0, success :=FALSE)}     
   {Test(str := STRING#'-1.7976931348623157e+308', value := LREAL#-1.7976931348623157e+308, success :=TRUE)}
   {Test(str := STRING#'-1.7976931348623157e+309', value := LREAL#0.0, success :=FALSE)}
   {Test(str := STRING#'-1.7976931348623157e+310', value := LREAL#0.0, success :=FALSE)}
   {Test(str := STRING#'-1.8e+309', value := LREAL#0.0, success :=FALSE)}
    METHOD PUBLIC Convert_OVERFLOW_LARGE_NUMBER_TO_LREAL
        VAR_INPUT
            str : STRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := StringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // Multiple signs
    {Test(str := STRING#'+-123.45', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'--123.45', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'++123.45', value := REAL#0.0, success := FALSE)}

    // Leading zeros with signs
    {Test(str := STRING#'000+123.45', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1000+123.45', value := REAL#0.0, success := FALSE)}

    // Non-numeric characters
    {Test(str := STRING#'aaa', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'12a23.45', value := REAL#0.0, success := FALSE)}

    // Multiple decimal points
    {Test(str := STRING#'123.45.67', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'123..45', value := REAL#0.0, success := FALSE)}

    // Incorrect scientific notation
    {Test(str := STRING#'1.23e', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1.23e+', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1.23e-', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1e2e3', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1e2.3', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'1e', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'e123', value := REAL#0.0, success := FALSE)}

    // Empty or incomplete inputs
    {Test(str := STRING#'', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'+', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'-', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'.', value := REAL#0.0, success := FALSE)}

    // Spaces and non-standard formats
    {Test(str := STRING#' 123.45', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'123.45 ', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'123.45abc', value := REAL#0.0, success := FALSE)}

    // Special cases
    {Test(str := STRING#'NaN', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'Infinity', value := REAL#0.0, success := FALSE)}
    {Test(str := STRING#'-Infinity', value := REAL#0.0, success := FALSE)}

    METHOD PUBLIC Convert_WrongStrings_ExpectFalse
        VAR_INPUT
            str : STRING;
            value : REAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        
        res := StringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD
END_CLASS

{TestFixture} 
CLASS WStringToAnyRealTest 
VAR 
    val : LREAL;
    res : BOOL;
END_VAR

    // Basic tests
    {Test(str := WSTRING#"", value := LREAL#0.0, success :=FALSE)}
    {Test(str := WSTRING#"+", value := LREAL#0.0, success :=FALSE)}
    {Test(str := WSTRING#"-", value := LREAL#0.0, success :=FALSE)}
    {Test(str := WSTRING#"0", value := LREAL#0.0, success :=TRUE)}
    {Test(str := WSTRING#"1", value := LREAL#1.0, success :=TRUE)}
    {Test(str := WSTRING#"2", value := LREAL#2.0, success :=TRUE)}
    {Test(str := WSTRING#"3", value := LREAL#3.0, success :=TRUE)}
    {Test(str := WSTRING#"4", value := LREAL#4.0, success :=TRUE)}
    {Test(str := WSTRING#"5", value := LREAL#5.0, success :=TRUE)}
    {Test(str := WSTRING#"6", value := LREAL#6.0, success :=TRUE)}
    {Test(str := WSTRING#"7", value := LREAL#7.0, success :=TRUE)}
    {Test(str := WSTRING#"8", value := LREAL#8.0, success :=TRUE)}
    {Test(str := WSTRING#"9", value := LREAL#9.0, success :=TRUE)}
    {Test(str := WSTRING#"10", value := LREAL#10.0, success :=TRUE)}
    {Test(str := WSTRING#"15", value := LREAL#15.0, success :=TRUE)}
    METHOD PUBLIC Convert_WSTRING_TO_LREAL
        VAR_INPUT
            str : WSTRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := WStringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // Decimal tests
    {Test(str := WSTRING#"4.20789", value := LREAL#4.20789, success :=TRUE)}
    {Test(str := WSTRING#"3.14159", value := LREAL#3.14159, success :=TRUE)}    
    {Test(str := WSTRING#"5.879658", value := LREAL#5.879658, success :=TRUE)}
    METHOD PUBLIC Convert_WSTRING_WITH_DECIMAL_TO_LREAL
        VAR_INPUT
            str : WSTRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := WStringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // Negative number tests
    {Test(str := WSTRING#"-0", value := LREAL#0.0, success :=TRUE)}
    {Test(str := WSTRING#"-1", value := LREAL#-1.0, success :=TRUE)}
    {Test(str := WSTRING#"-2", value := LREAL#-2.0, success :=TRUE)}
    {Test(str := WSTRING#"-3", value := LREAL#-3.0, success :=TRUE)}
    {Test(str := WSTRING#"-4", value := LREAL#-4.0, success :=TRUE)}
    {Test(str := WSTRING#"-5", value := LREAL#-5.0, success :=TRUE)}
    {Test(str := WSTRING#"-6", value := LREAL#-6.0, success :=TRUE)}
    {Test(str := WSTRING#"-7", value := LREAL#-7.0, success :=TRUE)}
    {Test(str := WSTRING#"-8", value := LREAL#-8.0, success :=TRUE)}
    {Test(str := WSTRING#"-9", value := LREAL#-9.0, success :=TRUE)}
    {Test(str := WSTRING#"-10", value := LREAL#-10.0, success :=TRUE)}
    {Test(str := WSTRING#"-15", value := LREAL#-15.0, success :=TRUE)}
    METHOD PUBLIC Convert_NEGATIVE_WSTRING_TO_LREAL
        VAR_INPUT
            str : WSTRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := WStringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // Negative decimal tests
    {Test(str := WSTRING#"-0.0", value := LREAL#0.0, success :=TRUE)}
    {Test(str := WSTRING#"-1.5", value := LREAL#-1.5, success :=TRUE)}
    {Test(str := WSTRING#"-2.75", value := LREAL#-2.75, success :=TRUE)}
    {Test(str := WSTRING#"-3.14159", value := LREAL#-3.14159, success :=TRUE)}
    {Test(str := WSTRING#"-4.20", value := LREAL#-4.20, success :=TRUE)}
    {Test(str := WSTRING#"-5.001", value := LREAL#-5.001, success :=TRUE)}
    METHOD PUBLIC Convert_NEGATIVE_WSTRING_WITH_DECIMAL_TO_LREAL
        VAR_INPUT
            str : WSTRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := WStringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // Positive with plus sign tests
    {Test(str := WSTRING#"+0", value := LREAL#0.0, success :=TRUE)}
    {Test(str := WSTRING#"+1", value := LREAL#1.0, success :=TRUE)}
    {Test(str := WSTRING#"+2", value := LREAL#2.0, success :=TRUE)}
    {Test(str := WSTRING#"+3", value := LREAL#3.0, success :=TRUE)}
    {Test(str := WSTRING#"+4", value := LREAL#4.0, success :=TRUE)}
    {Test(str := WSTRING#"+5", value := LREAL#5.0, success :=TRUE)}
    {Test(str := WSTRING#"+6", value := LREAL#6.0, success :=TRUE)}
    {Test(str := WSTRING#"+7", value := LREAL#7.0, success :=TRUE)}
    {Test(str := WSTRING#"+8", value := LREAL#8.0, success :=TRUE)}
    {Test(str := WSTRING#"+9", value := LREAL#9.0, success :=TRUE)}
    METHOD PUBLIC Convert_PLUS_WSTRING_TO_LREAL
        VAR_INPUT
            str : WSTRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := WStringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // Positive decimal with plus sign tests
    {Test(str := WSTRING#"+0.0", value := LREAL#0.0, success :=TRUE)}
    {Test(str := WSTRING#"+1.5", value := LREAL#1.5, success :=TRUE)}
    {Test(str := WSTRING#"+2.75", value := LREAL#2.75, success :=TRUE)}
    {Test(str := WSTRING#"+3.14159", value := LREAL#3.14159, success :=TRUE)}
    {Test(str := WSTRING#"+4.20", value := LREAL#4.20, success :=TRUE)}
    {Test(str := WSTRING#"+5.001", value := LREAL#5.001, success :=TRUE)}
    METHOD PUBLIC Convert_PLUS_WSTRING_WITH_DECIMAL_TO_LREAL
        VAR_INPUT
            str : WSTRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := WStringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // Large number tests
    {Test(str := WSTRING#"18446744073709551600", value := LREAL#18446744073709551600.0, success :=TRUE)}
    {Test(str := WSTRING#"18446744073709551601", value := LREAL#18446744073709551601.0, success :=TRUE)}
    {Test(str := WSTRING#"18446744073709551602", value := LREAL#18446744073709551602.0, success :=TRUE)}
    {Test(str := WSTRING#"18446744073709551603", value := LREAL#18446744073709551603.0, success :=TRUE)}
    {Test(str := WSTRING#"18446744073709551604", value := LREAL#18446744073709551604.0, success :=TRUE)}
    {Test(str := WSTRING#"18446744073709551605", value := LREAL#18446744073709551605.0, success :=TRUE)}
    METHOD PUBLIC Convert_LARGE_POSITIVE_INTEGER_TO_LREAL
        VAR_INPUT
            str : WSTRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := WStringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // Overflow tests
    {Test(str := WSTRING#"1.7976931348623157e+308", value := LREAL#1.7976931348623157e+308, success :=TRUE)}
    {Test(str := WSTRING#"1.7976931348623157e+309", value := LREAL#0.0, success :=FALSE)}
    {Test(str := WSTRING#"1.7976931348623157e+310", value := LREAL#0.0, success :=FALSE)}
    {Test(str := WSTRING#"1.8e+309", value := LREAL#0.0, success :=FALSE)}     
    {Test(str := WSTRING#"-1.7976931348623157e+308", value := LREAL#-1.7976931348623157e+308, success :=TRUE)}
    {Test(str := WSTRING#"-1.7976931348623157e+309", value := LREAL#0.0, success :=FALSE)}
    {Test(str := WSTRING#"-1.7976931348623157e+310", value := LREAL#0.0, success :=FALSE)}
    {Test(str := WSTRING#"-1.8e+309", value := LREAL#0.0, success :=FALSE)}
    METHOD PUBLIC Convert_OVERFLOW_LARGE_NUMBER_TO_LREAL
        VAR_INPUT
            str : WSTRING;
            value : LREAL;
            success : BOOL;
        END_VAR
        VAR_TEMP
            resVal : LREAL;
        END_VAR
        res := WStringToAnyLReal(str := str, value => resVal);
        Equal(expected := value, actual := resVal);
        Equal(expected := success, actual := res);
    END_METHOD

    // Invalid input tests
    // Multiple signs
    {Test(str := WSTRING#"+-123.45", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"--123.45", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"++123.45", value := REAL#0.0, success := FALSE)}

    // Leading zeros with signs
    {Test(str := WSTRING#"000+123.45", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1000+123.45", value := REAL#0.0, success := FALSE)}

    // Non-numeric characters
    {Test(str := WSTRING#"aaa", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"12a23.45", value := REAL#0.0, success := FALSE)}

    // Multiple decimal points
    {Test(str := WSTRING#"123.45.67", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"123..45", value := REAL#0.0, success := FALSE)}

    // Incorrect scientific notation
    {Test(str := WSTRING#"1.23e", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1.23e+", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1.23e-", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1e2e3", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1e2.3", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"1e", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"e123", value := REAL#0.0, success := FALSE)}

    // Empty or incomplete inputs
    {Test(str := WSTRING#"", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"+", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"-", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#".", value := REAL#0.0, success := FALSE)}

    // Spaces and non-standard formats
    {Test(str := WSTRING#" 123.45", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"123.45 ", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"123.45abc", value := REAL#0.0, success := FALSE)}

    // Special cases
    {Test(str := WSTRING#"NaN", value := REAL#0.0, success := FALSE)}
    {Test(str := WSTRING#"Infinity", value :=REAL#0.0, success := FALSE)} 
    {Test(str := WSTRING#"-Infinity", value := REAL#0.0, success := FALSE)} 
    METHOD PUBLIC Convert_WrongWStrings_ExpectFalse 
        VAR_INPUT 
            str : WSTRING; 
            value : REAL; 
            success : BOOL;
        END_VAR 
        VAR_TEMP 
            resVal : LREAL; 
        END_VAR 
        res := WStringToAnyLReal(str := str, value => resVal); 
        Equal(expected := value, actual := resVal); 
        Equal(expected := success, actual := res); 
    END_METHOD 
END_CLASS


END_NAMESPACE