*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    os
Library    Collections

*** Variables ***
${base_url}     https://reqres.in/
${file_path}    ${CURDIR}/data.json

*** Test Cases ***
VerifyTheUserData
    [Documentation]    Validate the user's data from response
    [Tags]    smoke
    ${json_object}=     load json from file    ${file_path}
    ${url}=     get value from json     ${json_object}  $.TEST_DATA[0].RELATIVE_URL
    ${url}=     get value from json     ${json_object}  $.TEST_DATA[0].RELATIVE_URL
    ${status_code}=  get value from json     ${json_object}  $.TEST_DATA[0].RESPONSE_EXPECTED_STATUS
    FOR     ${relative_url}     IN  @{url}
       log  ${relative_url}
    END
    FOR    ${expected_status_code}   IN     @{status_code}
        log    ${expected_status_code}
    END
    create session    userlogin     ${base_url}
    ${response}=    get request    userlogin    ${relative_url}
    should be true    '${response.status_code}'=='${expected_status_code}'