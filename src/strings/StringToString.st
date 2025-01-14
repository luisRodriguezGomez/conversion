USING System.Strings;


NAMESPACE Simatic.Ax.Conversion.Strings
    FUNCTION ToString : BOOL
        VAR_INPUT
            str : STRING;
        END_VAR
        VAR_OUTPUT
            value : WSTRING;
        END_VAR
        VAR_TEMP
            _len : INT;
            i : INT;
            s : WSTRING[1];
        END_VAR

        // Get length of input string
        _len := LengthOf(str);
        
        // Convert characters
        FOR i := 1 TO _len DO
            s[1] := TO_WCHAR(str[i]);
            value := Concat(value, s);
        END_FOR;

        // Null-terminate
        value := Concat(value, WCHAR#0);
        
        ToString := TRUE;
    END_FUNCTION

    FUNCTION ToString : BOOL
        VAR_INPUT
            str : WSTRING;
        END_VAR
        VAR_OUTPUT
            value : STRING;
        END_VAR
        VAR_TEMP
            _len : INT;
            i : INT;
            s : STRING[1];
        END_VAR

        // Get length of input WSTRING
        _len := To_Int(LengthOf(str));
        
        // Non successfull conversion if input WSTRING is longer than STRING size
        IF _len > 254 THEN
            value := '';
            ToString := FALSE;
            RETURN;
        END_IF;

        // Initialize output string
        value := '';

        // Convert characters
        FOR i := 1 TO _len DO
            s[1] := TO_CHAR(str[i]);
            value := Concat(value, s);
        END_FOR;

        // Null-terminate
        value := Concat(value, CHAR#0);        
        ToString := TRUE;
    END_FUNCTION
END_NAMESPACE