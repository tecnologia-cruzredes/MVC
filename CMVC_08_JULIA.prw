#Include 'Protheus.ch'
#Include 'FWEditPanel.ch'
#INCLUDE 'FWMVCDEF.CH'


User Function CMVC_08()

	FWExecView("Titulo","CMVC_08",3,,{|| .T.})

Return

Static Function ModelDef()
	Local oModel
	Local oStr := getModelStruct()
		oModel := MPFormModel():New('MLDNOSXS',,,{|oModel| Commit(oModel) })
		oModel:SetDescription('Saque - Banco')
		
		oModel:AddFields("MASTER",,oStr,,,{|| Load() })
		oModel:getModel("MASTER"):SetDescription("DADOS")
		oModel:SetPrimaryKey({})
Return oModel

static function getModelStruct()
	Local oStruct := FWFormModelStruct():New()
		
		oStruct:AddField('100','100' , 'LOAD', 'BT', 10, 0, { |oMdl| getArq(oMdl), .T. }, , {}, .F., , .F., .F., .F., , )
		oStruct:AddField('50','50' , 'LOAD2', 'BT', 1, 0, { |oMdl| getDir(oMdl), .T. }, , {}, .F., , .F., .F., .F., , )
		oStruct:AddField('20','20' , 'LOAD3', 'BT', 1, 0, { |oMdl| getDir(oMdl), .T. }, , {}, .F., , .F., .F., .F., , )
		oStruct:AddField('10','10' , 'LOAD4', 'BT', 1, 0, { |oMdl| getDir(oMdl), .T. }, , {}, .F., , .F., .F., .F., , )
		oStruct:AddField('Insira o Valor Desejado','Insira o Valor Desejado' , 'LOAD5', 'C', 10, 0, , , {}, .F., , .F., .F., .F., , )

return oStruct

Static Function ViewDef()
	Local oView
	Local oModel := ModelDef() 
	Local oStr:= getViewStruct()
		oView := FWFormView():New()
		oView:SetModel(oModel)
		
		oView:AddField('FORM1' , oStr,'MASTER' ) 
		oView:CreateHorizontalBox( 'BOXFORM1', 100)
		oView:SetOwnerView('FORM1','BOXFORM1')
		oView:SetViewProperty('FORM1' , 'SETLAYOUT' , {FF_LAYOUT_VERT_DESCR_TOP,3} ) 
		oView:EnableTitleView('FORM1' , 'Notas Disponiveis para Saque' ) 
		
Return oView

static function getViewStruct()
	Local oStruct := FWFormViewStruct():New()

		oStruct:AddField( 'LOAD','2','100','100',, 'BT' ,,,,,,,,,,,, )
		oStruct:AddField( 'LOAD2','4','50','50',, 'BT' ,,,,,,,,,,,, )
		oStruct:AddField( 'LOAD3','5','20','20',, 'BT' ,,,,,,,,,,,, )
		oStruct:AddField( 'LOAD4','6','10','10',, 'BT' ,,,,,,,,,,,, )
		oStruct:AddField( 'LOAD5','7','Insira o Valor Desejado','Insira o valor desejado',, 'C' ,,,,,,,,,,,, )

return oStruct
