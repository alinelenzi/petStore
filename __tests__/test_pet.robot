*** Setting ***
# Bibliotecas e Configurações
Library    RequestsLibrary


*** Variable ***
# Objetos, Atributos e Variables
${url}    https://petstore.swagger.io/v2/pet

${id}    112092001
${name}    Princesa                                # $ sinaliza uma variável simples
&{category}    id=1    name=dog                    # & sinaliza uma lista com campos fixos = {}
@{photoUrls}                                       # @ sinaliza uma lista com vários registros = []
&{tag}    id=1    name=vacinado
@{tags}    ${tag}
${status}    available

*** Test Cases ***
# Descritivo de Negócio + Passos de Automação

Post pet
# Montar a msg
    ${body}    Create Dictionary    id=${id}    category=${category}    name=${name}    photoUrls=${photoUrls}    tags=${tags}    status=${status}

#Executar
    ${response}    POST    url=${url}    json=${body}

#Validar
    ${response_body}    Set Variable    ${response.json()} 
    Log To Console    ${response_body}  

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}
    Should Be Equal    ${response_body}[name]    ${name}
    Should Be Equal    ${response_body}[category][id]    ${{int(${category}[id])}}
    Should Be Equal    ${response_body}[category][name]    ${category}[name]
    Should Be Equal    ${response_body}[tags][0][id]    ${{int(${tag}[id])}}
    Should Be Equal    ${response_body}[tags][0][name]    ${tag}[name]
    Should Be Equal    ${response_body}[status]    ${status}

Get pet
#Executar
    ${response}    GET    ${{$url + '/' + $id}}

#Validar
    ${response_body}    Set Variable    ${response.json()} 
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}
    Should Be Equal    ${response_body}[name]    ${name}
    Should Be Equal    ${response_body}[category][id]    ${{int(${category}[id])}}
    Should Be Equal    ${response_body}[category][name]    ${category}[name]
    Should Be Equal    ${response_body}[tags][0][id]    ${{int(${tag}[id])}}
    Should Be Equal    ${response_body}[tags][0][name]    ${tag}[name]
    Should Be Equal    ${response_body}[status]    ${status}

Put pet
# Montar a msg
    ${body}    Evaluate    json.loads(open('./fixtures/json/pet2.json').read())

#Executar
    ${response}    PUT    ${url}    json=${body}

#Validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]    ${{int($id)}}
    Should Be Equal    ${response_body}[name]    ${name}
    Should Be Equal    ${response_body}[category][id]    ${{int(${category}[id])}}
    Should Be Equal    ${response_body}[category][name]    ${category}[name]
    Should Be Equal    ${response_body}[tags][0][id]    ${{int(${tag}[id])}}
    Should Be Equal    ${response_body}[tags][0][name]    ${tag}[name]
    Should Be Equal    ${response_body}[status]    sold

Delete pet
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
