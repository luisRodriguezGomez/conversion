USING System.Strings;
USING System.Math;
USING System.Conversion;

NAMESPACE Simatic.Ax.Conversion.Float
    FUNCTION LRealToWString : BOOL
        VAR_INPUT
            value : LREAL;
        END_VAR
        VAR_OUTPUT
            str : WSTRING;
        END_VAR
        VAR_TEMP
            _value : LREAL;
            _whole_part : LINT;
            _decimal_part : LREAL;
            _is_negative : BOOL;
            _temp_str : ARRAY[0..255] OF WCHAR;
            _digits : INT;
            _max_precision : INT := 15;
            _i, _j, _k : INT;
            _current_digit : LINT;
            _exponent_multiplier : INT;
            _temp_exponent_multiplier : INT;
            _decimal_check : LREAL;
            _normalized_value : LREAL;
            _temp : LREAL;
        END_VAR
        VAR CONSTANT
            MAX_LREAL : LREAL := LREAL#1.7976931348623157e+308;
            MIN_LREAL : LREAL := LREAL#-1.7976931348623157e+308;
            EPSILON : LREAL := 1.0E-10;
        END_VAR
    
        // Check for out of range values first
        IF (value < MIN_LREAL) OR (value > MAX_LREAL) OR NOT IsValid(value) THEN
            LRealToWString := FALSE;
            str := WSTRING#""; 
            RETURN;
        END_IF;
    
        // For very large numbers or very small numbers (scientific notation)
        IF ABS(value) >= 1.0E16  THEN
            // Initialize variables
            _is_negative := value < 0.0;
            _decimal_part := ABS(value);
            _digits := 0;
            _exponent_multiplier := 0;
            
            // Handle sign
            IF _is_negative THEN
                _temp_str[0] := WCHAR#'-';
                _digits := 1;
            END_IF;
            
            _exponent_multiplier := TO_INT(FLOOR(Log10(_decimal_part) / Log10(10.0)));
            

            // Get normalized value between 1 and 10
            _normalized_value := _decimal_part / (10.0 ** _exponent_multiplier);            

            // Ensure value is in range [1,10)
            IF _normalized_value >= 10.0 THEN
                _normalized_value := _normalized_value / 10.0;
                _exponent_multiplier := _exponent_multiplier + 1;
            END_IF;

                        
            // Get first digit directly from original value
            _current_digit := TO_LINT(Trunc(_normalized_value));
            _decimal_part := Round( (Trunc(_normalized_value))  * (10.0**(29)));
            // Store first digit
            _temp_str[_digits] := TO_WCHAR(TO_CHAR(TO_BYTE(_current_digit + 48)));
            _digits := _digits + 1;
            
            // Add decimal point
            _temp_str[_digits] := WCHAR#'.';
            _digits := _digits + 1;
            
            // // Extract remaining digits using modulo operations
            // _decimal_part := _decimal_part - (TO_LREAL(_current_digit)  * (10.0 ** (_exponent_multiplier)));

            // With:
            _normalized_value := (_normalized_value - FLOOR(_normalized_value)) * 10;
            _temp_exponent_multiplier := _exponent_multiplier;

            // _decimal_part := _decimal_part / (10.0**(_temp_exponent_multiplier));
            // _decimal_part := _decimal_part * 10;
            // // Extract remaining digits using modulo operations
            // _decimal_part := _decimal_part - (TO_LREAL(_current_digit)  * (10.0**(TO_INT(FLOOR(Log10(_decimal_part) / Log10(10.0))))));
            
            
           


           
            FOR _i := 0 TO 15 DO

                _temp := 1;
                _temp := _temp * (10.0**(29));

                // If the rest of the number is all 9 finish writing string and round up last digit
                IF (_temp < EPSILON ) THEN
                    // Round up current digit and exit
                    // _current_digit := _current_digit + 1;
                    // _temp_str[_digits] := TO_WCHAR(TO_CHAR(TO_BYTE(_current_digit MOD 10 + 48)));
                    // _digits := _digits + 1;
                    EXIT;
                END_IF;
                
                // Get current digit
                _current_digit := TO_LINT(Trunc(_normalized_value));                
                _temp_str[_digits] := TO_WCHAR(TO_CHAR(TO_BYTE(_current_digit MOD 10 + 48)));
                _digits := _digits + 1;                
                // _decimal_part := _decimal_part - (TO_LREAL(_current_digit) * _normalized_value);
                _normalized_value := (_normalized_value - Trunc(_normalized_value)) * 10;
                _temp_exponent_multiplier := _temp_exponent_multiplier -1;

                // _decimal_part := _decimal_part * 10;
                // // Extract remaining digits using modulo operations
                // _decimal_part := _decimal_part - (TO_LREAL(_current_digit)  * (10.0 ** (TO_INT(FLOOR(Log10(_decimal_part) / Log10(10.0))))));
                _decimal_part := Round(_decimal_part + (TO_LREAL(_current_digit)  * (10.0**(_temp_exponent_multiplier))));
            END_FOR;
            
            // Add exponent
            _temp_str[_digits] := WCHAR#'E';
            _digits := _digits + 1;
            _temp_str[_digits] := WCHAR#'+';
            _digits := _digits + 1;
            
            // Handle exponent digits safely
            _j := _exponent_multiplier;
            _k := _digits;
            
            // Convert exponent to string in correct order
            IF _j = 0 THEN
                _temp_str[_k] := WCHAR#'0';
                _k := _k + 1;
            ELSE
                // First count number of digits in exponent
                _normalized_value := TO_LREAL(_j);
                _i := 0;
                WHILE _normalized_value >= 1.0 DO
                    _normalized_value := _normalized_value / 10.0;
                    _i := _i + 1;
                END_WHILE;
                
                // Now extract digits left to right
                _normalized_value := TO_LREAL(_j);
                WHILE _i > 0 DO
                    _current_digit := TO_LINT(TRUNC(_normalized_value / (10.0 ** (_i - 1))));
                    _temp_str[_k] := TO_WCHAR(TO_CHAR(TO_BYTE(_current_digit MOD 10 + 48)));
                    _normalized_value := FMOD(_normalized_value, (10.0 ** (_i - 1)));
                    _k := _k + 1;
                    _i := _i - 1;
                END_WHILE;
            END_IF;
            
            _digits := _k;
        ELSE
            // Store input value in temporary variable
            _value := value;
        
            // Special case for zero
            IF _value = 0.0 THEN
                str := WSTRING#"0";
                LRealToWString := TRUE;
                RETURN;
            END_IF;
        
            // Handle sign
            _is_negative := _value < 0.0;
            IF _is_negative THEN
                _value := -_value;
            END_IF;
        
            // Convert whole part
            _whole_part := TO_LINT(TRUNC(_value));
            _digits := 0;
        
            // Initialize string with negative sign if needed
            IF _is_negative THEN
                _temp_str[0] := WCHAR#'-';
                _digits := 1;
            END_IF;
        
            // Handle whole part digits
            IF _whole_part = 0 THEN
                _temp_str[_digits] := TO_WCHAR(TO_CHAR(TO_BYTE(48))); // Add '0'
                _digits := _digits + 1;
            ELSE
                // Store digits in temporary array in correct order
                _i := _digits; // Start after sign if present
                _j := _digits; // Keep track of start position
                WHILE _whole_part > 0 DO
                    _current_digit := _whole_part MOD 10;
                    _temp_str[_i] := TO_WCHAR(TO_CHAR(TO_BYTE(_current_digit + 48)));
                    _whole_part := _whole_part / 10;
                    _i := _i + 1;
                END_WHILE;
                
                // Reverse the digits to get correct order
                _k := _i - 1; // End position
                WHILE _j < _k DO
                    _temp_str[255] := _temp_str[_j];
                    _temp_str[_j] := _temp_str[_k];
                    _temp_str[_k] := _temp_str[255];
                    _j := _j + 1;
                    _k := _k - 1;
                END_WHILE;
                _digits := _i;
            END_IF;        
        
            // Calculate decimal part and check if it exists
            _decimal_part := ABS(_value - TRUNC((_value)));
            _decimal_check := _decimal_part;
            _exponent_multiplier := 0;
    
            // Only process decimals if they exist
            IF _decimal_part > EPSILON THEN
                // Count leading zeros first
                WHILE (_decimal_check < 0.1) AND (_exponent_multiplier < _max_precision) DO
                    _decimal_check := _decimal_check * 10.0;
                    _exponent_multiplier := _exponent_multiplier + 1;
                END_WHILE;
    
                // Reset decimal check for digit counting
                _decimal_check := _decimal_part;
    
                // First pass: determine remaining precision
                WHILE (_exponent_multiplier < _max_precision) DO
                    _decimal_check := _decimal_check * (10.0 ** (_exponent_multiplier + 1));
                    _current_digit := TO_LINT(_decimal_check) MOD 10;
                    
                    IF (_current_digit <> 0) OR (_exponent_multiplier > 0) THEN
                        _exponent_multiplier := _exponent_multiplier + 1;
                    END_IF;
                    
                    IF ABS(_decimal_check - TO_LREAL(TO_LINT(_decimal_check))) < EPSILON THEN
                        EXIT;
                    END_IF;
                    
                    _decimal_check := _decimal_part;
                END_WHILE;
            ELSE
                _exponent_multiplier := 0;
            END_IF;
    
            // Process decimal digits
            IF _exponent_multiplier > 0 THEN
                _temp_str[_digits] := WCHAR#'.';
                _digits := _digits + 1;
                
                // Store decimal digits as integer without rounding
                _normalized_value := _decimal_part * (10.0 ** _exponent_multiplier);
                _decimal_check := _normalized_value;
                
                // Extract each digit one at a time
                FOR _i := 0 TO _exponent_multiplier - 1 DO
                    // Get digit using floor division equivalent
                    _normalized_value := 10.0 ** (_exponent_multiplier - 1 - _i);
                    _current_digit := TO_LINT((_decimal_check - FMOD(_decimal_check, _normalized_value)) / _normalized_value);
                    
                    // For last digit, check if we need to round up
                    IF _i = _exponent_multiplier - 1 THEN
                        // Get remaining decimal part
                        _decimal_check := _decimal_check - (TO_LREAL(_current_digit) * _normalized_value);
                        // Round up if remaining part >= 0.5
                        IF _decimal_check >= (_normalized_value / 2.0) THEN
                            _current_digit := _current_digit + 1;
                        END_IF;
                    ELSE
                        _decimal_check := _decimal_check - (TO_LREAL(_current_digit) * _normalized_value);
                    END_IF;
                    
                    // Store digit as character
                    _temp_str[_digits + _i] := TO_WCHAR(TO_CHAR(TO_BYTE(_current_digit MOD 10 + 48)));
                END_FOR;
                
                _digits := _digits + _exponent_multiplier;
            END_IF;
        END_IF;
    
        // Initialize output string
        str := WSTRING#""; 
    
        // Build final string
        FOR _i := 0 TO _digits - 1 DO
            str := CONCAT(str, _temp_str[_i]);
        END_FOR;
    
        LRealToWString := TRUE;
    END_FUNCTION
        
   
    FUNCTION ToString : BOOL
        VAR_INPUT
            value : REAL;
        END_VAR
        VAR_OUTPUT
            str : STRING;
        END_VAR
        VAR_TEMP
            _val : LREAL;
            _str : WSTRING;
        END_VAR
        VAR CONSTANT
            MAX_REAL : LREAL := LREAL#3.402823e+38;
            MIN_REAL : LREAL := LREAL#-3.402823e+38;
        END_VAR
        
        _val := TO_LREAL(value);
        
        ToString := LRealToWString(value := _val, str => _str);
        
        IF (_val < MIN_REAL) OR (_val > MAX_REAL) THEN
            str := '';
            ToString := FALSE;
        ELSE            
            ToString := Strings.ToString( _str, str);
        END_IF;

    END_FUNCTION

    FUNCTION ToString : BOOL
        VAR_INPUT
            value : REAL;
        END_VAR
        VAR_OUTPUT
            str : WSTRING;
        END_VAR
        VAR_TEMP
            _val : LREAL;
        END_VAR
        VAR CONSTANT
            MAX_REAL : LREAL := LREAL#3.402823e+38;
            MIN_REAL : LREAL := LREAL#-3.402823e+38;
        END_VAR
    
        _val := TO_LREAL(value);
    
        ToString := LRealToWString(value := _val, str => str);
    
        IF (_val < MIN_REAL) OR (_val > MAX_REAL) THEN
            str := "";
            ToString := FALSE;
        ELSE
            ToString := TRUE;
        END_IF;
    END_FUNCTION
    
    FUNCTION ToString : BOOL
        VAR_INPUT
            value : LREAL;
        END_VAR
        VAR_OUTPUT
            str : STRING;
        END_VAR
        VAR_TEMP
            _str : WSTRING;
        END_VAR
        VAR CONSTANT
            MAX_LREAL : LREAL := LREAL#1.7976931348623157e+308;
            MIN_LREAL : LREAL := LREAL#-1.7976931348623157e+308;
        END_VAR
    
        ToString := LRealToWString(value := value, str => _str);
    
        IF (value < MIN_LREAL) OR (value > MAX_LREAL) THEN
            str := '';
            ToString := FALSE;
        ELSE
            ToString:= Strings.ToString(_str, str);
        END_IF;
    END_FUNCTION
    
    FUNCTION ToString : BOOL
        VAR_INPUT
            value : LREAL;
        END_VAR
        VAR_OUTPUT
            str : WSTRING;
        END_VAR
        VAR CONSTANT
            MAX_LREAL : LREAL := LREAL#1.7976931348623157e+308;
            MIN_LREAL : LREAL := LREAL#-1.7976931348623157e+308;
        END_VAR
    
        ToString:= LRealToWString(value := value, str => str);
    
        IF (value < MIN_LREAL) OR (value > MAX_LREAL) THEN
            str := "";
            ToString := FALSE;
        ELSE
            ToString := TRUE;
        END_IF;
    END_FUNCTION    
END_NAMESPACE