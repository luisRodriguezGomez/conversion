USING System.Strings;

NAMESPACE Simatic.Ax.Conversion.Strings    

    FUNCTION ToFloat : BOOL
        VAR_INPUT
            str : STRING;
        END_VAR
        VAR_OUTPUT
            value : REAL;
        END_VAR
        VAR_TEMP
            _val : LREAL;
        END_VAR
        VAR CONSTANT
            MAX_REAL : LREAL := LREAL#3.402823e+38;
            MIN_REAL : LREAL := LREAL#-3.402823e+38;
        END_VAR
        
        ToFloat := StringToAnyLReal(str := str, value => _val);
        
        IF (_val < MIN_REAL) OR (_val > MAX_REAL) THEN
            value := REAL#0.0;
            ToFloat := FALSE;
        ELSE
            value := TO_REAL(_val);
        END_IF;
    END_FUNCTION
    
    FUNCTION ToFloat : BOOL
        VAR_INPUT
            str : STRING;
        END_VAR
        VAR_OUTPUT
            value : LREAL;
        END_VAR
        VAR_TEMP
            _val : LREAL;
        END_VAR
        VAR CONSTANT
            MAX_LREAL : LREAL := LREAL#1.7976931348623157e+308;
            MIN_LREAL : LREAL := LREAL#-1.7976931348623157e+308;
        END_VAR
        
        ToFloat := StringToAnyLReal(str := str, value => _val);
        
        IF (_val < MIN_LREAL) OR (_val > MAX_LREAL) THEN
            value := LREAL#0.0;
            ToFloat := FALSE;
        ELSE
            value := _val;
        END_IF;
    END_FUNCTION

    FUNCTION ToFloat : BOOL
        VAR_INPUT
            str : WSTRING;
        END_VAR
        VAR_OUTPUT
            value : REAL;
        END_VAR
        VAR_TEMP
            _val : LREAL;
        END_VAR
        VAR CONSTANT
            MAX_REAL : LREAL := LREAL#3.402823e+38;
            MIN_REAL : LREAL := LREAL#-3.402823e+38;
        END_VAR
        
        ToFloat := WStringToAnyLReal(str := str, value => _val);
        
        IF (_val < MIN_REAL) OR (_val > MAX_REAL) THEN
            value := REAL#0.0;
            ToFloat := FALSE;
        ELSE
            value := TO_REAL(_val);
        END_IF;
    END_FUNCTION
    
    FUNCTION ToFloat : BOOL
        VAR_INPUT
            str : WSTRING;
        END_VAR
        VAR_OUTPUT
            value : LREAL;
        END_VAR
        VAR_TEMP
            _val : LREAL;
        END_VAR
        VAR CONSTANT
            MAX_LREAL : LREAL := LREAL#1.7976931348623157e+308;
            MIN_LREAL : LREAL := LREAL#-1.7976931348623157e+308;
        END_VAR
        
        ToFloat := WStringToAnyLReal(str := str, value => _val);
        
        IF (_val < MIN_LREAL) OR (_val > MAX_LREAL) THEN
            value := LREAL#0.0;
            ToFloat := FALSE;
        ELSE
            value := _val;
        END_IF;
    END_FUNCTION
    
    FUNCTION INTERNAL StringToAnyLReal : BOOL
        VAR_INPUT
            str : STRING;
        END_VAR
        VAR_OUTPUT
            value : LREAL;
        END_VAR
        VAR_TEMP
            _len : INT;
            i : INT;
            _val : LREAL;
            _sig : INT;
            _start : INT;
            _c : STRING;
            _decimal_pos : INT;
            _whole_part : LREAL;
            _decimal_part : LREAL;
            _exp_pos : INT;
            _exp_value : DINT;
            _exp_sign : INT;
            _precision : LREAL;
            _is_exact_max : BOOL;
            _is_exact_min : BOOL;
            _has_digits : BOOL;
            _has_exponent : BOOL;
        END_VAR
        VAR CONSTANT
            MAX_LREAL : LREAL := LREAL#1.7976931348623157e+308;
            MIN_LREAL : LREAL := LREAL#-1.7976931348623157e+308;
            MAX_LREAL_STR : STRING := '1.7976931348623157e+308';
            MAX_LREAL_STR_PLUS : STRING := '+1.7976931348623157e+308';
            MIN_LREAL_STR : STRING := '-1.7976931348623157e+308';
        END_VAR
    
        // Reset flags
        _has_digits := FALSE;
        _has_exponent := FALSE;
        _is_exact_max := 
            (str = MAX_LREAL_STR) OR 
            (str = MAX_LREAL_STR_PLUS);
        
        _is_exact_min := (str = MIN_LREAL_STR);
    
        _len := LengthOf(str);
    
        // Handle sign
        IF (str[1] = '+') THEN
            _sig := 1;
            _start := 2;
        ELSIF (str[1] = '-') THEN
            _sig := -1;
            _start := 2;
        ELSE
            _sig := 1;
            _start := 1;
        END_IF;
    
        _whole_part := 0.0;
        _decimal_part := 0.0;
        _decimal_pos := 0;
        _exp_pos := 0;
        _exp_value := 0;
        _exp_sign := 1;
        _precision := 1.0;
    
        // Check for empty string or just a sign
        IF (_len - _start < 0) THEN
            StringToAnyLReal := FALSE;
            RETURN;
        END_IF;
    
        // Parse string
        FOR i := _start TO _len DO
            _c := str[i];
            CASE _c OF
                '0': 
                    _val := 0.0;
                    _has_digits := TRUE;
                '1': 
                    _val := 1.0;
                    _has_digits := TRUE;
                '2': 
                    _val := 2.0;
                    _has_digits := TRUE;
                '3': 
                    _val := 3.0;
                    _has_digits := TRUE;
                '4': 
                    _val := 4.0;
                    _has_digits := TRUE;
                '5': 
                    _val := 5.0;
                    _has_digits := TRUE;
                '6': 
                    _val := 6.0;
                    _has_digits := TRUE;
                '7': 
                    _val := 7.0;
                    _has_digits := TRUE;
                '8': 
                    _val := 8.0;
                    _has_digits := TRUE;
                '9': 
                    _val := 9.0;
                    _has_digits := TRUE;
                '.':
                    IF (_decimal_pos = 0) AND (_exp_pos = 0) THEN
                        _decimal_pos := i;
                        CONTINUE;
                    ELSE
                        StringToAnyLReal := FALSE;
                        RETURN;
                    END_IF;
               'E', 'e':
                    IF (_exp_pos = 0) AND _has_digits THEN
                        _exp_pos := i;
                        _has_exponent := TRUE;
                        CONTINUE;
                    ELSE
                        StringToAnyLReal := FALSE;
                        RETURN;
                    END_IF;
                '+':
                    IF (_exp_pos > 0) AND (i = _exp_pos + 1) THEN
                        _exp_sign := 1;
                        CONTINUE;
                    ELSE
                        StringToAnyLReal := FALSE;
                        RETURN;
                    END_IF;
                '-':
                    IF (_exp_pos > 0) AND (i = _exp_pos + 1) THEN
                        _exp_sign := -1;
                        CONTINUE;
                    ELSE
                        StringToAnyLReal := FALSE;
                        RETURN;
                    END_IF;
                ELSE
                    StringToAnyLReal := FALSE;
                    RETURN;
            END_CASE;
    
            // Build whole part
            IF (_decimal_pos = 0) AND (_exp_pos = 0 OR i < _exp_pos) THEN
                _whole_part := _whole_part * 10.0 + _val;
            // Build decimal part
            ELSIF (_decimal_pos > 0) AND (_exp_pos = 0 OR i < _exp_pos) THEN
                _decimal_part := _decimal_part * 10.0 + _val;
                _precision := _precision * 0.1;
            // Build exponent
            ELSIF (_exp_pos > 0) THEN
                _exp_value := _exp_value * 10 + TO_DINT(_val);
            END_IF;   
        END_FOR;

        // Check if we have an exponent but no digits after it
        IF _has_exponent THEN
            IF (_exp_pos = _len) OR // E is the last character
            ((_exp_pos + 1 = _len) AND (str[_len] = '+' OR str[_len] = '-')) OR // E+/E- at the end
            (_exp_value = 0 AND _exp_pos < _len) THEN // E followed by invalid characters
                StringToAnyLReal := FALSE;
                RETURN;
            END_IF;
        END_IF;
    
        // Additional validation checks
        // Ensure there are digits before and/or after decimal point
        IF NOT _has_digits THEN
            StringToAnyLReal := FALSE;
            RETURN;
        END_IF;
    
        // Combine whole and decimal parts
        value := _whole_part + (_decimal_part * _precision);
    
        // Handle exponent
        IF (_exp_pos > 0) THEN
            _val := 1.0;
            FOR i := 1 TO TO_INT(_exp_value) DO
                IF (_exp_sign = 1) THEN
                    _val := _val * 10.0;
                ELSE
                    _val := _val * 0.1;
                END_IF;
            END_FOR;
            
            value := value * _val;
        END_IF;
    
        // Apply sign
        value := value * TO_LREAL(_sig);
    
        // Special handling for exact maximum and minimum values
        IF _is_exact_max THEN
            value := MAX_LREAL;
        ELSIF _is_exact_min THEN
            value := MIN_LREAL;
        END_IF;
    
        // Check for out of range values
        IF (value < MIN_LREAL) OR (value > MAX_LREAL) THEN
            value := 0.0;
            StringToAnyLReal := FALSE;
            RETURN;
        END_IF;
    
        StringToAnyLReal := TRUE;
    END_FUNCTION

    FUNCTION INTERNAL WStringToAnyLReal : BOOL
        VAR_INPUT
            str : WSTRING;
        END_VAR
        VAR_OUTPUT
            value : LREAL;
        END_VAR
        VAR_TEMP
            _len : INT;
            i : INT;
            _val : LREAL;
            _sig : INT;
            _start : INT;
            _c : WSTRING;
            _decimal_pos : INT;
            _whole_part : LREAL;
            _decimal_part : LREAL;
            _exp_pos : INT;
            _exp_value : DINT;
            _exp_sign : INT;
            _precision : LREAL;
            _is_exact_max : BOOL;
            _is_exact_min : BOOL;
            _has_digits : BOOL;
            _has_exponent : BOOL;
        END_VAR
        VAR CONSTANT
            MAX_LREAL : LREAL := LREAL#1.7976931348623157e+308;
            MIN_LREAL : LREAL := LREAL#-1.7976931348623157e+308;
            MAX_LREAL_STR : WSTRING := "1.7976931348623157e+308";
            MAX_LREAL_STR_PLUS : WSTRING := "+1.7976931348623157e+308";
            MIN_LREAL_STR : WSTRING := "-1.7976931348623157e+308";
        END_VAR
    
        // Reset flags
        _has_digits := FALSE;
        _has_exponent := FALSE;
        _is_exact_max := 
            (str = MAX_LREAL_STR) OR 
            (str = MAX_LREAL_STR_PLUS);
        
        _is_exact_min := (str = MIN_LREAL_STR);
    
        _len := TO_INT(LengthOf(str));
    
        // Handle sign
        IF (str[1] = "+") THEN
            _sig := 1;
            _start := 2;
        ELSIF (str[1] = "-") THEN
            _sig := -1;
            _start := 2;
        ELSE
            _sig := 1;
            _start := 1;
        END_IF;
    
        _whole_part := 0.0;
        _decimal_part := 0.0;
        _decimal_pos := 0;
        _exp_pos := 0;
        _exp_value := 0;
        _exp_sign := 1;
        _precision := 1.0;
    
        // Check for empty string or just a sign
        IF (_len - _start < 0) THEN
            WStringToAnyLReal := FALSE;
            RETURN;
        END_IF;
    
        // Parse string
        FOR i := _start TO _len DO
            _c := str[i];
            CASE _c OF
                "0": 
                    _val := 0.0;
                    _has_digits := TRUE;
                "1": 
                    _val := 1.0;
                    _has_digits := TRUE;
                "2": 
                    _val := 2.0;
                    _has_digits := TRUE;
                "3": 
                    _val := 3.0;
                    _has_digits := TRUE;
                "4": 
                    _val := 4.0;
                    _has_digits := TRUE;
                "5": 
                    _val := 5.0;
                    _has_digits := TRUE;
                "6": 
                    _val := 6.0;
                    _has_digits := TRUE;
                "7": 
                    _val := 7.0;
                    _has_digits := TRUE;
                "8": 
                    _val := 8.0;
                    _has_digits := TRUE;
                "9": 
                    _val := 9.0;
                    _has_digits := TRUE;
                ".":
                    IF (_decimal_pos = 0) AND (_exp_pos = 0) THEN
                        _decimal_pos := i;
                        CONTINUE;
                    ELSE
                        WStringToAnyLReal := FALSE;
                        RETURN;
                    END_IF;
                "E", "e":
                    IF (_exp_pos = 0) AND _has_digits THEN
                        _exp_pos := i;
                        _has_exponent := TRUE;
                        CONTINUE;
                    ELSE
                        WStringToAnyLReal := FALSE;
                        RETURN;
                    END_IF;
                "+":
                    IF (_exp_pos > 0) AND (i = _exp_pos + 1) THEN
                        _exp_sign := 1;
                        CONTINUE;
                    ELSE
                        WStringToAnyLReal := FALSE;
                        RETURN;
                    END_IF;
                "-":
                    IF (_exp_pos > 0) AND (i = _exp_pos + 1) THEN
                        _exp_sign := -1;
                        CONTINUE;
                    ELSE
                        WStringToAnyLReal := FALSE;
                        RETURN;
                    END_IF;
                ELSE
                    WStringToAnyLReal := FALSE;
                    RETURN;
            END_CASE;
    
            // Build whole part
            IF (_decimal_pos = 0) AND (_exp_pos = 0 OR i < _exp_pos) THEN
                _whole_part := _whole_part * 10.0 + _val;
            // Build decimal part
            ELSIF (_decimal_pos > 0) AND (_exp_pos = 0 OR i < _exp_pos) THEN
                _decimal_part := _decimal_part * 10.0 + _val;
                _precision := _precision * 0.1;
            // Build exponent
            ELSIF (_exp_pos > 0) THEN
                _exp_value := _exp_value * 10 + TO_DINT(_val);
            END_IF;
        END_FOR;
    
        // Check if we have an exponent but no digits after it
        IF _has_exponent THEN
            IF (_exp_pos = _len) OR // E is the last character
               ((_exp_pos + 1 = _len) AND (str[_len] = "+" OR str[_len] = "-")) OR // E+/E- at the end
               (_exp_value = 0 AND _exp_pos < _len) THEN // E followed by invalid characters
                WStringToAnyLReal := FALSE;
                RETURN;
            END_IF;
        END_IF;
    
        // Additional validation checks
        // Ensure there are digits before and/or after decimal point
        IF NOT _has_digits THEN
            WStringToAnyLReal := FALSE;
            RETURN;
        END_IF;
    
        // Combine whole and decimal parts
        value := _whole_part + (_decimal_part * _precision);
    
        // Handle exponent
        IF (_exp_pos > 0) THEN
            _val := 1.0;
            FOR i := 1 TO TO_INT(_exp_value) DO
                IF (_exp_sign = 1) THEN
                    _val := _val * 10.0;
                ELSE
                    _val := _val * 0.1;
                END_IF;
            END_FOR;
            
            value := value * _val;
        END_IF;
    
        // Apply sign
        value := value * TO_LREAL(_sig);
    
        // Special handling for exact maximum and minimum values
        IF _is_exact_max THEN
            value := MAX_LREAL;
        ELSIF _is_exact_min THEN
            value := MIN_LREAL;
        END_IF;
    
        // Check for out of range values
        IF (value < MIN_LREAL) OR (value > MAX_LREAL) THEN
            value := 0.0;
            WStringToAnyLReal := FALSE;
            RETURN;
        END_IF;
    
        WStringToAnyLReal := TRUE;
    END_FUNCTION
    
    
END_NAMESPACE