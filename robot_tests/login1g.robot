*** Settings ***
Library    SeleniumLibrary
Library    Collections

Suite Teardown    Close All Browsers

*** Variables ***
${URL}                 https://eproc1g-dsv-custas.tjmg.jus.br/eproc/
${BROWSER}             chrome
${USUARIO}             p0167929
${SENHA}               C1r11@21949mae
${AMBIENTE_ESPERADO}   HOMOLOGAÇÃO
${CIDADE}              Belo Horizonte 
${NOME_AUTOR1}         Rafael Martins
${NOME_AUTOR2}         Mario Martins
${NOME_REU}            Juliana Moreira
${ARQUIVO_PETICAO}     ${CURDIR}${/}TestePetição.pdf

*** Keywords ***
Abrir Site Eproc1g
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    id=txtUsuario    15s

Validar Ambiente Homologacao
    Wait Until Element Is Visible    id=divAmbiente    15s
    Element Should Be Visible        id=divAmbiente
    Element Should Contain           id=divAmbiente    ${AMBIENTE_ESPERADO}
    Page Should Contain              ${AMBIENTE_ESPERADO}

Informar Usuario E Senha
    Wait Until Element Is Visible    id=txtUsuario    10s
    Input Text                       id=txtUsuario    ${USUARIO}
    Wait Until Element Is Visible    id=pwdSenha    10s
    Input Text                       id=pwdSenha    ${SENHA}

Clicar No Botao Entrar
    Wait Until Element Is Visible    id=sbmEntrar    10s
    Click Button                     id=sbmEntrar

Escolher Perfil Advogado
    Wait Until Page Contains         Seleção de perfil    20s
    Wait Until Element Is Visible    xpath=//*[@id="tr1"]/div[1]    20s
    Click Element                    xpath=//*[@id="tr1"]/div[1]


Escolher menu Petição inicial
    Wait Until Element Is Visible    xpath=//*[@id="main-menu"]/li[10]/a/span[1]    10s
    Click Element                    xpath=//*[@id="main-menu"]/li[10]/a/span[1]


Selecionar Localidade Judicial
    Wait Until Page Contains Element         id=selLocalidadeJudicial    15s
    Select From List By Value                id=selLocalidadeJudicial    185

    ${cidade}=    Get Selected List Label    id=selLocalidadeJudicial
    Should Be Equal    ${cidade}             Belo Horizonte


Selecionar Rito Juizo Comum
    Wait Until Page Contains Element         id=selRitoProcesso                   timeout=20s
    Wait Until Element Contains              id=selRitoProcesso    JUÍZO COMUM    timeout=20s
    Select From List By Label                id=selRitoProcesso    JUÍZO COMUM

    ${rito}=    Get Selected List Label      id=selRitoProcesso
    Should Be Equal    ${rito}               JUÍZO COMUM

Verificar Opcao Juizo Comum
    Wait Until Element Contains              id=selRitoProcesso    JUÍZO COMUM    20s
    ${opcoes}=    Get List Items              id=selRitoProcesso
    List Should Contain Value    ${opcoes}    JUÍZO COMUM


Selecionar Area
    Wait Until Page Contains Element          id=selIdGrupoCompetencia            15s
    Select From List By Value                 id=selIdGrupoCompetencia    0

    ${area}=    Get Selected List Label       id=selIdGrupoCompetencia
    Should Be Equal    ${area}                Cível

Selecionar Classe Processual
    Wait Until Page Contains Element                    id=selIdClasseJudicial    15s
    Wait Until Element Contains                         id=selIdClasseJudicial    COBRANÇA    timeout=20s
    Select From List By Label                           id=selIdClasseJudicial    COBRANÇA DE CÉDULA DE CRÉDITO INDUSTRIAL
    ${classe_processual}=    Get Selected List Label    id=selIdClasseJudicial
    Should Be Equal    ${classe_processual}             COBRANÇA DE CÉDULA DE CRÉDITO INDUSTRIAL

Inserir Nivel Sigilo Processual
    Wait Until Page Contains Element                    id=selIdSigilo    15s
    Select From List By Label                           id=selIdSigilo    Sem Sigilo (Nível 0)
    ${nivel_sigilo}=    Get Selected List Label         id=selIdSigilo
    Should Be Equal    ${nivel_sigilo}                  Sem Sigilo (Nível 0)

Inserir valor Causa
    Wait Until Page Contains Element                    id=txtValorCausa    timeout=15s
    Scroll Element Into View                            id=txtValorCausa
    Sleep    1s
    Input Text                                          id=txtValorCausa    200.000,00
    ${valor}=    Get Value                              id=txtValorCausa
    Should Not Be Empty    ${valor}

Clicar no Botão Próxima
    Wait Until Page Contains Element                    id=btnSalvar    timeout=20s
    Scroll Element Into View                            id=btnSalvar
    Sleep                                               1s
    Click Element                                       id=btnSalvar

Selecionar Assunto Principal
    Wait Until Page Contains Element                    xpath=//span[text()='DIREITO CIVIL']    timeout=20s
    Click Element                                       xpath=//span[text()='DIREITO CIVIL']
    Wait Until Page Contains Element                    xpath=//span[text()='Direitos da Personalidade']    timeout=20s
    Click Element                                       xpath=//span[text()='Direitos da Personalidade']

Clicar Botao Incluir Assunto
    Wait Until Page Contains Element                    id=btnIncluirAssunto    timeout=15s
    Click Element                                       id=btnIncluirAssunto

Clicar Botao Proxima Etapa 2
    Wait Until Page Contains Element                    id=sbmProcessoEtapa2    timeout=20s
    Scroll Element Into View                            id=sbmProcessoEtapa2
    Sleep                                               1s
    Click Element                                       id=sbmProcessoEtapa2

