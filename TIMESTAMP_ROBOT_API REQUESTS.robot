*** Settings ***
Library       Collections
Library       RequestsLibrary

*** Variables ***
${base_url}         https://timestamp-microservice.freecodecamp.rocks/api



*** Test Cases ***

Validate response time with string date "2015-12-25"
    ${date}      set variable    2015-12-25
    ${response}=  GET   ${base_url}/${date}
    log     ${response.json}
    log to console    ${response.content}
    ${status_code}=     convert to string    ${response.status_code}
    log to console  ${status_code}
    ${response_body}=   convert to string     ${response.content}
    should contain  ${response_body}        1451001600000
    should contain       ${response_body}         25 Dec 2015

Validate get response with empty request should return time and date at the moment
    ${response}=    GET     ${base_url}
    log to console  ${response.content}
    ${response_body}=   convert to string     ${response.content}
    ${status_code}=     convert to string    ${response.status_code}
    log to console  ${status_code}
    should contain      ${response_body}        GMT

Validate get request with a valid time "1451001600000"
    ${time}     set variable  1451001600000
    ${response}=    GET     ${base_url}/${time}
    log to console  ${response.content}
    ${response_body}=   convert to string     ${response.content}
    ${status_code}=     convert to string    ${response.status_code}
    log to console  ${status_code}
    should contain      ${response_body}       ${time}
    should contain      ${response_body}       Fri, 25 Dec 2015

Validate response with an invalid date "2030a-12-25"
    ${invalid_date}     set variable  2030a-12-25
    ${response}=    GET     ${base_url}/${invalid_date}
    log to console  ${response.content}
    ${response_body}=   convert to string     ${response.content}
    ${status_code}=     convert to string    ${response.status_code}
    log to console  ${status_code}
#    validation for invalid date message
    should contain      ${response_body}       Invalid Date

Validate response with an invalid time "1451001A600"
    ${invalid_time}     set variable    1451001A600
    ${response}=    GET     ${base_url}/${invalid_time}
    log to console  ${response.content}
    ${response_body}=   convert to string     ${response.content}
    ${status_code}=     convert to string    ${response.status_code}
    log to console  ${status_code}
    should contain      ${response_body}       Invalid Time

validate date with letters "2015 Dec 25"
    ${date}     set variable    2015 dec 25
    ${response}=    GET     ${base_url}/${date}
     log to console  ${response.content}
     ${status_code}=     convert to string    ${response.status_code}
    log to console  ${status_code}
    ${response_body}=   convert to string     ${response.content}
    should contain  ${response_body}        1451001600000
    should contain       ${response_body}         25 Dec 2015





















