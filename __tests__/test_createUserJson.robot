*** Setting ***
# Bibliotecas e Configurações
Library    RequestsLibrary
Library    DataDriver    ./fixtures/csv/postUser.csv    dialect=excel
Test Template    Post user

*** Variable ***
# Objetos, Atributos e Variables
${url}    https://petstore.swagger.io/v2/user
*** Test Cases ***
TC001    ${id}    ${username}    ${firstname}    ${lastname}    ${email}    ${password}    ${phone}    ${userStatus}

*** Keywords ***
Post user
# Montar a msg
    [Arguments]    ${id}    ${username}    ${firstname}    ${lastname}    ${email}    ${password}    ${phone}    ${userStatus}
    ${body}    Create Dictionary    id=${id}    username=${username}    firstname=${firstname}    lastname=${lastname}    email=${email}    password=${password}    phone=${phone}    userStatus=${userStatus}  

#Executar
    ${response}    POST    url=${url}    json=${body}

#Validar
    ${response_body}    Set Variable    ${response.json()} 
    Log To Console    ${response_body}  

    Status Should Be    200
    Should Be Equal    ${response_body}[code]     ${{int(200)}}
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    ${id}


