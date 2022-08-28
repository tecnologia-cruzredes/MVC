#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE 'FWMVCDef.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} CAIXABANC
Exemplo de montagem de Caixa P/ Saque em MVC
@author Edinei Cuz
@since 13/07/2022
@version 1.0
/*/
//-------------------------------------------------------------------
User Function CAIXABANC()
Local oBrowse
oBrowse := FWMBrowse():New() //Instancia da classe do Browse
oBrowse:SetAlias('CXS')  // Browser da tabela
oBrowse:SetDescription('Caixa Saque Banco') // Titulo Pag.
oBrowse:Activate()  // Ativação da classe
Return NIL

//-------------------------------------------------------------------

// Definição de Botões
Static Function MenuDef()
Local aRotina := {}
ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.CAIXABANC' OPERATION 2 ACCESS 0
ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.CAIXABANC' OPERATION 3 ACCESS 0
ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.CAIXABANC' OPERATION 4 ACCESS 0
ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.CAIXABANC' OPERATION 5 ACCESS 0
ADD OPTION aRotina TITLE 'Imprimir'   ACTION 'VIEWDEF.CAIXABANC' OPERATION 8 ACCESS 0
ADD OPTION aRotina TITLE 'Copiar'     ACTION 'VIEWDEF.CAIXABANC' OPERATION 9 ACCESS 0
Return aRotina

//-------------------------------------------------------------------
Static Function ModelDef()
// Cria a estrutura a ser usada no Modelo de Dados
Local oModel
Local oStruCXS := FWFormStruct( 1,'CXS')

	oModel := MPFormModel():New('CAIXA_MODELO', /*BPRE*/, { |oModel| CAIXA_OK (oModel)}, /*BCOMIT*/, /* BCANCEL*/) //Validação em Bloco de código caixa ok
	oModel:SetDescription("Caixa Saque")

	oModel:addFields('FORMCAIXA', ,oStruCXS)
	oModel:SetPrimaryKey({'CX_COD'})
	oModel:getModel('')

Return oModel

//-------------------------------------------------------------------

Static Function ViewDef()

// Cria um objeto de Modelo de Dados baseado no ModelDef do fonte informado
Local oView
Local oModel   := FWLoadModel( 'CAIXABANC' )
Local oStruCXS := FWFormStruct( 2, 'CXS' )// Cria a estrutura a ser usada na View
oView := FWFormView():New() // Inicializa o objeto da view
oView:SetModel( oModel ) // Definição de qual modelo da View
oView:AddField( 'VIEW_CXS', oStruCXS, 'FORMCAIXA' )
oView:CreateHorizontalBox( 'TELA' , 80 ) // Criar um "box" horizontal para receber algum elemento da view
oView:SetOwnerView( 'VIEW_CXS', 'TELA' ) // Relaciona o ID da View com o "box" para exibicao
oView:EnableTitleView('VIEW_CXS', 'CAIXA PARA SAQUES') //Titulo Interno Tela

Return oView

PUBLISH USER MODEL REST NAME oModel SOURCE oModel



//------------------------------------------------------------------- Em desenvolvimento...
/*
Observsações pra desevolvimento;
1 - Persistência das notas disponíveis em caixa.
2 - Persistência de saque:
2.1 - Considerar que o usuário irá inserir o valor de saque e o sistema retornará a quantia de cada nota, de cada valor, que irá compôr o saque.
2.2 - Levar em consideração a quantia de notas disponíveis em caixa.
2.3 - Entregar o máximo de notas maiores possíveis para compôr o saque solicitado pelo usuário.

*/
/*
Static Function COMP011POS( oModel )
Local nOperation := oModel:GetOperation()
Local lRet       := .T.
If nOperation == MODEL_OPERATION_UPDATE
	If Empty( oModel:GetValue( 'CXSMASTER', 'CXS_DTAFAL' ) )
		Help( ,, 'HELP',, 'Informe a data', 1, 0)
		lRet := .F.
	EndIf
EndIf
Return lRet
Teste Git
*/

//-------------------------------------------------------------

