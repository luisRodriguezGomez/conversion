NAMESPACE Simatic.Ax.Conversion.Float
FUNCTION INTERNAL RealToString : BOOL
    VAR_INPUT
        value : REAL;
    END_VAR
    VAR_OUTPUT
        str : STRING;
    END_VAR
    VAR_TEMP
        _whole_part : DINT;
        _decimal_part : REAL;
        _is_negative : BOOL;
        _temp_str : STRING;
        _decimal_str : STRING;
        _i : INT;
        _precision : REAL := REAL#1.0;
        _max_precision : INT := 6; // Standard precision for REAL
    END_VAR
    VAR CONSTANT
        MAX_REAL : REAL := REAL#3.402823e+38;
        MIN_REAL : REAL := REAL#-3.402823e+38;
    END_VAR
        // Check for out of range values
        IF (value < MIN_REAL) OR (value > MAX_REAL) THEN
            RealToString := FALSE;
            str := '';
            RETURN;
        END_IF;
    
        // Handle sign and absolute value
        _is_negative := value < 0.0;
        value := ABS(value);
    
        // Split into whole and decimal parts
        _whole_part := TRUNC(value);
        _decimal_part := value - TO_REAL(_whole_part);
    
        // Convert whole part to string
        _temp_str := Integer.ToString(value := _whole_part);
    
        // Add negative sign if needed
        IF _is_negative THEN
            _temp_str := CONCAT('-', _temp_str);
        END_IF;
    
        // Handle decimal part
        IF _decimal_part > 0.0 THEN
            _decimal_str := '';
            FOR _i := 1 TO _max_precision DO
                _decimal_part := _decimal_part * 10.0;
                _whole_part := TRUNC(_decimal_part);
                _decimal_str := CONCAT(_decimal_str, Integer.ToString(value := _whole_part));
                _decimal_part := _decimal_part - TO_REAL(_whole_part);
    
                // Stop if no more significant digits
                IF _decimal_part = 0.0 THEN
                    EXIT;
                END_IF;
            END_FOR;
    
            str := CONCAT(_temp_str, '.', _decimal_str);
        ELSE
            str := _temp_str;
        END_IF;
    
        RealToString := TRUE;
    END_FUNCTION
    
    FUNCTION INTERNAL RealToWString : BOOL
    VAR_INPUT
        value : REAL;
    END_VAR
    VAR_OUTPUT
        str : WSTRING;
    END_VAR
    VAR_TEMP
        _whole_part : DINT;
        _decimal_part : REAL;
        _is_negative : BOOL;
        _temp_str : WSTRING;
        _decimal_str : WSTRING;
        _i : INT;
        _precision : REAL := REAL#1.0;
        _max_precision : INT := 6; // Standard precision for REAL
    END_VAR
    VAR CONSTANT
        MAX_REAL : REAL := REAL#3.402823e+38;
        MIN_REAL : REAL := REAL#-3.402823e+38;
    END_VAR
        // Check for out of range values
        IF (value < MIN_REAL) OR (value > MAX_REAL) THEN
            RealToWString := FALSE;
            str := "";
            RETURN;
        END_IF;
    
        // Handle sign and absolute value
        _is_negative := value < 0.0;
        value := ABS(value);
    
        // Split into whole and decimal parts
        _whole_part := TRUNC(value);
        _decimal_part := value - TO_REAL(_whole_part);
    
        // Convert whole part to string
        _temp_str := TO_WSTRING(Integer.ToString(value := _whole_part));
    
        // Add negative sign if needed
        IF _is_negative THEN
            _temp_str := CONCAT("-", _temp_str);
        END_IF;
    
        // Handle decimal part
        IF _decimal_part > 0.0 THEN
            _decimal_str := "";
            FOR _i := 1 TO _max_precision DO
                _decimal_part := _decimal_part * 10.0;
                _whole_part := TRUNC(_decimal_part);
                _decimal_str := CONCAT(_decimal_str, TO_WSTRING(Integer.ToString(value := _whole_part)));
                _decimal_part := _decimal_part - TO_REAL(_whole_part);
    
                // Stop if no more significant digits
                IF _decimal_part = 0.0 THEN
                    EXIT;
                END_IF;
            END_FOR;
    
            str := CONCAT(_temp_str, ".", _decimal_str);
        ELSE
            str := _temp_str;
        END_IF;
    
        RealToWString := TRUE;
    END_FUNCTION
    
    FUNCTION INTERNAL LRealToString : BOOL
    VAR_INPUT
        value : LREAL;
    END_VAR
    VAR_OUTPUT
        str : STRING;
    END_VAR
    VAR_TEMP
        _whole_part : LINT;
        _decimal_part : LREAL;
        _is_negative : BOOL;
        _temp_str : STRING;
        _decimal_str : STRING;
        _i : INT;
        _precision : LREAL := 1.0;
        _max_precision : INT := 15; // Higher precision for LREAL
    END_VAR
    VAR CONSTANT
        MAX_LREAL : LREAL := LREAL#1.7976931348623157e+308;
        MIN_LREAL : LREAL := LREAL#-1.7976931348623157e+308;
    END_VAR
        // Check for out of range values
        IF (value < MIN_LREAL) OR (value > MAX_LREAL) THEN
            LRealToString := FALSE;
            str := '';
            RETURN;
        END_IF;
    
        // Handle sign and absolute value
        _is_negative := value < 0.0;
        value := ABS(value);
    
        // Split into whole and decimal parts
        _whole_part := TRUNC(value);
        _decimal_part := value - TO_LREAL(_whole_part);
    
        // Convert whole part to string
        _temp_str := Integer.ToString(value := _whole_part);
    
        // Add negative sign if needed
        IF _is_negative THEN
            _temp_str := CONCAT('-', _temp_str);
        END_IF;
    
        // Handle decimal part
        IF _decimal_part > 0.0 THEN
            _decimal_str := '';
            FOR _i := 1 TO _max_precision DO
                _decimal_part := _decimal_part * 10.0;
                _whole_part := TRUNC(_decimal_part);
                _decimal_str := CONCAT(_decimal_str, Integer.ToString(value := _whole_part));
                _decimal_part := _decimal_part - TO_LREAL(_whole_part);
    
                // Stop if no more significant digits
                IF _decimal_part = 0.0 THEN
                    EXIT;
                END_IF;
            END_FOR;
    
            str := CONCAT(_temp_str, '.', _decimal_str);
        ELSE
            str := _temp_str;
        END_IF;
    
        LRealToString := TRUE;
    END_FUNCTION
    
    FUNCTION INTERNAL LRealToWString : BOOL
    VAR_INPUT
        value : LREAL;
    END_VAR
    VAR_OUTPUT
        str : WSTRING;
    END_VAR
    VAR_TEMP
        _whole_part : LINT;
        _decimal_part : LREAL;
        _is_negative : BOOL;
        _temp_str : WSTRING;
        _decimal_str : WSTRING;
        _i : INT;
        _precision : LREAL := 1.0;
        _max_precision : INT := 15; // Higher precision for LREAL
    END_VAR
    VAR CONSTANT
        MAX_LREAL : LREAL := LREAL#1.7976931348623157e+308;
        MIN_LREAL : LREAL := LREAL#-1.7976931348623157e+308;
    END_VAR
        // Check for out of range values
        IF (value < MIN_LREAL) OR (value > MAX_LREAL) THEN
            LRealToWString := FALSE;
            str := "";
            RETURN;
        END_IF;
    
        // Handle sign and absolute value
        _is_negative := value < 0.0;
        value := ABS(value);
    
        // Split into whole and decimal parts
        _whole_part := TRUNC(value);
        _decimal_part := value - TO_LREAL(_whole_part);
    
        // Convert whole part to string
        _temp_str := TO_WSTRING(Integer.ToString(value := _whole_part));
    
        // Add negative sign if needed
        IF _is_negative THEN
            _temp_str := CONCAT("-", _temp_str);
        END_IF;
    
        // Handle decimal part
        IF _decimal_part > 0.0 THEN
            _decimal_str := "";
            FOR _i := 1 TO _max_precision DO
                _decimal_part := _decimal_part * 10.0;
                _whole_part := TRUNC(_decimal_part);
                _decimal_str := CONCAT(_decimal_str, TO_WSTRING(Integer.ToString(value := _whole_part)));
                _decimal_part := _decimal_part - TO_LREAL(_whole_part);
    
                // Stop if no more significant digits
                IF _decimal_part = 0.0 THEN
                    EXIT;
                END_IF;
            END_FOR;
    
            str := CONCAT(_temp_str, ".", _decimal_str);
        ELSE
            str := _temp_str;
        END_IF;
    
        LRealToWString := TRUE;
    END_FUNCTION    
   
    FUNCTION ToString : BOOL
        VAR_INPUT
            value : REAL;
        END_VAR
        VAR_OUTPUT
            str : STRING;
        END_VAR
            ToString := RealToString(value := value, str => str);
        END_FUNCTION
        
        FUNCTION ToString : BOOL
        VAR_INPUT
            value : REAL;
        END_VAR
        VAR_OUTPUT
            str : WSTRING;
        END_VAR
            ToString := RealToWString(value := value, str => str);
        END_FUNCTION
        
        FUNCTION ToString : BOOL
        VAR_INPUT
            value : LREAL;
        END_VAR
        VAR_OUTPUT
            str : STRING;
        END_VAR
            ToString := LRealToString(value := value, str => str);
        END_FUNCTION
        
        FUNCTION ToString : BOOL
        VAR_INPUT
            value : LREAL;
        END_VAR
        VAR_OUTPUT
            str : WSTRING;
        END_VAR
            ToString := LRealToWString(value := value, str => str);
        END_FUNCTION
    END_NAMESPACE