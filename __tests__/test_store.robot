*** Setting ***
# Bibliotecas e Configurações
Library    RequestsLibrary


*** Variable ***
# Objetos, Atributos e Variables
${url}    https://petstore.swagger.io/v2/store/order

${id}    1
${petId}    112092001                               
${quantity}    1             
${shipDate}      2024-06-18                              
${status}    placed
${complete}    true

*** Test Cases ***
# Descritivo de Negócio + Passos de Automação

Post store
# Montar a msg
    ${body}    Create Dictionary    id=${id}    petId=${petId}    quantity=${quantity}    shipDate=${shipDate}    status=${status}    complete=${complete}

#Executar
    ${response}    POST    url=${url}    json=${body}

#Validar
    ${response_body}    Set Variable    ${response.json()} 
    Log To Console    ${response_body}  

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}
    Should Be Equal    ${response_body}[petId]    ${{int($petId)}}
    Should Be Equal    ${response_body}[quantity]    ${{int($quantity)}}
    Should Be Equal    ${response_body}[status]    ${status}

Get store
#Executar
    ${response}    GET    ${{$url + '/' + $id}}

#Validar
    ${response_body}    Set Variable    ${response.json()} 
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}
    Should Be Equal    ${response_body}[petid]    ${{int($petid)}}
    Should Be Equal    ${response_body}[quantity]    ${{int($quantity)}}
    Should Be Equal    ${response_body}[status]    ${status}

Delete store
#Executar
    ${response}    DELETE    ${{$url + '/' + $id}}

#Validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]     ${{int(200)}}
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    ${id}

*** Keywords ***
# Descritivo de Negócio (se estruturar separadamente)
# DSL - Domain Specific Language = Linguagem Especifica de Dominio