Inserir Nome Parte
    Wait Until Element Is Visible                       id=txtNome    timeout=20s
    Input Text                                          id=txtNome   ${NOME_AUTOR1}

Clicar Botao Consultar Nome
    Wait Until Page Contains Element                    id=btnConsultarNome    timeout=15s
    Click Element                                       id=btnConsultarNome     
    Sleep   1s

Clicar Botao Incluir Parte
    Wait Until Page Contains Element                    id=btnIncluir    timeout=15s
    Click Element                                       id=btnIncluir

Inserir Nome Parte 2
    Wait Until Element Is Visible                       id=txtNome    timeout=20s
    Input Text                                          id=txtNome    ${NOME_AUTOR2}  

Clicar Botao Consultar Nome 2
    Wait Until Page Contains Element                    id=btnConsultarNome    timeout=15s
    Click Element                                       id=btnConsultarNome
    Sleep   1s

Clicar Botao Incluir Parte 2
    Wait Until Page Contains Element                    id=btnIncluir    timeout=15s
    Click Element                                       id=btnIncluir
    Click Element                                       id=btnProxima
    Sleep   1s

Inserir Nome Reu 
    Wait Until Page Contains                            Partes ( Réus )    timeout=20s
    Wait Until Element Is Visible                       id=txtNome    timeout=20s
    Input Text                                          id=txtNome    ${NOME_REU}  

Clicar Botao Consultar Reu
    Wait Until Page Contains Element                    id=btnConsultarNome    timeout=15s
    Click Element                                       id=btnConsultarNome
    Sleep   1s

Clicar Botao Incluir Reu
    Wait Until Page Contains Element                    id=btnIncluir    timeout=15s
    Click Element                                       id=btnIncluir
    Click Element                                       id=btnProxima
    Sleep   1s

Fazer Upload Peticao
    Wait Until Page Contains                            Documentos    timeout=20s
    Wait Until Page Contains Element                    xpath=//input[@type='file' and @name='file']    timeout=20s
    Choose File                                         xpath=//input[@type='file' and @name='file']    ${ARQUIVO_PETICAO}
    Sleep   1s



Selecionar Tipo Peticao Inicial
    Wait Until Page Contains Element                    id=txtTipo_1    timeout=30s
    Scroll Element Into View                            id=txtTipo_1
    Click Element                                       id=txtTipo_1
    Input Text                                          id=txtTipo_1    Petição Inicial
    Sleep   1s
    ${clicou}=    Run Keyword And Return Status
    ...    Click Element                                xpath=(//li[contains(.,'Petição Inicial') and not(contains(.,'Outras'))] | //a[contains(text(),'Petição Inicial') and not(contains(text(),'Outras'))])[1]
    IF    not ${clicou}
           Press Keys                                   id=txtTipo_1    ARROW_DOWN
           Sleep         500ms
           Press Keys                                   id=txtTipo_1    ENTER
    END
    Sleep   10s

Clicar Confirmar Selecao Documentos
    Wait Until Page Contains Element                    id=btnEnviarArquivos    timeout=15s
    Scroll Element Into View                            id=btnEnviarArquivos
    Click Element                                       id=btnEnviarArquivos
    Sleep   10s

Clicar Botao Finalizar
    Wait Until Page Contains Element                    xpath=(//button[@name='sbmProcessoEtapa4' and text()='Finalizar'])[1]    timeout=20s
    Scroll Element Into View                            xpath=(//button[@name='sbmProcessoEtapa4' and text()='Finalizar'])[1]
    Click Element                                       xpath=(//button[@name='sbmProcessoEtapa4' and text()='Finalizar'])[1]
    ${alerta}=    Run Keyword And Return Status         Handle Alert    action=ACCEPT    timeout=5s
    Sleep   12s



Confirmar Ajuizamento
    Wait Until Page Contains Element                    xpath=(//iframe)[last()]    timeout=20s
    Select Frame                                        xpath=(//iframe)[last()]
    Wait Until Element Is Visible                       id=sbmConfirmar    timeout=20s
    Scroll Element Into View                            id=sbmConfirmar
    Click Element                                       id=sbmConfirmar
    Unselect Frame



*** Test Cases ***
Cenário 1: Acessar o site Eproc1g, autenticar e validar HOMOLOGAÇÃO
    Abrir Site Eproc1g
    Validar Ambiente Homologacao
    Informar Usuario E Senha
    Clicar No Botao Entrar
    Validar Ambiente Homologacao
    Escolher Perfil Advogado
    Escolher menu Petição inicial
    Selecionar Localidade Judicial
    Selecionar Rito Juizo Comum
    Verificar Opcao Juizo Comum
    Selecionar Area
    Selecionar Classe Processual
    Inserir Nivel Sigilo Processual
    Inserir valor Causa
    Clicar no Botão Próxima
    Selecionar Assunto Principal
    Clicar Botao Incluir Assunto
    Clicar Botao Proxima Etapa 2
    Inserir Nome Parte
    Clicar Botao Consultar Nome
    Clicar Botao Incluir Parte
    Inserir Nome Parte 2
    Clicar Botao Consultar Nome 2
    Clicar Botao Incluir Parte 2
    Inserir Nome Reu 
    Clicar Botao Consultar Reu
    Clicar Botao Incluir Reu
    Fazer Upload Peticao
    Selecionar Tipo Peticao Inicial
    Clicar Confirmar Selecao Documentos
    Clicar Botao Finalizar
    Confirmar Ajuizamento
    Sleep    10s
