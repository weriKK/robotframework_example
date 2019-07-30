*** Settings ***
Documentation   Testing RESTful APIs using schemas for response validation
Library  REST  http://localhost:8080


*** Variables ***
${bodyText}=    These values dont change!
${bodyNumber}=  42
${bodyBool}=    true


*** Test Cases ***
Get Request - Fix
    [Documentation]  Sending a GET request to /hellofix endpoint.
    ...              This endpoint always sends back the exact same
    ...              response body, no matter how many times you send
    ...              a GET request to it.

    GET         /hellofix

    Response Status Should Be           200
    Content Type Should Be              application/json

    String      response body Text      ${bodyText}
    Integer     response body Number    ${bodyNumber}
    Boolean     response body Bool      ${bodyBool}

    [Teardown]  Output  response


Get Request - Random
    [Documentation]  Sending a GET request to /hellorandom endpoint
    ...              This endpoint always sends back a response body
    ...              with different 'Number' and 'Bool' values.
    ...              Because the JSON schema itself never changes,
    ...              only the values, we can validate the response
    ...              using a JSON schema. 

    [Setup]  Expect Response  ${CURDIR}/hellorandom_schema.json

    GET     /hellorandom

    Response Status Should Be           200
    Content Type Should Be              application/json

    Output  response

    [Teardown]  Clear Expectations




*** Keywords ***
Response Status Should Be
    [Arguments]  ${statusCode}
    Integer     response status     ${statusCode}

Content Type Should Be
    [Arguments]  ${contentType}
    String      response headers Content-Type   ${contentType}