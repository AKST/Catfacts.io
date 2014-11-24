
@IsValid =
  phone-number: do
    valid-char = (in '0123456789+ ')
    (phone-number) ->
      return false unless phone-number[0] is '+'
      return false unless phone-number.length > 8
      return false unless _.all phone-number, valid-char
      return true

@WhenValid =
  phone-number: (fn) ->
    (phone-number) ->
      if IsValid.phone-number phone-number
        return fn phone-number
      else 
        new Error "invalid phone number" 



