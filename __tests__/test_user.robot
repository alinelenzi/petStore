*** Setting ***
# Bibliotecas e Configurações
Library    RequestsLibrary


*** Variable ***
# Objetos, Atributos e Variables
${url}    https://petstore.swagger.io/v2/user

${id}    1404
${username}    alana_soares                             
${firstname}    Alana               
${lastname}     Soares                                 
${email}    alana@hotmail.com
${password}    1234
${phone}    27988008800
${userStatus}    1

*** Test Cases ***
# Descritivo de Negócio + Passos de Automação

Post user
# Montar a msg
    ${body}    Create Dictionary    id=${id}    username=${username}    firstname=${firstname}    lastname=${lastname}    email=${email}    password=${password}    phone=${phone}    userStatus=${userStatus}

#Executar
    ${response}    POST    url=${url}    json=${body}

#Validar
    ${response_body}    Set Variable    ${response.json()} 
    Log To Console    ${response_body}  

    Status Should Be    200
    Should Be Equal    ${response_body}[code]     ${{int(200)}}
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    ${{int($id)}}

Get user
#Executar
    ${response}    GET    ${{$url + '/' + $username}}

#Validar
    ${response_body}    Set Variable    ${response.json()} 
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}
    Should Be Equal    ${response_body}[username]    ${username}
    Should Be Equal    ${response_body}[firstname]    ${firstname}
    Should Be Equal    ${response_body}[lastname]    ${lastname}
    Should Be Equal    ${response_body}[email]    ${email}
    Should Be Equal    ${response_body}[password]    ${password}
    Should Be Equal    ${response_body}[phone]    ${phone}
    Should Be Equal    ${response_body}[userStatus]    ${{int($userStatus)}}

Put user
# Montar a msg
    ${body}    Evaluate    json.loads(open('./fixtures/json/user2.json').read())

#Executar
    ${response}    PUT    ${{$url + '/' + $username}}   json=${body}

#Validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]     ${{int(200)}}
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    ${username}

Delete user
# Montar a msg
    ${body}    Evaluate    json.loads(open('./fixtures/json/deleteUser.json').read())
#Executar
    ${response}    DELETE    ${{$url + '/' + $username}}

#Validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]     ${{int(200)}}
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    ${username}

*** Keywords ***
# Descritivo de Negócio (se estruturar separadamente)
# DSL - Domain Specific Language = Linguagem Especifica de Dominio
