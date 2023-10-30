def test(response,x: int) :
    if not hasattr(test, "x"):
        test.x = 1

    if test.x == 1:
        type = "type not found"
        next_word = "total not found"
        test.x += 1

    elif test.x == 2:
        type = "Sri Lanka Telecom"
        next_word = "4468.19"
        test.x += 1

    elif test.x == 3:
        type = "Sri Lanka Telecom"
        next_word = "2202.00"
        test.x += 1

    elif test.x == 4:
        type = "type not found"
        next_word = "total not found"
        test.x+= 1
    else:
        type = "Sri Lanka Telecom"
        next_word = "2822.11"
        test.x+=1


    esponse["billType"] = type
    response["Value"] = next_word
    return response