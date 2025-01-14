USING AxUnit.Assert;


NAMESPACE Simatic.Ax.Conversion.Strings
    {TestFixture}
    CLASS StringToStringTest
        VAR
            s : STRING;
            w : WSTRING;
            res : BOOL;            
        END_VAR

        // STRING to WSTRING Test Cases
        {Test(str := STRING#'', value := WSTRING#'', success := TRUE)}
        {Test(str := STRING#' ', value := WSTRING#' ', success := TRUE)}
        {Test(str := STRING#'Hello', value := WSTRING#'Hello', success := TRUE)}
        {Test(str := STRING#'World', value := WSTRING#'World', success := TRUE)}
        {Test(str := STRING#'Héllö', value := WSTRING#'Héllö', success := TRUE)}
        {Test(str := STRING#'Wörld', value := WSTRING#'Wörld', success := TRUE)}
        {Test(str := STRING#'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', value := WSTRING#'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', success := TRUE)}        {Test(str := STRING#'B * 300', value := WSTRING#'B * 300', success := TRUE)}        
        // {Test(str := STRING#'A */-+.;=!"·%&()" 254', value := WSTRING#'A */-+.;=!"·%&()', success := TRUE)}  
        METHOD PUBLIC Convert_STRING_TO_WSTRING
            VAR
                i : INT;
            END_VAR
            VAR_INPUT
                str : STRING;
                value : WSTRING;
                success : BOOL;
            END_VAR
            VAR_TEMP
                resVal : WSTRING;                
            END_VAR
            res := ToString(str := str, value => resVal);
            
            
            FOR i := 0 TO 400 DO       
                AxUnit.Assert.Equal(value[i], resVal[i]);
            END_FOR;               
            Equal(expected := success, actual := res);
        END_METHOD
        

        // WSTRING to STRING Test Cases
        {Test(str := WSTRING#'', value := STRING#'', success := TRUE)}
        {Test(str := WSTRING#' ', value := STRING#' ', success := TRUE)}
        {Test(str := WSTRING#'Hello', value := STRING#'Hello', success := TRUE)}
        {Test(str := WSTRING#'World', value := STRING#'World', success := TRUE)}
        {Test(str := WSTRING#'Héllö', value := STRING#'Héllö', success := TRUE)}
        {Test(str := WSTRING#'Wörld', value := STRING#'Wörld', success := TRUE)}        
        {Test(str := WSTRING#'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', value := STRING#'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', success := TRUE)}
        // TEST WSTRING OVERFLOW 
        {Test(str := WSTRING#'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', value := STRING#'', success := FALSE)}

        METHOD PUBLIC Convert_WSTRING_TO_STRING
            VAR
                i : INT;
            END_VAR
            VAR_INPUT
                str : WSTRING;
                value : STRING;
                success : BOOL;
            END_VAR
            VAR_TEMP
                resVal : STRING;
            END_VAR
            res := ToString(str := str, value => resVal);
            FOR i := 0 TO 400 DO       
                AxUnit.Assert.Equal(value[i], resVal[i]);
            END_FOR;    
            Equal(expected := success, actual := res);
        END_METHOD

         
        {Test}        
        METHOD PUBLIC Convert_STRING_TO_STRING_SPECIAL_CHARACTERS
            VAR
                i : INT;
                str : WSTRING;
                value : STRING;
                success : BOOL;
            END_VAR           
            VAR_TEMP
                resVal : STRING;
            END_VAR
            str := WSTRING#'A */-+.;=!"·%&()" 254';
            value := STRING#'A */-+.;=!"·%&()" 254';
            success := TRUE;

            res := ToString(str := str, value => resVal);
            FOR i := 0 TO 400 DO       
                AxUnit.Assert.Equal(value[i], resVal[i]);
            END_FOR;    
            Equal(expected := success, actual := res);
        END_METHOD


        {Test}        
        METHOD PUBLIC Convert_WSTRING_TO_wSTRING_SPECIAL_CHARACTERS
            VAR
                i : INT;
                str : STRING;
                value : WSTRING;
                success : BOOL;
            END_VAR           
            VAR_TEMP
                resVal : WSTRING;
            END_VAR
            str := STRING#'A */-+.;=!"·%&()" 254';
            value := WSTRING#'A */-+.;=!"·%&()" 254';
            success := TRUE;

            res := ToString(str := str, value => resVal);
            FOR i := 0 TO 400 DO       
                AxUnit.Assert.Equal(value[i], resVal[i]);
            END_FOR;    
            Equal(expected := success, actual := res);
         END_METHOD
    END_CLASS
END_NAMESPACE