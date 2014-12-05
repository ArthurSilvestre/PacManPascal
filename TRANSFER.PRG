******************************************************
* Transferencias e Consignaçoes - de SAIDAS
* Processamento / C.Transferência / A. Preparar
******************************************************
#include "fivewin.ch"
#include "tsbutton.ch"
#include "report.ch"
#include "corget.ch"
#include "dtpicker.ch"
#include "xbrowse.ch"
#include "ribbon.ch"
#include "folder.ch"
#DEFINE CLR_SKY    NRGB( 202, 228, 255 )
#DEFINE CLR_AZUL_BRANCO NRGB( 040, 004, 090 )
																						 
#Define K_ALT_F5  -34
#Define CLR_LGRAY nRGB( 230, 230, 230 )
#Define CLR_LGREEN nRGB( 190, 215, 190 )
#Define CLR_VERMELHO  nRGB( 255, 000, 000 ) //--> Vermelho Para a Letra
#Define CLR_AMARELO   nRGB( 255, 255, 000 ) //--> Amarelo Para o Fundo
*
STATIC lSaveIf,lcancel
STATIC tcredito,trecechq,treceber,vlimite,saldocc

Function Transfer1()
   Local oLbx,obar2,Lsave:=.f.,lBota1Obmp := .t.,lBota2Obmp := .t.,lBota3Obmp := .t.,lBota4Obmp := .t.
   Local oDlgConsu
         
   Public oFont1,oFont2,oFontbotao,tOrdem:="Nome",oDlg,tabeata:=.f.,lvalidcli:=.T.
   Public tOrdens := {"Nº Descendente","Nome Cliente","Data Venda","Nº Orçamento","Nome Fantasia"}
   lcancel=.f.

   If ! Permitir2("Trs00")
      Return .t.
   Endif
	
   Acemod("Preparação Transferência")
	
   PARA VTIPOTRA,vnumetra1
	
	
   sele emp
   if !empty(emp->ativtra)
      sele cli
      set filter to codiati=emp->ativtra
      go top
   endif
   *
   *
   *
   *
   while .t.
      *
      ***************************************
      * Fontes da Transferencia para Usar   *
      ***************************************
      Define Font oFon1 Name      "Arial"
      Define Font oFon2 Name      "Times New Roman"
      Define Font oFonv Name      "Times New Roman" bold
      Define Font oFontBotao Name "Times New Roman" Size 0,-11
      Define Font oFontVIS Name   "Courier New"     Size 13,17 Bold
      Define Font oFontG Name     "Britanic Bold"   Bold
      *
      *******************************
      * Variaveis de Transferência  *
      *******************************
      *
      Priv otamanho,vtamanho
      Priv onumetra,vnumetra  && Numero de Transferencia
      Priv onomecli,vnomecli  && Nome do Cliente
      Priv ocodifun,vcodifun
      Priv onomefun,vnomefun
      *
      Priv ocodicli,vcodicli
      Priv ocodiven,vcodiven
      Priv onomeven,vnomeven
      Priv ocodipla,vcodipla
      *
      Priv odatatra,vdatatra
      *
      Priv oordemit,vordemit
      *
      Priv ototalbr,vtotalbr
      Priv ototalnf,vtotalnf
      Priv odescont,vdescont
      Priv oitensnf,vitensnf
      Priv oquantid,vquantid
      Priv ocondica,vcondica
      Priv odados1a,vdados1a
      Priv odados2a,vdados2a
      Priv odados3a,vdados3a
      Priv odadps4a,vdados4a
      Priv odados5a,vdados5a
      Priv odados100a,vatencao
      Priv odados101a,vsetores
      Priv odados102a,vpacient
      Priv odados103a,vmedicos
      Priv odados104a,vconveni
      Priv odados105a,vhospita
      Priv odados106a,vdatacir
      Priv odados107a,vinstrum
      *
      sele inft
      *
      if Empty(vnumetra1)
         vtamanho:=len(numetra)
         vnumetra:=space(vtamanho)
      else
         vnumetra:=vnumetra1
      endif
      vcodicli:=space(len(codicli))
      vcodifun:=space(len(codifun))
      vnomefun:=space(40)
      vnomecli:=space(len(nomecli))
      *
      item=space(1)
      *
      vdatatra=dat_hoje
      *
      vtotalnf:=0.00
      vtotalbr:=0.00
      vcodiven:=space(len(codiven))
      vngerfis:=space(1)
      vdescont:=0.00
      *
      vsituacao:=space(1)
      vdescont:=0
      *
      vitensnf:=0.00
      vaplic:=0
      *
      vdados1a:=space(len(dados1a))
      vdados2a:=space(len(dados2a))
      vdados3a:=space(len(dados3a))
      vdados4a:=space(len(dados4a))
      vdados5a:=space(len(dados5a))
      *
      vtransfe:=space(len(transfe))
	   
      * incluido em 06/05/2010
	
      vatencao := space(len(atencao))
      vsetores := space(len(setores))
      vpacient := space(len(pacient))
      vmedicos := space(len(medicos))
      vconveni := space(len(conveni))
      vhospita := space(len(hospita))
      vdatacir := ctod("")
      vinstrum := space(len(instrum))
      *
      tcredito    := 0
      trecechq    := 0
      treceber    := 0
      vlimite     := 0
      saldocc     := 0
      lcancel     := .F.
      *
      * Janela Principal da Transferencia - Saida
      *
  
      altera:=.f.
      *
      vtext:=  "Nº Consignação..:"
      vtext2:= "Nº Transferência:"
      vtext3:= ""
      vtext4:= "TOTAL TRANSF.:"
      vtext5:= "Cód. Funcionário"
      *
      sele itra
      set order to 1
      set filter to numetra=vnumetra
      go top

      Define Font oFontBotao Name "Times New Roman" Size 0,-11
      Define Font oFon3 Name "LUCIDA CONSOLE" size 0,20
      Define Font oFon4 Name "LUCIDA CONSOLE " size 0,-12
      Define Font oFon5 Name "Times New Roman" size 0,-20 bold
      DEFINE FONT oGetFnt    NAME "Lucida Console"  SIZE 0,-15
      *
      If vtipotra = "C"  // consignação
         Define Dialog oDlg Resource "DLG_CONSU_TRANSFER" BRUSH oBrusHPAPEL1
         REDEFINE RBBTN oInfo ID 2000 OF oDlg PROMPT "Consignação de Saída" CENTER ADJUST SAYBUTTON ROUND LINECOLORS CLR_SKY,CLR_AZUL_BRANCO
         SET FONT of oInfo to oFon3
      Else
         Define Dialog oDlg Resource "DLG_CONSU_TRANSFER" BRUSH oBrusHPAPEL1
         REDEFINE RBBTN oInfo ID 2000 OF oDlg PROMPT "Transferência de Saída" CENTER ADJUST SAYBUTTON ROUND LINECOLORS CLR_SKY,CLR_AZUL_BRANCO
         SET FONT of oInfo to oFon3
      Endif
      *
      *BOTOES ANTES DO FOLDER
      If vtipotra = "C"  // consignação
         REDEFINE say otext var vtext  ID 400 of oDlg
      Else
         REDEFINE say otext2 var vtext2 ID 400 of oDlg
      Endif
      *
      redefine GET onumetra var vnumetra id 2001 of oDlg Pict "999999" when empty(vnumetra)
      *
      REDEFINE say otext3    var vtext3    ID 4001 of oDlg color CLR_RED
      redefine GET odatatra var vdatatra  id 2002 of oDlg pict "@!" valid !empty(vdatatra)
      *
      If vmateliv = "S"
         redefine GET ocodiven var vcodiven id 2003 of oDlg valid( if(!empty(vcodiven),checkven(),Pesqven(.t.)) , SomaTra() , Lanca_TRF() ) BITMAP cbitmaps+"LUPA2.BMP" ACTION Pesqven(.t.)
         REDEFINE say onomeven var vnomeven ID 4002 of oDlg Font oFon4 update
      Else
         If vpedifun = "S"
            redefine GET ocodicli var vcodicli id 2003 of oDlg valid( if(!empty(vcodicli),checkcli(),Pesqcli(.t.)) ,  CliNegTrf() , Testa_Cli(vcodicli) ) update BITMAP cbitmaps+"LUPA2.BMP" ACTION Pesqcli(.t.)
            REDEFINE say onomecli var vnomecli ID 4002 of oDlg Font oFon4 update
         Else
            redefine GET ocodicli var vcodicli id 2003 of oDlg valid( if(!empty(vcodicli),checkcli(),Pesqcli(.t.)) ,  CliNegTrf() , SomaTra() , Testa_Cli(vcodicli), Apura_Saldo() , IF(lvalidcli.and.!empty(vcodicli) , Lanca_TRF(),.f.) ) update BITMAP cbitmaps+"LUPA2.BMP" ACTION Pesqcli(.t.)
            REDEFINE say onomecli var vnomecli ID 4002 of oDlg Font oFon4 update
         Endif
      Endif
      //bloco movido pra fora da condição por ter id diferente__.
      REDEFINE say otext5    var vtext5  ID 3698 of oDlg
      redefine GET ocodifun var vcodifun id 2004 of oDlg valid( if(!empty(vcodifun),checkfun(),Pesqfun(.t.)) , SomaTra() , Lanca_TRF() ) update BITMAP cbitmaps+"LUPA2.BMP" ACTION Pesqfun(.t.)
      REDEFINE say onomefun var vnomefun ID 4003 of oDlg Font oFon4
      //bloco___________________________________________________/
      * dados do credito
      REDEFINE say ocredito VAR tcredito ID 4010 of oDlg Font oFon4 update
      REDEFINE say orecechq VAR trecechq ID 4011 of oDlg Font oFon4 update
      REDEFINE say oreceber VAR treceber ID 4012 of oDlg Font oFon4 update
      REDEFINE say olimite  VAR vlimite  ID 4013 of oDlg Font oFon4 update
      REDEFINE say osaldocc VAR saldocc  ID 4014 of oDlg Font oFon4 update
      *
      *
      IF VMATEMED="S"
         REDEFINE FOLDER oFld ID 3000 OF oDlg PROMPTS  "&Produtos","Observação","Informações de Preenchimento"    ;
          DIALOGS "DLG_CONSU_TRANSFER_ABA1","DLG_CONSU_TRANSFER_ABA2","DLG_CONSU_TRANSFER_ABA3"
      Else
         REDEFINE FOLDER oFld ID 3000 OF oDlg PROMPTS  "&Produtos","Observação"    ;
          DIALOGS "DLG_CONSU_TRANSFER_ABA1","DLG_CONSU_TRANSFER_ABA2"
      Endif
      *
	
      tecon=2
      
      REDEFINE XBROWSE oLbxorc      ;
       fields itra->ordemit,itra->codipro,Nomprotra(),transf(itra->quantid,"999999.999"),transf(itra->prvenda,"@E 9,999,999.9999"),transf(itra->precoto,"@E 9,999,999.99");
       Headers "Ordem","Codigo","Nome","Quantidade","Pr.Unitário","Total";
       Fieldsizes 60,60,340,105,120,120 ;
       Alias "itra"                  ;
       id 6000 of oFld:aDialogs[1]   ;
       COLORS CLR_BLACK , CLR_SKY    ;
       FONT oGetFnt
      
      oLbxorc:aCols[4]:nHeadStrAlign:=1
      oLbxorc:aCols[4]:nDataStrAlign:=1
      oLbxorc:aCols[5]:nHeadStrAlign:=1
      oLbxorc:aCols[5]:nDataStrAlign:=1
      oLbxorc:aCols[6]:nHeadStrAlign:=1
      oLbxorc:aCols[6]:nDataStrAlign:=1
    
      oLbxorc:nMarqueeStyle       := 4
      oLbxorc:nColDividerStyle    := LINESTYLE_DARKGRAY
      oLbxorc:nRowDividerStyle    := LINESTYLE_DARKGRAY
   
      oLbxorc:aCols[ 1 ]:bLClickHeader := {||itra->(DbSetOrder(1)) ,itra->(DbGoTop()),oLbxorc:Refresh()}
      oLbxorc:aCols[ 2 ]:bLClickHeader := {||itra->(DbSetOrder(2)) ,itra->(DbGoTop()),oLbxorc:Refresh()}
   
      oLbxorc:lColDividerComplete := .t.
      oLbxorc:lFastEdit           := .t.
   
      *BOTOES DE INCLUSÃO DE PRODUTOS
      Redefine Buttonbmp obtn01 id 4006 of oDlg             Action Transf_Ref_Pro(olbxorc) 	when !empty(vcodicli) .or.  ! empty(vcodiven) update	
      
		Redefine Buttonbmp obtn01 id 3001 of oFld:aDialogs[1] Action IncProTra(olbxorc) 	when !empty(vcodicli) .or.  ! empty(vcodiven) update	 BITMAP cbitmaps+"incluir.bmp"  Prompt "Incluir"//"Registro"
      Redefine Buttonbmp obtn03 id 3002 of oFld:aDialogs[1] Action AltProTra(olbxorc) 	when !empty(vcodicli) .or.  ! empty(vcodiven)       	 BITMAP cbitmaps+"alterar.bmp"  Prompt "Alterar"//"Registro"
      Redefine Buttonbmp obtn04 id 3003 of oFld:aDialogs[1] Action RefProTra(olbxorc) 	when !empty(vcodicli) .or.  ! empty(vcodiven)       	 BITMAP cbitmaps+"excluir.bmp"  Prompt "&Referência"//"Registro"
      Redefine Buttonbmp obnt06 id 3004 OF oFld:aDialogs[1] Action ExcProTra(olbxorc) 	when !empty(vcodicli) .or.  ! empty(vcodiven)       	 BITMAP cbitmaps+"visualiz.bmp" Prompt "E&xcluir"//"Registro"
      Redefine Buttonbmp obnt07 id 3005 OF oFld:aDialogs[1] Action CapProTra(olbxorc) 	when !empty(vcodicli) .or.  ! empty(vcodiven)			 BITMAP cbitmaps+"pesquisa.bmp" Prompt "Capturar"//"Registro"
      Redefine Buttonbmp obnt08 id 3006 OF oFld:aDialogs[1] Action VisProTra(olbxorc) 	when !empty(vcodicli) .or.  ! empty(vcodiven)		    BITMAP cbitmaps+"imprimir.bmp" Prompt "&Visualizar"//"Registro"
      *
      *
		   
      *_________________FOLDER_2________________________FOLDER_2_____________________
      REDEFINE GET   odados1a var vdados1a ID 3001 of oFld:aDialogs[ tecon ] pict "@!"
      REDEFINE GET   odados2a var vdados2a ID 3002 of oFld:aDialogs[ tecon ] pict "@!"
      REDEFINE GET   odados3a var vdados3a ID 3003 of oFld:aDialogs[ tecon ] pict "@!"
      REDEFINE GET   odados4a var vdados4a ID 3004 of oFld:aDialogs[ tecon ] pict "@!"
      REDEFINE GET   odados5a var vdados5a ID 3005 of oFld:aDialogs[ tecon ] pict "@!"
	
  	
      IF VMATEMED="S"
         *
         *_________________FOLDER_3________________________FOLDER_3_____________________
         REDEFINE GET   odados100a var vatencao ID 3001 of oFld:aDialogs[ 3 ] pict "@!"
         REDEFINE GET   odados101a var vsetores ID 3002 of oFld:aDialogs[ 3 ] pict "@!"
         REDEFINE GET   odados102a var vpacient ID 3003 of oFld:aDialogs[ 3 ] pict "@!"
         REDEFINE GET   odados103a var vmedicos ID 3004 of oFld:aDialogs[ 3 ] pict "@!"
         REDEFINE GET   odados104a var vconveni ID 3005 of oFld:aDialogs[ 3 ] pict "@!"
         REDEFINE GET   odados105a var vhospita ID 3006 of oFld:aDialogs[ 3 ] pict "@!"
         REDEFINE GET   odados106a var vdatacir ID 3007 of oFld:aDialogs[ 3 ] pict "@!"
         REDEFINE GET   odados107a var vinstrum ID 3008 of oFld:aDialogs[ 3 ] pict "@!"
         *
      ENDIF
      *
      *BOTOES DEPOIS DO FOLDER
      REDEFINE say oitensnf var vitensnf ID 4015 of oDlg Font oFon4 update
      REDEFINE say oquantid var vquantid ID 4016 of oDlg Font oFon4 update
      REDEFINE say ototalbr var transf(vtotalbr,"@E 999,999.99") ID 4017 of oDlg Font oFon4 update
      *
      Redefine Buttonbmp obtn09 id 2020 of oDlg ACTION DescTra(oLbxOrc) when  vmateliv="N" .AND. vmatetex="N" .AND. ! EMPTY(vcodicli) BITMAP cbitmaps+"receita.bmp"  prompt "&Desconto"  tooltip "Desconto"
      //REDEFINE BUTTONBMP obnt09 ID 2020 of oDlg ACTION DescTra(oLbxOrc) when  vmateliv="N" .AND. vmatetex="N" .AND. ! EMPTY(vcodicli) prompt "(-)&Desconto"
      *
      REDEFINE say otext4    var vtext4    ID 4027 of oDlg font ofon4
      REDEFINE say odescont var transf(vdescont,"@E 99,999.99")  ID 4018 of oDlg Font oFon5 colors rgb (255,0,0) update
      REDEFINE say ototalnf var transf(vtotalnf,"@E 999,999.99")  ID 4019 of oDlg Font oFon5 update
  	
  	
      REDEFINE BUTTONBMP  ID 2050 of oDlg ACTION(lSave:=.t.,lcancel:=.f.,oDlg:End())     BITMAP cbitmaps+"ok.bmp" Prompt "Salvar"
      REDEFINE BUTTONBMP  ID 2051 of oDlg ACTION(lSave:=.f.,lcancel:=.t.,oDlg:End())     BITMAP cbitmaps+"ret.bmp" Prompt "Retornar"  cancel
	
      ACTIVATE dialog oDlg centered on init( if(empty(vnumetra),geratranum(),CheckTrf()),Habilita_transparent(oDlg),HIDE_FUN())
      *
      If lsave = .t.
         If vmateliv != "S"
            If Empty(vcodicli)
               MsgAlert("Código do Cliente está em branco !!!","Informação")
               Loop
            Endif
         Endif
         ********************************
         * Função Grava Transferencia   *
         ********************************
         If vtotalbr == 0
            MsgInfo("Transferência Sem Itens Não Pode ser Gravada","Atenção")
            Loop
         Endif
         MsgRun("Gravando Transferencia Nº"+vnumetra+", Aguarde...","Por Favor, Aguarde...", { || Grava_Tra() } )
				
         Ped_tra&vmodetra(vnumetra,"S",vtipotra) // gera o relatorio
			   
         if vtra_srv="S"            // transfere pelo ftp
            trans_trf(vdatatra,vnumetra)
         endif
         exit
      else
         sele itra
         set order to 1
         seek vnumetra
         do while ! eof() .and. numetra=vnumetra
            if travareg()=.f.
               skip
               loop
            endif
            dele
            skip
         enddo
         if altera=.f.
            sele inft
            set order to 1
            seek vnumetra
            if travareg()
               dele
               dbunlock()
				endif
            exit
         endif
      endif
      exit
   enddo
   oFon1:End()
   oFon2:End()
   oFontBotao:End()
   oFonv:End()
   return
   *******************************
   * Função Gravar Transferência *
   *******************************
STATIC Function Grava_Tra()
   sele inft
   set order to 1
   Enche_Var()
   if travareg()
	   repl codicli with vcodicli
      repl codifun with vcodifun
      repl nomecli with vnomecli
      repl datatra with vdatatra
      repl totalnf with vtotalnf
      repl totalbr with vtotalbr
      repl descont with vdescont
      repl codiven with vcodiven
      repl dados1a with vdados1a
      repl dados2a with vdados2a
      repl dados3a with vdados3a
      repl dados4a with vdados4a
      repl dados5a with vdados5a
      repl atencao with vatencao
      repl setores with vsetores
      repl pacient with vpacient
      repl medicos with vmedicos
      repl conveni with vconveni
      repl hospita with vhospita
      repl datacir with vdatacir
      repl instrum with vinstrum
      repl usuatra with usuario
      repl codifun with vcodifun
      dbcommit()
      dbunlock()
   endif
      sele ntra
      set order to 1
      seek vnumetra
      do while !eof() .and. numetra=vnumetra
         vquantig=quantid
			sele pro
         set order to 1
         seek ntra->codipro
         if travareg()=.f.
            sele ntra
            skip
            loop
         endif
         repl quantig with quantig+vquantig
         if vtransof="S"
            repl quantid with quantid+vquantig
         endif
         dbunlock()
         dbcommit()
         sele ntra
         if travareg()=.f.
           skip
           loop
        endif
        dele
        skip
      enddo
      *
	   sele mov
      set order to 1
      seek "TR"+vnumetra
      do while !eof() .and. alltrim(ndocmov)="TR"+vnumetra
         if travareg()=.f.
            skip
            loop
         endif
         dele
         skip
      enddo
      sele itra
      set order to 1
      go top
      seek vnumetra
      do while !eof() .and. numetra=vnumetra
         sele itra
         vcodipro=itra->codipro
         vbaixarp=itra->baixarp
         vbaixarf=itra->baixarf
         vquantig=itra->quantid
         sele pro
         set order to 1
         seek vcodipro
         if travareg()
             vcodiloc=codiloc
             vcodifor=codifor
             vcodisec=codisec
             vcodise2=codise2
             repl quantig with quantig-vquantig
             if vtransof="S"
                repl quantid with quantid-vquantig
             endif
             dbunlock()
             dbcommit()
             sele mov
             append blank
             repl ndocmov with "TR"+vnumetra
             repl datamov with vdatatra
             repl codipro with vcodipro
             repl quantig with itra->quantid
             if vtransof="S"
                repl quantid with itra->quantid
             endif
             repl codclfo with vcodicli
             repl preumov with itra->prvenda
             repl precmov with itra->precoto
             repl nrpecas with itra->nrpecas
             repl tiporeg with "S"
             repl codiloc with vcodiloc
             repl codifor with vcodifor
             repl codisec with vcodisec
             repl codise2 with vcodise2
         endif
         sele itra
         if travareg()=.f.
            skip
            loop
         endif
         repl baixarp with "N"
         repl baixarf with "N"
         skip
      enddo
      sele itra
      set order to 1
      go top
      seek vnumetra
      do while !eof() .and. numetra=vnumetra
         sele ntra
         append blank
         repl numetra with itra->numetra
         repl datatra with vdatatra
         repl quantid with itra->quantid
         repl codipro with itra->codipro
         repl prvenda with itra->prvenda
         repl precoto with itra->precoto
         repl baixarp with itra->baixarp
         repl baixarf with itra->baixarf
         repl codicli with vcodicli
         repl prcusre with itra->prcusre
         repl descont with itra->descont
         repl pranter with itra->pranter
         repl faturar with itra->faturar
         repl nrlotes with itra->nrlotes
         repl nrpecas with itra->nrpecas
         repl situtri with itra->situtri
         repl ordemit with itra->ordemit
         repl codifun with itra->codifun
         repl cserial with itra->cserial
         repl dataval with itra->dataval
         repl faturar with itra->faturar
         repl nomepro with itra->nomepro
         repl codiven with vcodiven
         sele itra
         if travareg()=.f.
            skip
            loop
         endif
         dele
         skip
      enddo
      return .t.
      *
      **************************************
      * Incluir Produtos na Transferência  *
      **************************************
Function IncProTra(olbxorc)
      local obut1,but2,obut3,lSavepro,oDlgIOrc
      Public vpassaget:=.f.,vpassagetqtd:=.f.
      if permitir2("trs11")=.f.
         sele itra
         return
      endif
      sele itra
      Priv onomepro,vnomepro
      Priv oprcusre,vprcusre
      Priv oordemit,vordemit
      Priv oreferen,vreferen
      Priv odescpro,vdescpro
      Priv oprvenda,vprvenda
      Priv oprdesct,vprdesct
      Priv onrlotes,vnrlotes
      Priv ounidade,vunidade
      Priv oquantig,vquantig
      Priv ofaturar,vfaturar
      Priv oxprvenda,xprvenda
      Priv opranter,vpranter:=0.00
   
      * incluido em 05/05/2010
       
      Priv vcserial
      Priv vdataval
      Priv vcodifor

      *
      while .t.

         Priv ocodipro,vcodipro
         vpassagetqtd:=.f.
         lSavepro:=.f.
         vcodipro:=space(len(codipro))
         sele pro
         vnomepro:=space(len(nomepro))
         vunidade:=space(len(unidade))
         vprdesct:=prdesct
   
         sele itra
         vnrlotes:=space(len(nrlotes))
   
         * incluido em 05/05/2010
    	   
         vcserial=space(len(cserial))
         vdataval=date()
         vcodifor=space(len(codifor))
   
         vquantid:=0.00
         vquantig:=0.00
         vprvenda:=0.00
         xprvenda:=0.00
         vprecoto:=0.00
         vnrpecas:=0
         vfaturar:=0
         vpranter:=0
         *
         *
         Define Font oFon3 Name "LUCIDA CONSOLE" size 0,20
         Define Font oFon5 Name "Times New Roman" size 0,-20 bold
         Define Dialog oDlgIncOrc Resource "DLG_CONSU_TRANSFER_INC"  BRUSH  oBrusHPAPEL1//mstar4.res
         redefine rbbtn oinfo id 2000 of oDlgIncOrc  prompt "Itens - Incluir"  CENTER  adjust saybutton round linecolors CLR_SKY,CLR_AZUL_BRANCO
         set font of oinfo to ofon3
	
         REDEFINE GET  ocodipro var vcodipro ID 2001 of oDlgIncOrc pict "999999" valid iif(!empty(vcodipro),checkpro(),Pesqpro(.t.)) .and. PreIncTra() .and. Qtd_Tra(vunidade,oquantid,@vquantid) BITMAP cbitmaps+"LUPA2.BMP" ACTION Pesqpro(.t.)
         If vmatemed = "S"     // material medico edita da descrição
            redefine GET  onomepro var vnomepro id 2002 of oDlgIncOrc
         Else
            redefine SAY  onomepro var vnomepro id 2002 of oDlgIncOrc
         Endif
         redefine SAY  ounidade var vunidade id 4001 of oDlgIncOrc
         redefine SAY  oquantig var vquantig id 4002 of oDlgIncOrc
         redefine GET  oquantid VAR vquantid id 2003 of oDlgIncOrc pict "999999.999" Valid TrQtdPrcT1(vquantid,vprvenda)
         redefine GET  oprvenda var vprvenda id 2004 of oDlgIncOrc pict "@E 99999.9999" Valid TrQtdPrcT2()
         redefine SAY  oprecoto var transf(vprecoto,"@E 999,999.99") id 4003 of oDlgIncOrc Font oFon5
         *
         REDEFINE BUTTONBMP ID 2050 of oDlgIncOrc ACTION( lSavepro := .t.,oDlgIncOrc:end()) BITMAP cbitmaps+"ok.bmp" Prompt "Confirmar"
         REDEFINE BUTTONBMP ID 2051 of oDlgIncOrc ACTION( lSavepro := .f.,oDlgIncOrc:end()) BITMAP cbitmaps+"cancela.bmp" Prompt "Cancelar" Cancel
 			 
         Activate Dialog oDlgIncOrc Centered	ON INIT HABILITA_TRANSPARENT (oDlgIncOrc)
         *
         if empty(vcodipro)
            lsavepro:=.f.
         endif
         *
         if empty(vquantid)
            lsavepro:=.f.
         endif
         *
         if lSavepro=.t.
            *
            if vpassaget:=.f.
               vprecoto:=vquantid*vprvenda
            endif

            sele itra
            set order to 2
      
            go top
            vordemit:=strzero(val(ordemit)+1,len(ordemit),0)
      
            sele itra
            append blank
            repl numetra with vnumetra
            repl datatra with vdatatra
            repl codipro with vcodipro
            repl quantid with vquantid
            repl prvenda with vprvenda
            repl precoto with vprecoto
            repl descont with vdescpro
            repl baixarp with "S"
            repl baixarf with "N"
            repl nomepro with vnomepro
            if vtransof="S"
               repl baixarf with "S"
            endif
            repl prcusre with vprcusre
            Enche_Var()
            repl codicli with vcodicli
            repl pranter with vpranter
            repl nrpecas with vnrpecas
            repl nrlotes with vnrlotes
            repl faturar with vfaturar
            repl ordemit with vordemit

            repl cserial with vcserial
            repl dataval with vdataval
            repl nrlotes with vnrlotes
            repl faturar with vfaturar
            dbcommit()
      
         elseif lSavepro=.f.
    
            exit
      
         endif
    
         SomaTra()
    
         sysrefresh()
    
         xsetfocus(oLbxOrc)
    
         loop
    
      enddo

      oLbxOrc:Refresh()            // We want the ListBox to be repainted
      xsetfocus(oLbxOrc)
    
      return
      *
      *****************************
      * Incluir Pela Referencia   *
      *****************************
      *
Function RefProTra
      local obut1,but2,obut3,lSavepro,oDlgIOrc
      Public vprcalcu,vpassaget:=.f.,vpassagetqtd:=.f.
      *
      if permitir2("trs11")=.f.
         sele itra
         return
      endif
      lSavepro:=.f.
      sele itra
      *
      Priv onomepro,vnomepro
      Priv oprcusre,vprcusre
      Priv oordemit,vordemit
      Priv oreferen,vreferen
      Priv odescpro,vdescpro
      Priv oprvenda,vprvenda
      Priv oprdesct,vprdesct
      Priv onrlotes,vnrlotes
      Priv ounidade,vunidade
      Priv oquantig,vquantig
      Priv ofaturar,vfaturar
      Priv oxprvenda,xprvenda
      Priv opranter,vpranter:=0.00

      * incluido em 05/05/2010
       
      Priv vcserial
      Priv vdataval
      Priv vcodifor
   
      *
   
      while .t.

         vpassagetqtd:=.f.
   
         sele pro
         vreferen:=space(len(referen))
         vcodipro:=space(len(codipro))
   
         sele pro
         vnomepro:=space(len(nomepro))
         vreferen:=space(len(referen))
         vunidade:=space(len(unidade))
         vprdesct:=prdesct
   
         sele itra
         vnrlotes:=space(len(nrlotes))
   
         * incluido em 05/05/2010
    	   
         vcserial=space(len(cserial))
         vdataval=date()
         vcodifor=space(len(codifor))
   
         *
         *vquantid:=0.00
         vquantid:=1.00
         *
         vprvenda:=0.00
         vprecoto:=0.00
         xprvenda:=0.00
         *
         vfaturar:=0.00
         vnrpecas:=0
         vprcalcu:=0.00
         vpranter:=0.00
         *
         *
         Define Font oFon3 Name "LUCIDA CONSOLE" size 0,17
         Define Font oFon5 Name "Times New Roman" size 0,-20 bold
         Define Dialog oDlgIncOrc Resource "DLG_CONSU_TRANSFER_INC_REF"  BRUSH  oBrusHPAPEL1//mstar4.res
         redefine rbbtn oinfo id 2000 of oDlgIncOrc  prompt "Itens da Transferência - Incluir pela Referencia"  CENTER  adjust saybutton round linecolors CLR_SKY,CLR_AZUL_BRANCO
         set font of oinfo to ofon3
	
         REDEFINE GET  oreferen var vreferen ID 2001 of oDlgIncOrc valid iif(!empty(vreferen),CheckProRef(),.f.) .and. PreIncTra() .and. Qtd_Tra(vunidade,oquantid,@vquantid)
         redefine SAY  onomepro var vnomepro id 4001 of oDlgIncOrc
         redefine SAY  ounidade var vunidade id 4002 of oDlgIncOrc
         redefine SAY  ocodipro var vcodipro id 4003 of oDlgIncOrc
         redefine SAY  oquantig var vquantig id 4004 of oDlgIncOrc
         redefine GET  oquantid VAR vquantid id 2002 of oDlgIncOrc pict "999999.999" Valid TrQtdPrcT1(vquantid,vprvenda)
         redefine GET  oprvenda var vprvenda id 2003 of oDlgIncOrc pict "@E 99999.9999" Valid TrQtdPrcT2()
         redefine SAY  oprecoto var transf(vprecoto,"@E 999,999.99") id 4005 of oDlgIncOrc Font oFon5
         *
         REDEFINE BUTTONBMP ID 2050 of oDlgIncOrc when vpassagetqtd=.t. ACTION( lSavepro := .t.,oDlgIncOrc:end()) BITMAP cbitmaps+"ok.bmp" Prompt "Confirmar"
         REDEFINE BUTTONBMP ID 2051 of oDlgIncOrc ACTION( lSavepro := .f.,oDlgIncOrc:end()) BITMAP cbitmaps+"cancela.bmp" Prompt "Cancelar" Cancel
 			 
         Activate Dialog oDlgIncOrc Centered	ON INIT HABILITA_TRANSPARENT (oDlgIncOrc)
         *
         setkey(VK_F10,{|| (.t.)})
         if empty(vcodipro)
            lsavepro:=.f.
         endif
         if empty(vquantid)
            lsavepro:=.f.
         endif
         *
         if lSavepro=.t.
            *
            if vpassaget:=.f.
               vprcalcu:=vprvenda
               vprvenda:=calcplav(vprvenda)
               vpranter:=vprvenda
               *        vprecoto:=truncar(vquantid*round(vprvenda,vdecimal))
               vprecoto:=vquantid*round(vprvenda,vdecimal)
            endif
            sele itra
            set order to 2
            go top
            vordemit:=strzero(val(ordemit)+1,len(ordemit),0)
            *
            *     vprecoto=truncar(vquantid*round(vprvenda,vdecimal))
            vprecoto=vquantid*round(vprvenda,vdecimal)
            *
            sele itra
            append blank
            repl numetra with vnumetra
            repl datatra with vdatatra
            repl codipro with vcodipro
            repl quantid with vquantid
            repl prvenda with vprvenda
            repl precoto with vprecoto
            repl baixarp with "S"
            repl baixarf with "N"
      
            if vtransof="S"
               repl baixarf with "S"
            endif
      
            Enche_Var()
      
            repl prcusre with vprcusre
            repl codicli with vcodicli
            repl descont with vdescpro
            repl pranter with vpranter
            repl nrpecas with vnrpecas
            repl nrlotes with vnrlotes
            repl faturar with vfaturar
            repl ordemit with vordemit
            repl cserial with vcserial
            repl dataval with vdataval
            repl nrlotes with vnrlotes
            repl faturar with vfaturar
            repl nomepro with vnomepro
      
         elseif lSavepro=.f.
    
            exit
      
         endif
    
         SomaTra()
         xsetfocus(oLbxOrc)
         oLbxOrc:Refresh()          // We want the ListBox to be repainted
         loop
    
      enddo
 
      oLbxOrc:Refresh()            // We want the ListBox to be repainted
    
      odlg:Refresh()
      odlg:Update()
    
      *   xsetfocus(oLbxOrc)
      xsetfocus(ofld)
    
      return
      *
      **************************************
      * Alterar Produtos na Transferência  *
      **************************************
      *
Function AltProTra(olbxorc)

      local obut1,but2,obut3,lSavepro,oDlgIOrc
      Public vpassaget:=.f.,vpassagetqtd:=.f.
      *
      lSavepro:=.f.
      if permitir2("trs12")=.f.
         sele itra
         return
      endif
      sele itra
      *
      Priv onomepro,vnomepro
      Priv oprcusre,vprcusre:=0.00
      Priv oordemit,vordemit
      Priv oreferen,vreferen:=""
      Priv odescpro,vdescpro:=" "
      Priv oprvenda,vprvenda:=0.00
      Priv oprdesct,vprdesct:=0.00
      Priv onrlotes,vnrlotes:=" "
      Priv ounidade,vunidade:=" "
      Priv oquantig,vquantig:=0.00
      Priv ofaturar,vfaturar:=0.00
      Priv oxprvenda,xprvenda:=0.00
      Priv opranter,vpranter:=0.00
      *
      Priv ocodipro,vcodipro
   
      * incluido em 06/05/2010
       
      Priv vcserial
      Priv vdataval
      Priv vcodifor
      *
      vpassagetqtd:=.f.
      *
      vcodipro:=codipro
      sele pro
      set order to 1
      seek itra->codipro
   
      vnomepro:=nomepro
      vunidade:=unidade
      vprvenda:=pro->prcusto
      xprvenda=vprvenda
      vquantig:=pro->quantig
      xquantid:=pro->quantid
      vdescpro:=pro->descpro
      vprdesct:=pro->prdesct
   
      sele itra
      if !empty(itra->nomepro)
         vnomepro:=itra->nomepro
      endif
      vnumetra=numetra
      vdatatra=datatra
      vquantia=quantid
      vquantid=quantid
      vcodipra=codipro
      vcodipro=codipro
      vprvenda=prvenda
      vprecoto=precoto
      vprcusre=prcusre
      vnrpecas=nrpecas
      vnrlotes=nrlotes
      vfaturar=faturar
   
      * incluido em 06/05/2010
    	   
      vcserial=cserial
      vdataval=dataval
      vcodifor=codifor
   
      *

      Define Font oFon3 Name "LUCIDA CONSOLE" size 0,20
      Define Font oFon4 Name "LUCIDA CONSOLE " size 0,-12
      Define Font oFon5 Name "Times New Roman" size 0,-20 bold
      Define Dialog oDlgIncOrc Resource "DLG_CONSU_TRANSFER_ALT"  BRUSH  oBrusHPAPEL1//mstar4.res
      redefine rbbtn oinfo id 2000 of oDlgIncOrc  prompt "Itens - Alterar"  CENTER  adjust saybutton round linecolors CLR_SKY,CLR_AZUL_BRANCO
      set font of oinfo to ofon3
	
      REDEFINE SAY  ocodipro var vcodipro ID 4001 of oDlgIncOrc Font oFon4
      If vmatemed != "S"     // material medico edita da descrição
         redefine SAY  onomepro var vnomepro id 2001 of oDlgIncOrc
      Else
         redefine GET  onomepro var vnomepro id 2001 of oDlgIncOrc
      Endif
      redefine SAY  ounidade var vunidade id 4002 of oDlgIncOrc
      redefine SAY  oreferen var vreferen id 4003 of oDlgIncOrc Font oFon4
      redefine GET  oquantid VAR vquantid id 2002 of oDlgIncOrc pict "999999.999" Valid vquantid>0 .and. TrQtdPrcT1(vquantid,vprvenda)
      redefine GET  oprvenda var vprvenda id 2003 of oDlgIncOrc pict "@E 99999.9999" Valid TrQtdPrcT2()
      redefine SAY  oprecoto var transf(vprecoto,"@E 999,999.99") id 4004 of oDlgIncOrc Font oFon5
      *
      REDEFINE BUTTONBMP ID 2050 of oDlgIncOrc ACTION( lSavepro := .t.,oDlgIncOrc:end()) BITMAP cbitmaps+"ok.bmp" Prompt "Confirmar"
      REDEFINE BUTTONBMP ID 2051 of oDlgIncOrc ACTION( lSavepro := .f.,oDlgIncOrc:end()) BITMAP cbitmaps+"cancela.bmp" Prompt "Cancelar" Cancel
 			 
      Activate Dialog oDlgIncOrc Centered	ON INIT HABILITA_TRANSPARENT (oDlgIncOrc)
      *
      if lSavepro=.t.
         *
         if vpassaget:=.f.
            vprcalcu:=vprvenda
            vprvenda:=calcplav(vprvenda)
            vpranter:=vprvenda
            *        vprecoto:=truncar(vquantid*round(vprvenda,vdecimal))
            vprecoto:=vquantid*round(vprvenda,vdecimal)
         endif
         sele itra
         vprecoto=vquantid*vprvenda
         *
         sele itra
         if travareg()=.f.
			endif
            repl numetra with vnumetra
            repl datatra with vdatatra
            repl codipro with vcodipro
            repl quantid with vquantid
            repl prvenda with vprvenda
            repl precoto with vprecoto
            repl baixarp with "S"
            repl baixarf with "N"
            if vtransof="S"
               repl baixarf with "S"
            endif
            repl prcusre with vprcusre
            repl codicli with vcodicli
            repl descont with vdescpro
            repl pranter with vpranter
            repl nrpecas with vnrpecas
            repl nrlotes with vnrlotes
            repl faturar with vfaturar
            repl cserial with vcserial
            repl dataval with vdataval
            repl nomepro with vnomepro
            *
         elseif lSavepro=.f.
            * nao faz nada
         endif
    
         SomaTra()
         xsetfocus(oLbxOrc)
    
         return
         *
Function ExcProTra(oLbxOrc)
         if MsgYesNo( "Deseja excluir o lançamento ? "+usuario+" ","Confirmação")
            if permitir2("trs13")=.f.
               sele itra
               return
            endif
            sele itra
            if travareg()=.f.
               return
            endif
            dele
         endif
         SomaTra()
         xsetfocus(oLbxOrc)
         Return .t.
         ***************************
         * Capturar Produtos       *
         ***************************
         *
Function CapProTra(oLbxOrc)
         Local obut1,but2,obut3,oradio1,oDlgIncOrc
         sele itra
         go top
         public lSave := .f.
         public nRec := RecNo()
         norden=1
         *
         Define Font oFon3 Name "LUCIDA CONSOLE" size 0,20
         Define Font oFon4 Name "LUCIDA CONSOLE " size 0,-12
         Define Dialog oDlgIncOrc Resource "DLG_CONSU_TRANSFER_CAP" BRUSH  oBrusHPAPEL1  //mstar4.res
         REDEFINE RBBTN oInfo ID 2000 OF oDlgIncOrc PROMPT "Capturar" CENTER ADJUST SAYBUTTON ROUND LINECOLORS CLR_SKY,CLR_AZUL_BRANCO
         SET FONT of oInfo to oFon3
	
         REDEFINE RADIO   oRadioA  VAR nOrden   ID 4001,4002,4003 of oDlgIncOrc
	
         REDEFINE BUTTONBMP  ID 2050 of oDlgIncOrc ACTION( lSave := .t.,oDlgIncOrc:End())     BITMAP cbitmaps+"ok.bmp" Prompt "Confirmar"
         REDEFINE BUTTONBMP  ID 2051 of oDlgIncOrc ACTION( lSave := .f.,oDlgIncOrc:End())     BITMAP cbitmaps+"cancela.bmp" Prompt "Cancelar"  cancel
	
         ACTIVATE dialog oDlgIncOrc centered
         if lSave
            if norden=1       // coletor de dados
               Cap_Col(oLbxorc)
               sele itra
               go top
            elseif norden=2  // transferencias
               vdescant=vdescont
               cap_tra(oLbxorc)
               sele itra
               go top
            elseif norden=3  // nf entradada
               vdescant=vdescont
               cap_nfe(oLbxorc)
               vdescont=vdescant
               sele itra
               go top
            endif
         elseif lsave=.f.
            *
         endif
         xsetfocus(oLbxOrc)
         oLbxOrc:Refresh()          // We want the ListBox to be repainted
         return
         *
         ***************************
         * Função Coletor de Dados *
         * Capturar Dados          *
         * 1. Coletor de Dados     *
         ***************************
         *
Function Cap_Col(oLbxOrc)
         sele itra
         if ! file("IR_READ.EXE")
            msgalert("ATENÇÃO , O Arquivo de captura do coletor não está presente no sistema o arquivo IR_READ.EXE, Contate o suporte!!!")
            retu
         endif
         if MsgYesNo("Coletor Conectado e em Modo de ( Upload )? Confirma iniciar captura do dados do coletor","Pergunta")
            *
            * nao faz nada
            *
         else
            retu
         endif
         ferase("c:\integrad\COLETOR.TXT")
         waitrun("ir_read.exe")
         if !file("c:\integrad\COLETOR.TXT")
            msgalert("ATENÇÃO , O Arquivo não foi recebido do coletor , verifique o equipamento (TOMADA) E (SERIAL) e realize o processo novamente !!!","Informação")
            retu .f.
         else
            msgalert("Atenção arquivo foi recebido com sucesso... , Arquivo:COLETOR.TXT")
         endif
         use coletor alia clt shared new
         if neterr()
            retu
         endif
         set index to coletor
         copy stru to c:\integrad\coletar.dbf
         use c:\integrad\coletar alia xclt exclu new
         if neterr()
            retu
         endif
         sele xclt
         go top
         do while !eof()
            if travareg()=.f.
               skip
               loop
            endif
            dele
            skip
         enddo
         sele xclt
         append from c:\integrad\coletor.txt delimited with ","
         sele xclt
         go top
         do while !eof()
            sele xclt
            vreferen=referen
            vquantid=quantid
            sele pro
            set order to 7
            seek vreferen
            if !eof()
               vcodipro=codipro
               vnomepro=nomepro
               vprcompr=prcusto
               vdatamov=dat_hoje
               vestoque=quantig
               sele xclt
               if vestoque<vquantid
                  if vpediest="N"
                     msgalert("Produto:"+vcodipro+" "+alltrim(vnomepro)+", O Estoque Atual é:"+transfor(vestoque,"9999999.99")+" , esta abaixo do solicitado , transação não autorizada","Atenção")
                     skip
                     loop
                  endif
               endif
               if travareg()=.f.
                  skip
                  loop
               endif
               repl codipro with vcodipro
               repl prcompr with vprcompr
               repl datamov with vdatamov
               repl precoto with prcompr*quantid
               dbunlock()
            else
               msgalert("ATENÇÃO Produto não localizado pela referência:"+vreferen)
            endif
            sele xclt
            skip
         enddo
         sele xclt
         go top
         do while !eof()
            sele xclt
            if empty(codipro)
               skip
               loop
            endif
            vcodipro=codipro
            vquantiG=quantid
            vprcompr=prcompr
            vdatamov=datamov
            vprecoto=truncar(quantid*round(vprcompr,vdecimal))
            sele itra
            set order to 2
            go top
            vordemit=strzero(val(ordemit)+1,len(ordemit),0)
            vnrpecas=1
            sele pro
            set order to 1
            seek vcodipro
            vprcusre=prcusre
            sele itra
            append blank
            repl numetra with vnumetra
            repl datatra with vdatatra
            repl codipro with vcodipro
            repl quantid with vquantiG
            repl prvenda with vprcompr
            repl precoto with vprecoto
            repl baixarp with "S"
            repl baixarf with "N"
            if vtransof="S"
               repl baixarf with "S"
            endif
            repl prcusre with vprcusre
            repl codicli with vcodicli
            repl nrpecas with vnrpecas
            repl ordemit with vordemit
            sele xclt
            skip
         enddo
         SomaTra()
         close xclt
         close clt
         ferase("c:\integrad\coletar.dbf")
         ferase("c:\integrad\coletor.txt")
         return
         *
         ***************************
         * Capturar Dados          *
         * 2. Transferencia        *
         ***************************
         *
Function Cap_tra(oLbxOrc)
         local obut1,but2,obut3,lSavepro,oDlgIOrc
         Public vpassaget:=.f.,vprvenda,vpassagetqtd:=.t.
         *

         Priv otnumetra,tnumetra
         Priv odescont,vdescont
         *
         tnumetra:=space(6)
         *
         nar1="inftran"
         nar1d="inftran.dbf"
         nar1c="inftran.cdx"
         *
         nar2="ntransf"
         nar2d="ntransf.dbf"
         nar2c="ntransf.cdx"
         *
         *
         Define Font oFon3 Name "LUCIDA CONSOLE" size 0,20
         Define Font oFon4 Name "LUCIDA CONSOLE " size 0,-12
         Define Dialog oDlgIncOrc Resource "DLG_CONSU_TRANSFER_CAP_TRANS"  BRUSH  oBrusHPAPEL1//mstar4.res
         redefine rbbtn oinfo id 2000 of oDlgIncOrc  prompt "Capturar Transferência"  CENTER  adjust saybutton round linecolors CLR_SKY,CLR_AZUL_BRANCO
         set font of oinfo to ofon3
	
         REDEFINE SAY  opastaor  var vpastaor ID 4001 of oDlgIncOrc Font oFon4
         redefine GET  otnumetra var tnumetra id 2001 of oDlgIncOrc pict "999999" valid !empty(tnumetra)
         *
         REDEFINE BUTTONBMP ID 2050 of oDlgIncOrc ACTION( lSavepro := .t.,oDlgIncOrc:end()) BITMAP cbitmaps+"ok.bmp" Prompt "Confirmar"
         REDEFINE BUTTONBMP ID 2051 of oDlgIncOrc ACTION( lSavepro := .f.,oDlgIncOrc:end()) BITMAP cbitmaps+"cancela.bmp" Prompt "Cancelar" Cancel
 			 
         Activate Dialog oDlgIncOrc Centered	ON INIT HABILITA_TRANSPARENT (oDlgIncOrc)
         *
         if lSavepro//=.t.
   
            if !file("&vpastaor&nar1d")
               msgalert("Na Pasta de origem informada não contêm o arquivo INFTRAN.DBF "+CRLF+"&vpastaor&nar1d","Atenção")
               retu
            endif
      
            if !file("&vpastaor&nar1c")
               msgalert("Na Pasta de origem informada não contem arquivo INFTRAN.CDX  "+CRLF+"&vpastaor&nar1c","Atenção")
               retu
            endif
     
            if !file("&vpastaor&nar2d")
               msgalert("Na Pasta de origem informada não contêm o arquivo NTRANSF.DBF "+CRLF+"&vpastaor&nar2d","Atenção")
               retu
            endif
      
            if !file("&vpastaor&nar2c")
               msgalert("Na Pasta de origem informada não contem arquivo NTRANSF.CDX  "+CRLF+"&vpastaor&nar2c","Atenção")
               retu
            endif
	   
            use &vpastaor&nar1 alias cinft new shared
      
            if neterr()
               mendisp()
               vdescont=vdescant
               retu
            endif
            set index to &vpastaor&nar1
      
            sele 88
            use &vpastaor&nar2 alias citra new shared
      
            if neterr()
               vdescont=vdescant
               mendisp()
               retu
            endif
            set index to &vpastaor&nar2
            *
            tnumetra:=strzero(val(tnumetra),6,0)
      
            sele cinft
            set order to 1
      
            seek tnumetra
      
            if eof()
               msgalert("Nº Transferência não foi localizado !!!","Informação")
               vdescont=vdescant
               close cinft
               close citra
               retu
            endif
            *
            vdescant:=vdescant+descont
      
            if MsgYesNo("Confirma Capturar informação da Transferência","Pergunta")
               *
            else
               close cinft
               close citra
               retu
            endif
            sele cinft
            vcodicli = codicli
            vnomecli = nomecli
	   
            * apura o saldo
            Apura_Saldo()

            * apura o numero do item
            sele itra
            dbsetorder(1)
            dbgobottom()
            vordemit:=strzero(val(ordemit)+1,len(ordemit),0)
      
            sele citra
            set order to 1
            seek tnumetra
      
            *      vtotalnf:=vtotalbr-vdescont;ototalnf:Refresh()
      
             while ! eof() .and. numetra == tnumetra
      
            vquantid=quantid
            vcodipro=codipro
            vprvenda=prvenda
            vprecoto=precoto
            vbaixarp=baixarp
            vprcusre=prcusre
            vdescont=descont
            vpranter=pranter
            vfaturar=faturar
            vnrlotes=nrlotes
            vnrpecas=nrpecas
            vsitutri=situtri
         
            vtotalbr=vtotalbr+precoto
            vtotalnf=vtotalnf+precoto

            sele itra
         
            append blank
         
            repl numetra  with vnumetra
            repl datatra  with vdatatra
            repl quantid  with vquantid
            repl codipro  with vcodipro
            repl prvenda  with vprvenda
            repl precoto  with vprecoto
            repl baixarp  with vbaixarp
            repl codicli  with vcodicli
            repl prcusre  with vprcusre
            repl descont  with vdescont
            repl pranter  with vpranter
            repl faturar  with vfaturar
            repl nrlotes  with vnrlotes
            repl nrpecas  with vnrpecas
            repl situtri  with vsitutri
            repl ordemit  with vordemit
         
            vordemit:=strzero(val(vordemit)+1,len(ordemit),0)
         
            dbcommit()
         
            sele citra
         
            skip
         
         end
      
         sele itra
      
         close cinft
         close citra
      
         SomaTra()
      
      endif
      *
      xsetfocus(oLbxOrc)
      oLbxOrc:Refresh()          // We want the ListBox to be repainted
   
      return
      *
      *
      ************************************
      * Capturar Dados                   *
      * 3. Nota Fiscal de Entrada        *
      ************************************
      *
Function Cap_Nfe(oLbxOrc)

      Local obut1,but2,obut3,oradio1,oDlgRelTrf,lBota2Obmp := .t.
   
      public lSave := .f.
      public lSave2:= .f.
      public lSave3:= .f.
      public lSave4:= .f.
      public nRec := RecNo()
      **
      Priv oordemit,vordemit
      **
      Priv onunfent,vnunfent
      Priv ocodifor,vcodifor
      Priv onomefor,vnomefor
      **
      sele rmo
      vnunfent:=space(len(nunfent))
      vcodifor:=space(len(fornent))
      *
      Define Font oFon3 Name "LUCIDA CONSOLE" size 0,17
      Define Font oFon4 Name "LUCIDA CONSOLE " size 0,-12
      Define Dialog oDlgRelTrf Resource "DLG_CONSU_TRANSFER_NFE"  BRUSH  oBrusHPAPEL1//mstar4.res
      redefine rbbtn oinfo id 2000 of oDlgRelTrf  prompt "Informação da Nota Fiscal de Entrada"  CENTER  adjust saybutton round linecolors CLR_SKY,CLR_AZUL_BRANCO
      set font of oinfo to ofon3
	
      redefine GET  onunfent var vnunfent id 2001 of oDlgRelTrf valid iif(!empty(vnunfent),checknfise(),Pesqnfise(.t.)) BITMAP cbitmaps+"LUPA2.BMP" ACTION Pesqnfise(.t.)
      *
      redefine GET  ocodifor var vcodifor id 2002 of oDlgRelTrf valid iif(!empty(vcodifor),checkfor(),Pesqfor(.t.)) BITMAP cbitmaps+"LUPA2.BMP" ACTION Pesqfor(.t.)
      redefine SAY  onomefor var vnomefor id 4002 of oDlgRelTrf Font oFon4
      *
      REDEFINE BUTTONBMP ID 2050 of oDlgRelTrf ACTION( lSave := .t.,oDlgRelTrf:end()) BITMAP cbitmaps+"ok.bmp" Prompt "Confirmar"
      REDEFINE BUTTONBMP ID 2051 of oDlgRelTrf ACTION( lSave := .f.,oDlgRelTrf:end()) BITMAP cbitmaps+"cancela.bmp" Prompt "Cancelar" Cancel
 			 
      Activate Dialog oDlgRelTrf Centered	ON INIT HABILITA_TRANSPARENT (oDlgRelTrf)
      *
      if lSave
         *
         *
         if MsgYesNo("Confirma Capturar os itens da NF. de Entrada Informada ?","Pergunta")

            sele itra
            dbsetorder(1)
            dbgobottom()
            vordemit=strzero(val(ordemit)+1,len(ordemit),0)
      
            sele nfe
            seek vnunfent+vcodifor
         
            If Eof()
               MsgInfo("Nota Fiscal Sem Itens a Serem Importados","Atenção")
               Return
            Endif
         
            while ! eof() .and. nunfent=vnunfent .and. codifor=vcodifor
               *
               sele pro
               set order to 1
               seek nfe->codipro
            
               vprcusre=prcusre
               vprvenda=prcusto
            
               *msginfo(" "+nomepro+" "+codipro,"teste")
            
               sele itra
               **
               append blank
               **
               repl numetra with vnumetra
               repl datatra with vdatatra
               repl codipro with nfe->codipro
               repl quantid with nfe->quantid
               repl prvenda with vprvenda
               repl precoto with (vprvenda*nfe->quantid)
               repl baixarp with "S"
               repl baixarf with "N"
            
               if vtransof="S"
                  repl baixarf with "S"
               endif
            
               repl prcusre with vprcusre
               repl codicli with vcodicli
               **
               repl ordemit with vordemit
               **
               vordemit=strzero(val(vordemit)+1,len(ordemit),0)
               **
               sele nfe
               skip
               *
            end
         
         else
      
            sele pro
            retu
         
         endif
      *   elseif lsave=.f.
         *      sele pro
         *      set order to 3
      endif
   
      somatra()
   
      return
      *
      *
      ***************************
      * Visualizar Produtos     *
      ***************************
      *
Function VisProTra(oLbxOrc)
      Local obut1,but2,obut3,lSavepro,oDlgIOrc
      Public vpassaget:=.f.,vpassagetqtd:=.f.
      *
      lSavepro:=.f.
      sele itra
      *
      Priv ocodipro,vcodipro
      Priv onomepro,vnomepro
      Priv oreferen,vreferen
      Priv odescpro,vdescpro
      *
      Priv oprcusre,vprcusre
      *
      Priv oprdesct,vprdesct
      Priv oprcalcu,vprcalcu
      Priv oprpromo,vprpromo
      Priv oprataca,vprataca
      Priv ounidade,vunidade
      Priv oprvenda,vprvenda
      Priv oquantig,vquantig
      *
      vcodipro:=codipro
      sele pro
      set order to 1
      seek vcodipro
      vnomepro:=nomepro
      vreferen:=referen
      vunidade:=unidade
      vprdesct:=prdesct
      vprataca:=prataca
      vprdesct:=prdesct
      *
      sele itra
      vquantid:=quantid
      vprvenda:=prvenda
      vprecoto:=precoto
      *valturas:=alturas
      *vlargura:=largura
      *vprcalcu:=prcalcu
      vpranter:=pranter
      vnrpecas:=nrpecas
      if !empty(itra->nomepro)
         vnomepro:=nomepro
      endif
      *

      Define Font oFon3 Name "LUCIDA CONSOLE" size 0,16
      Define Font oFon4 Name "LUCIDA CONSOLE " size 0,-12
      Define Font oFon5 Name "Times New Roman" size 0,-20 bold
      Define Dialog oDlgIncOrc Resource "DLG_CONSU_TRANSFER_VIS"  BRUSH  oBrusHPAPEL1//mstar4.res
      redefine rbbtn oinfo id 2000 of oDlgIncOrc  prompt "Itens na Transferência - Visualizar"  CENTER  adjust saybutton round linecolors CLR_SKY,CLR_AZUL_BRANCO
      set font of oinfo to ofon3
	
      REDEFINE SAY  ocodipro var vcodipro ID 4001 of oDlgIncOrc Font oFon4
      REDEFINE SAY  onomepro var vnomepro ID 4002 of oDlgIncOrc Font oFon4
      REDEFINE SAY  ounidade var vunidade ID 4003 of oDlgIncOrc Font oFon4
      REDEFINE SAY  oreferen var vreferen ID 4004 of oDlgIncOrc Font oFon4
      REDEFINE SAY  oquantid VAR vquantid ID 4005 of oDlgIncOrc Font oFon4
      REDEFINE SAY  oprvenda var transf(vprvenda,"@E &VPICT001")  ID 4006 of oDlgIncOrc Font oFon4
      REDEFINE SAY  oprecoto var transf(vprecoto,"@E 999,999.99") ID 4007 of oDlgIncOrc Font oFon5
      *
      REDEFINE BUTTONBMP ID 2051 of oDlgIncOrc ACTION( lSavepro := .f.,oDlgIncOrc:end()) BITMAP cbitmaps+"cancela.bmp" Prompt "Cancelar" Cancel
 			 
      Activate Dialog oDlgIncOrc Centered	ON INIT HABILITA_TRANSPARENT (oDlgIncOrc)
      return
      *
      *
      **********************************
      * Função para Volume dos Itens   *
      **********************************
      *
Function IncVolTra(olbxorc)
      local obut1,but2,obut3,lSavepro,oDlgIOrc
      Public vprcalcu,vpassaget:=.f.,vprvenda
      sele ntra
      *
      if vvolumes="S"
         sele itra
         set order to 2
         go top
         vnrpecas=nrpecas+1
         *                                                            290

         Define Font oFon3 Name "LUCIDA CONSOLE" size 0,20
         Define Dialog oDlgIncOrc Resource "DLG_CONSU_TRANSFER_VOL"  BRUSH  oBrusHPAPEL1//mstar4.res
         redefine rbbtn oinfo id 2000 of oDlgIncOrc  prompt "Volumes"  CENTER  adjust saybutton round linecolors CLR_SKY,CLR_AZUL_BRANCO
         set font of oinfo to ofon3
	
         REDEFINE get  onrpecas var vnrpecas ID 2001 of oDlgIncOrc pict "99999.99"
         *
         REDEFINE BUTTONBMP ID 2051 of oDlgIncOrc ACTION( lSavepro := .T.,oDlgIncOrc:end()) BITMAP cbitmaps+"OK.bmp" Prompt "Confirmar" Cancel
 			 
         Activate Dialog oDlgIncOrc Centered	ON INIT HABILITA_TRANSPARENT (oDlgIncOrc)
         xsetfocus(oLbxOrc)
      endif
      return
      *
      //______________________________________________________________________________
Function SomaTra()
         sele itra
         go top
         vitensnf=0
         vtotalbr=0.00
         vquantid:=0
         vdescont:=0
	      do while !eof()
            vtotalbr =round(vtotalbr,2)+round(precoto,2)
            vitensnf := vitensnf+1
            vquantid += quantid
            vdescont += descont
            skip
         enddo
         vtotalbr:=vtotalbr; ototalbr:Refresh()
         vitensnf:=vitensnf; oitensnf:Refresh()
         vquantid:=vquantid; oquantid:Refresh()
         *
         vtotalnf:=vtotalbr-vdescont;ototalnf:Refresh()
         go top
         oLbxOrc:Refresh()            // We want the ListBox to be repainted
         odlg:UpDate()                // update no form principal
         Return(.t.)

      ***************************************************
      * FUNÇÃO PARA GERAR O NUMERO DA TRANSFERENCIA     *
      ***************************************************

Function GeraTraNum
         sele inft
         set order to 1
         go bottom
         if empty(vnumetra)
            vnumetra=strzero(val(numetra)+1,len(numetra),0)
         elseif !empty(vnumetra)
            vnumetra=strzero(val(vnumetra),len(vnumetra),0)
         endif
         seek vnumetra
         if eof()
            altera:=.f.
            append blank
            repl numetra with vnumetra
            dbcommit()
         else
            altera:=.t.
         endif
         vdados1a := space(len(dados1a))
         vdados2a := space(len(dados2a))
         vdados3a := space(len(dados3a))
         vdados4a := space(len(dados4a))
         vdados5a := space(len(dados5a))
         vatencao := space(len(atencao))
         vsetores := space(len(setores))
         vpacient := space(len(pacient))
         vmedicos := space(len(medicos))
         vconveni := space(len(conveni))
         vhospita := space(len(hospita))
         vdatacir := date()
         vinstrum := space(len(instrum))
         if travareg()=.f.
            retu .t.
         endif
         vnumetra=vnumetra;onumetra:Refresh()
         Return .t.
      *
Function CheckTrf()
      sele inft
      set order to 1
      seek vnumetra
      if eof()
         msginfo("Atenção numero não localizado","Atenção")
         return .f.
      endif
      altera:=.t.
		if jaimpre="S"
         if msgyesno("Transferência já foi Impressa, Deseja continuar e alterar ?")
            * nao faz nada
         else
            retu .f.
         endif
      endif
         
      if travareg()=.f.
         retu .t.
      endif
         
      vnumetra:=numetra; onumetra:Refresh()

      vcodicli:=codicli
      vnomecli:=nomecli
         
      If vmateliv="S"
         vcodiven:=codicli; ocodiven:Refresh()
         vnomeven:=nomecli; onomeven:Refresh()
         vcodifor:=vcodiven    // variavel para gravacao - reaproveitada
         vnomefor:=vnomeven    // variavel para gravacao - reaproveitada
         vcodicli:=codicli    // variavel para gravacao - reaproveitada
         vnomecli:=nomecli    // variavel para gravacao - reaproveitada
      Else
         If vmatetex="S"
            vcodicli:=codicli; ocodicli:Refresh()
            vnomecli:=nomecli; onomecli:Refresh()
            vcodifor:=vcodicli  // variavel para gravacao - reaproveitada
            vnomefor:=vnomecli  // variavel para gravacao - reaproveitada
         Else
            vcodifor:=vcodicli
            vnomefor:=vnomecli
            *              vcodicli:=vcodifor    // variavel para gravacao - reaproveitada
            *              vnomecli:=vnomefor    // variavel para gravacao - reaproveitada
         Endif
      Endif

      If vpedifun="S"
         vcodifun:=codifun//; ocodifun:Refresh()
      Endif
         
      vdatatra:=datatra; odatatra:Refresh()
      vdescont:=descont; odescont:Refresh()
      vdados1a:=dados1a; odados2a:Refresh()
      vdados2a:=dados2a; odados2a:Refresh()
      vdados3a:=dados3a; odados3a:Refresh()
      vdados4a:=dados4a; odados4a:Refresh()
      vdados5a:=dados5a; odados5a:Refresh()
      IF VMATEMED="S"
         vatencao:=atencao; odados100a:Refresh()
         vsetores:=setores; odados101a:Refresh()
         vpacient:=pacient; odados102a:Refresh()
         vmedicos:=medicos; odados103a:Refresh()
         vconveni:=conveni; odados104a:Refresh()
         vhospita:=hospita; odados105a:Refresh()
         vdatacir:=datacir; odados106a:Refresh()
         vinstrum:=instrum; odados107a:Refresh()
      ENDIF
      if vpedifun="S"
         sele fun
         set order to 1
         seek vcodifun
         vnomefun:=nomefun//;onomefun:Refresh()
      endif
      sele inft
      acemod2("Alterou Transferência Nr:"+vnumetra)
      sele inft
      If vtipotra = "C"  // consignação
         oDlg:SetText("C O N S I G N A Ç Ã O       D E   S A Í D A -  Alteração")
      Else
         oDlg:SetText("T R A N S F E R Ê N C I A   D E   S A Í D A -  Alteração")
      Endif
      * Banco de Dados de Itens Fixos da Transferencia
      sele itra
      set order to 1
      seek vnumetra
      do while !eof() .and. numetra=vnumetra
         if travareg()=.f.
            skip
            loop
         endif
         dele 
         skip
      enddo
      sele ntra
      set order to 1
      seek vnumetra
      do while !eof() .and. numetra=vnumetra
         sele itra
         append blank
         repl numetra with ntra->numetra
         repl datatra with ntra->datatra
         repl codipro with ntra->codipro
         repl quantid with ntra->quantid
         repl prvenda with ntra->prvenda
         repl prcusre with ntra->prcusre
         repl codicli with ntra->codicli
         repl precoto with ntra->precoto
         repl baixarp with ntra->baixarp
         repl baixarf with ntra->baixarf
         repl descont with ntra->descont
         repl pranter with ntra->pranter
         repl faturar with ntra->faturar
         repl nrlotes with ntra->nrlotes
         repl nrpecas with ntra->nrpecas
         repl ordemit with ntra->ordemit
         repl codifun with ntra->codifun
         repl situtri with ntra->situtri
         repl nomepro with ntra->nomepro
         repl cserial with ntra->cserial
         repl dataval with ntra->dataval
         repl nrlotes with ntra->nrlotes
         sele ntra
         skip
      enddo
      SomaTra()
      sele inft
      ototalnf:Refresh()
      sele itra
   *   set filter to numetra=vnumetra
      go top
      if !eof()
         if altera
            vnrpecas=nrpecas
         endif
      endif
      oFld:setfocus()
      return .t.

Function Nomprotra
   sele pro
   set order to 1
   if ! empty( itra->codipro )
      if empty(itra->nomepro)
         Pro->( DbSeek( itra->codipro ) )
         xnomepro:=Pro->Nomepro
      else
         xnomepro := itra->nomepro
      endif
   else
      xnomepro := space(len(pro->nomepro))
   Endif
   sele itra
   Return xnomepro
   *
Function Abre_DbfTra()
   *********************************
   * INFORMAÇÃO DE TRANSFERENCIA   *
   * Informações Transferência     *
   *********************************
   use inftran shared new alias inft
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to inftran
   **********************************************
   * Informações Itens Fixos da Transferencia   *
   **********************************************
   use ntransf shared new alias ntra
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to ntransf
   *********************************
   * Informações Orcamento         *
   *********************************
   use inforca shared new alia ior
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to inforca
   use vendedor shared new alia ven
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to vendedor
   use planoven shared new alia pla
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to planoven
   use clientes shared new alia cli
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to clientes
   use produtos shared new alia pro
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to produtos
   use usuarios shared new alia usu
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to usuarios
   use acemod shared new alia ace
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to acemod
   use situtri shared new alia tri
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to situtri
   use veiculos shared new alia vei
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to veiculos
   use empresas shared new alia emp
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   use marca shared new alia mar
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to marca
   use funciona shared new alia fun
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to funciona
   use moviment shared new alia mov
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to moviment
   **
   use rmovient shared new alias rmo
   if neterr()
      msginfo("Arquivo está em uso em modo exclusivo","Informação")
      close data
      retu
   endif
   set index to rmovient
   use fornece shared new alias for
   if neterr()
      msginfo("Arquivo está em uso em modo exclusivo","Informação")
      close data
      retu
   endif
   set index to fornece
   use nfisent shared new alias nfe
   if neterr()
      msginfo("Arquivo está em uso em modo exclusivo","Informação")
      close data
      retu
   endif
   set index to nfisent
   ***********************************************
   * Informação das Transferencias de Entradas   *
   ***********************************************
   use inftrae shared new alias infe
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to inftrae
   ***********************************************
   * Itens Fixos das Transferencias de Entradas  *
   ***********************************************
   use etransf shared new alias etra
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to etransf
   * movimentos dos clientes
   use ccorcli shared new alias cccli
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to ccorcli
   * contas a receber
   use receber shared new alias rec
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to receber
   * cheques
   use cheques shared new alias chq
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to cheques
			
   use atividad shared new alias ati
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to atividad
         
   use rotas shared new alias rot
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to rotas
         
   use municip shared new alias mun
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to municip
         
   use vendedo2 shared new alias ven2
   if neterr()
      mendisp()
      close data
      retu .f.
   endif
   set index to vendedo2
   *
   use assocrep alias arep new shared
   if neterr()
      msginfo("Arquivo está em uso em modo exclusivo","Informação")
      close data
      retu
   endif
   set index to assocrep
   *
   use represe alias rep new shared
   if neterr()
      msginfo("Arquivo está em uso em modo exclusivo","Informação")
      close data
      retu
   endif
   set index to represe
         
   Return .T.

   *-*-*-*-*-*-*-*-*-*-*-*-*-
   *- CLIENTE NEGATIVADO    -
   *-*-*-*-*-*-*-*-*-*-*-*-*-
   *
Function CliNegTrf()
   Public vdesccli
   sele cli
   set order to 1
   seek vcodicli
   if !empty(negativ)
      msgalert("Cliente (-), Consultar a Gerência !!!","Atenção")
      retu .f.
   endif
   vdesccli=desccli
   retu .t.
   *
Function PreIncTra()

   Priv xquantid
         
   if !empty(vcodipro)
      vcodipro=strzero(val(vcodipro),len(vcodipro),0)
   endif
         
   sele pro
   set order to 1
   seek vcodipro
         
   If Eof()
      MsgStop("Atenção, Código não Localizado !!!","Informação")
      go top
      Pesqpro()
   Endif
         
   * alterado em 07/05/2010   - Amauri
         
   If pro->prodoci = "S"
      MsgStop("Produto Marcado como Desativado, Transferência não permitida","Atenção")
      Return .F.
   Endif
         
   * alterado em 07/05/2010   - Amauri

   If vsomaped="S"
      sele itra
      go top
      locate for codipro=vcodipro
      If ! eof()
         If altera
            MsgStop("Já Existe este código lançado , Atenção Operação não permitida para alteração transferência, exclua o item lançado e digite o item novamente !!!")
            Return .F.
         Endif
         *               vquantia=quantid
         *               vnrpecaa=nrpecas
         *               vquantid=vquantid+vquantia
         *               vnrpecas=vnrpecas+vnrpecaa
      Endif
   Endif
   sele pro
   vcodipro:=pro->codipro; ocodipro:Refresh()
    vnomepro:=pro->nomepro; onomepro:Refresh()
    vdescpro:=pro->descpro
   vprcusre:=pro->prcusre
   *
   vunidade:=pro->unidade; ounidade:Refresh()
    *
   vprvenda:=pro->prcusto; oprvenda:Refresh()
    vdescpro=descpro
   xprvenda=prvenda
   vprpromo=prpromo
         
   *xprvenda=vprvenda
         
   vquantig:=pro->quantig; oquantig:Refresh()
    xquantid:=pro->quantid

   * livros  / material medico
         
   If vmateliv="S" .or. vmatemed="S" .or. vmatetex="S" .or. vtranprv="S"
      xprvenda=prvenda; oprvenda:Refresh()
      vprvenda=prvenda; oprvenda:Refresh()
      If prpromo#0
         xprvenda=prpromo; oprvenda:Refresh()
         vprvenda=prpromo; oprvenda:Refresh()
      Endif
   Endif

   * consignacao / material textil
        
   * verifica se o preço de venda ficou menor que o preço com desconto
	      
   If vprvenda < vprdesct
      vdescosn="N"
   Endif
         
   * verifica a promoção
          
   If vprpromo>0
      vdescosn="N"
   Endif
         
   Return .T.
   *
   *************************************
   * Função Desconto na transferencia  *
   *************************************
Function DescTrfPerc
   sele ior
   if vaplic#0.00
      vdescon2:=round(vtotalnf,2)*round(vaplic,2)/100; odescon2:Refresh()
    endif
   vtotalnf:=round(vtotalnf,2)-round(vdescon2,2); ototalor:Refresh()
    retu .t.
   *
Function Qtd_Tra(vunidade,oGet,cQua)
   if vunidade="TB" .or. vunidade="SC" .or. vunidade="PR" .or. vunidade="PÇ" .or. vunidade="PC" .or. vunidade="GL" .or. vunidade="RL" .or. vunidade="CX" .or. vunidade="LA" 
      cqua:=0
      oGet:cPicture:="999999999"
      oGet:oGet:Picture:="999999999"
      oGet:Refresh()
   else
      cqua:=0
      oGet:cPicture:="99999.999"
      oGet:oGet:Picture:="99999.999"
      oGet:Refresh()
   endif
   Return(.t.)
   *
Function TrQtdPrcT1(vquantid,vprvenda)
   vprecoto:=vquantid*vprvenda
   vprecoto:=vprecoto;oprecoto:Refresh()
    if vquantid<=0
   IF GetASyncKey( VK_UP )=.f.
      msginfo("Atenção Quantidade não pode ser menor ou igual a Zero !!!","Informação")
      return(.f.)
   endif
   endif
   if vquantig<vquantid
      if vpediest="N"
         msginfo("O Estoque atual é "+transf(vquantig,"9999999.999")+",esta abaixo do solicitado , transação não autorizada","Informação")
         vquantid:=0;oquantid:Refresh()
          xsetfocus(oquantid)
         return(.f.)
      else
         msginfo("O Estoque atual é "+transf(vquantig,"9999999.999")+",esta abaixo do solicitado","Informação")
      endif
   endif
   vpranter:=prvenda
   vpassagetqtd:=.t.
         
   * testa as outras dialogs remanescentes
   Testa_If()
         
   Return(.t.)
   *
Function TrQtdPrcT2()
   *
   Local oDlgTela2
   *
   lSaida    = .f.
   vpassaget = .t.
   vpranter  = vprvenda
   *
   If vmatetex="S"
      If vprvenda<xprvenda
         msginfo("Preço usado na Transferência "+transf(vprvenda,"@E 999,999.9999")+",não pode ser menor que o Preço de Compra "+transf(xprvenda,"@E 999,999.9999")+"","Informação")
         retu .f.
      Endif
   Endif
   *
   *
   If vdescpro#0                                   // DESCONTO
      vant=vdescpro
      *
      Define Font oFon3 Name "LUCIDA CONSOLE" size 0,20
      Define Dialog oDlgTela2 Resource "DLG_CONSU_TRQTDPRCT2"  BRUSH  oBrusHPAPEL1//mstar4.res
      redefine rbbtn oinfo id 2000 of oDlgTela2  prompt "Desconto"  CENTER  adjust saybutton round linecolors CLR_SKY,CLR_AZUL_BRANCO
      set font of oinfo to ofon3
      *
      REDEFINE get  odescpro var vdescpro ID 2001 of oDlgTela2 pict "999.99%"
      *
      REDEFINE BUTTONBMP ID 2050 of oDlgTela2 ACTION ( oDlgTela2:End()) BITMAP cbitmaps+"OK.bmp" Prompt "Confirmar" Cancel
 			 
      Activate Dialog oDlgTela2 Centered
      vprvenda=round(vprvenda-((vprvenda*vdescpro)/100),2)
   Endif
   If vpefatur="S"
      Define Font oFon3 Name "LUCIDA CONSOLE" size 0,20
      Define Dialog oDlgTela2 Resource "DLG_CONSU_TRQTDPRCT2"  BRUSH  oBrusHPAPEL1//mstar4.res
      redefine rbbtn oinfo id 2000 of oDlgTela2  prompt "Faturar"  CENTER  adjust saybutton round linecolors CLR_SKY,CLR_AZUL_BRANCO
      set font of oinfo to ofon3
      *
      REDEFINE get  ofaturar var vfaturar ID 2001 of oDlgTela2 pict "99999.99"
      *
      REDEFINE BUTTONBMP ID 2050 of oDlgTela2 ACTION ( oDlgTela2:End()) BITMAP cbitmaps+"OK.bmp" Prompt "Confirmar" Cancel
 			 
      Activate Dialog oDlgTela2 Centered
   Endif
   If vpelotes="S"
      Define Font oFon3 Name "LUCIDA CONSOLE" size 0,20
      Define Dialog oDlgTela2 Resource "DLG_CONSU_TRQTDPRCT2"  BRUSH  oBrusHPAPEL1//mstar4.res
      redefine rbbtn oinfo id 2000 of oDlgTela2  prompt "Nº Lotes"  CENTER  adjust saybutton round linecolors CLR_SKY,CLR_AZUL_BRANCO
      set font of oinfo to ofon3
      *
      REDEFINE get  onrlotes var vnrlotes ID 2001 of oDlgTela2 pict "@!"
      *
      REDEFINE BUTTONBMP ID 2050 of oDlgTela2 ACTION ( oDlgTela2:End()) BITMAP cbitmaps+"OK.bmp" Prompt "Confirmar" Cancel
 			 
      Activate Dialog oDlgTela2 Centered
   Endif
   vprvenda:=vprvenda;oprvenda:Refresh()
    vprecoto:=vquantid*vprvenda
   vprecoto:=vprecoto;oprecoto:Refresh()
    *
   Return(.t.)
   *
   *
Function DescTra()
   local obut1,but2,obut3,lSavepro,oDlgIOrc
   
   Priv oaplic,vaplic
   
   lsavepro=.f.
   vtotalnf1=round(vtotalnf,2)
   
   while .t.
      
      vaplic=0
      vdescon1=0.00
      vdescon2=vdescont
         
      Define Font oFon3 Name "LUCIDA CONSOLE" size 0,20
      Define Font oFon5 Name "Times New Roman" size 0,-20 bold
      Define Dialog oDlgIncOrc Resource "DLG_CONSU_TRANSFER_DESC"  BRUSH  oBrusHPAPEL1//mstar4.res
      redefine rbbtn oinfo id 2000 of oDlgIncOrc  prompt "Desconto Geral"  CENTER  adjust saybutton round linecolors CLR_SKY,CLR_AZUL_BRANCO
      set font of oinfo to ofon3
	
      REDEFINE SAY  Ototalbr VAR Vtotalbr ID 4005 of oDlgIncOrc Font oFon5 PICT "@E 99,999,999.99"
      REDEFINE get  oaplic var vaplic     ID 2001 of oDlgIncOrc pict "999.99" valid DscTrfPerc()
      REDEFINE get  odescon2 var vdescon2 ID 2002 of oDlgIncOrc pict "@E 99,999,999.99"
      *
      REDEFINE BUTTONBMP ID 2050 of oDlgIncOrc ACTION( lSavepro := .T.,oDlgIncOrc:end()) BITMAP cbitmaps+"OK.bmp" Prompt "Confirmar"
      REDEFINE BUTTONBMP ID 2051 of oDlgIncOrc ACTION( lSavepro := .f.,oDlgIncOrc:end()) BITMAP cbitmaps+"cancela.bmp" Prompt "Cancelar" Cancel
 			 
      Activate Dialog oDlgIncOrc Centered	ON INIT HABILITA_TRANSPARENT (oDlgIncOrc)
      *
      if lSavepro
         vdescont=vdescon2;odescont:Refresh()
         if travareg()
            repl descont with vdescont
         endif
      else
         vdescont=0;odescont:Refresh()
       endif
         
      SomaTra()
         
      exit
         
   end

   oLbxOrc:Refresh()            // We want the ListBox to be repainted
      
   xsetfocus(oLbxOrc)
   
   return .t.
   
Function DscTrfPerc

   local xcancelou := .F.
   
   * solicita usuario e senha autorizadora
  
   If vaplic > vpemaxde .and. nivel#"1"
      MsgInfo("Percentual Excedido Necessita Autorização ","Atenção")
      IF ! Autorizar(@xcancelou)
         Return .F.
      Endif
   Endif
  
   IF xcancelou
      Return .F.
   ENDIF

   sele itra
         
   If vaplic != 0.00
      vdescon2:=round(vtotalnf,2)*round(vaplic,2)/100; odescon2:Refresh()
    Endif
   
   vtotalnf -= round(vdescon2,2); ototalnf:Refresh()
  
    sysrefresh()
      
   Return .T.
         
Function Lanca_Trf()

   obtn01:refresh()
   obtn03:refresh()
   obtn04:refresh()
   obnt06:refresh()
   obnt07:refresh()
   obnt08:refresh()
   
   obtn01:enable()
   obtn03:enable()
   obtn04:enable()
   obnt06:enable()
   obnt07:enable()
   obnt08:enable()
   

   IF ! lvalidcli
      vcodicli := SPACE(06)
      ocodicli:Refresh()
      lvalidcli := .T.
      Return .F.
   ENDIF

   if vcod_ref="N"
      IncProTra(olbxorc)
   elseif vcod_ref="S"
      RefProTra(olbxorc)
   endif
   retu .t.
   *
   *
   * Função para Checar Nota Fiscal de Entrada
   *
   *
Function CheckNfise()

   vnunfent = nunfent
   vcodifor = fornent
	 
   sele rmo
    
   if ! empty(vnunfent)
      vnunfent=strzero(val(vnunfent),len(vnunfent),0)
   endif

   sele rmo
   set order to 3
   seek vnunfent
    
   if eof()
      msgalert("Atenção, Código não localizado !!!","Informação")
      go top
      PesqNfise()
      sele rmo
      set order to 3
      seek vnunfent
   endif
    
   If ! empty(numetra)
      If MsgYesNo("N.Fiscal já capturada pela Transferência Nº:"+numetra+",continua ?")
         * nao faz nada
      Else
         Return .f.
      Endif
   Endif
    
   vnunfent:=rmo->nunfent; onunfent:Refresh()
    vcodifor:=rmo->fornent; ocodifor:Refresh()
    
    Retu .t.
   *
   *
   * Função para Pesquisar Nota Fiscal de Entrada
   *
   *        123456789
   
   //______________________________________________________________________________
Function PesqNfise()

   Para ssalv,vprvenda,vprdesct
   Priv OdlgPesMat,OLbxMat,oBarPesMat
   tOrdem="Codigo"
   ssalv=.f.
   *
   public tOrdens := { "Nome","Codigo","Fantasia","Telefone","Cnpj" }
   sele rmo
   set order to 3
   go top
   *

   *
   Define Font oFon3 Name "LUCIDA CONSOLE" size 0,18
   Define Font oFon4 Name "LUCIDA CONSOLE " size 0,-12
   DEFINE DIALOG oDlgpesmat RESOURCE "DLG_SEARCH_PADRAO" BRUSH  oBrusHPAPEL1  //mstar.res
   REDEFINE RBBTN oInfo ID 400 OF oDlgpesmat  PROMPT "Consulta de Nota Fiscal de Entrada"  CENTER SAYBUTTON ROUND LINECOLORS CLR_SKY,CLR_AZUL_BRANCO
   SET FONT of oInfo to oFon3
   *
   REDEFINE xbrowse oLbxmat                                 ;
    Fields rmo->nunfent,rmo->nomefor,dtoc(rmo->dataent),iif(numrfre#" ","*"," "),rmo->cdfient,transf(rmo->valrent,"@E 999,999.99");
    Headers "Nº NF","Nome do Fornecedor","Data"," ","CFO","Valor";
    Fieldsizes 50,340,70,10,35,90 								;
    ALIAS "rmo"                    				            ;
    ID 361 OF oDlgpesmat          			               ;
    COLORS CLR_GREEN , CLR_SKY                            ;
    FONT oFon4            					                  ;
    ON right CLICK  (ssalv:=.T.,oDlgpesmat:End())         ;
    ON DBLCLICK (ssalv:=.T., oDlgpesmat:End() )           ;
	
    oLbxmat:aCols[6]:nHeadStrAlign:=1
   oLbxmat:aCols[6]:nDataStrAlign:=1

   oLbxmat:bKeyChar := {|nKey| IIF ( nKey == VK_RETURN, ( (ssalv:=.T.,oDlgpesmat:End()) ), ) }
   oLbxmat:nMarqueeStyle       := 5
   oLbxmat:nColDividerStyle    := LINESTYLE_BLACK
   oLbxmat:nRowDividerStyle    := LINESTYLE_BLACK
   oLbxmat:lColDividerComplete := .T.
   oLbxmat:lFastEdit           := .T.
	
   REDEFINE BUTTON ID 300  OF oDlgpesmat ACTION Psq2ConsNf(olbxmat) prompt "&Numero NF"           //  tooltip "Pesquisar Código"
   REDEFINE BUTTON ID 4004 OF oDlgpesmat ACTION Psq2ConsNm(olbxmat) prompt "&Nome"   //  tooltip "Pesquisar Nome"
   *
   REDEFINE buttonbmp BORDER ROUND ID 25 OF oDlgpesmat ACTION (ssalv:=.T.,oDlgpesmat:End())  BITMAP cbitmaps+"ok.bmp" PROMPT  "&Capturar"  tooltip "Capturar"
   REDEFINE buttonbmp BORDER ROUND ID 26 OF oDlgpesmat ACTION (ssalv:=.f.,oDlgpesmat:End())  BITMAP cbitmaps+"cancela.bmp"   PROMPT  "Retornar"   tooltip "Retorna sem Capturar"
	
   REDEFINE COMBOBOX oOrdem var tOrdem ITEMS tOrdens  ID 4003 OF oDlgpesmat on change ConsuFor1Ord(tOrdem,oLbxmat)
	
   Activate Dialog oDlgpesmat Centered
   if ssalv
      vnunfent:=rmo->nunfent; onunfent:Refresh()     && Variavel do Numero da NF entrada vai recever o numero e atualiza o numero da nota
       vcodifor:=rmo->fornent; ocodifor:Refresh()
       *
      xsetfocus(oCodifor)
   endif
   return .t.
         
         
   //------------------------------------------------------------//
Function Testa_IF()

   local oget01 , oget02
   local osay01 , osay02

   local lmostra  := .F.

   lSaveIf        := .F.

   DEFINE FONT   oFontBotao NAME     "Times New Roman" SIZE 0,-11
   DEFINE FONT   oFont01    NAME     "Arial"           SIZE 0,-10
   DEFINE DIALOG oGeraIf    RESOURCE "DLG_IF" brush obrushpapel1

   * material medico

   If vmatemed == "S"

      lmostra := .T.
   
      REDEFINE SAY osay01 PROMPT "Serial"            ID 500 OF oGeraIf  UPDATE
      oSay01:setfont(oFont01)

      REDEFINE SAY osay02 PROMPT "Data de Validade"  ID 501 OF oGeraIf  UPDATE
      oSay02:setfont(oFont01)
    
      REDEFINE GET      oget01 VAR vcserial PICTURE "@!"  ID 400 OF oGeraIf  UPDATE
      REDEFINE DTPicker oGet02 VAR vdataval               ID 401 OF oGeraIf  UPDATE

      REDEFINE BUTTONBMP ID 100 OF oGeraIf ACTION( lSaveIf := .T. , oGeraIf:End() ) BITMAP cbitmaps+"sav.bmp"  PROMPT "&Salvar"
      REDEFINE BUTTONBMP ID 200 OF oGeraIf ACTION( lSaveIf := .F. , oGeraIf:End() ) BITMAP cbitmaps+"ret.bmp"  PROMPT "&Retornar"
 
      ACTIVATE DIALOG oGeraIf   ON INIT(oSay02:SHOW(),oGet02:SHOW() ,habilita_transparent(oGeraIf)) CENTERED
   
   Endif

   Return .T.

   //----------------------------------------------------------------------------------------
Function Apura_Saldo()

   cli->( DBSEEK( vcodicli ) )

   tcredito = cli->faturam
   tneg     = .f.
   entracc  = 0
   saidacc  = 0
   saldocc  = 0
   tatrrec  = 0.00
   treceber = 0.00
   tatrchq  = 0.00
   trecechq = 0.00
   if vmatetex="S"
      sele cccli
      set order to 1
      seek vcodicli
	
      While ! eof() .and. codicli == vcodicli
         If tipomov="E"
            entracc += valormo
         Elseif tipomov="S"
            saidacc += valormo
         Endif
         Dbskip()
      End
   
      saldocc = entracc - saidacc
   
      * a receber
   
      sele rec
      set order to 2
      go top
   
      seek vcodicli
   
      While codicli == vcodicli .and. ! eof()
         If !empty(datapag)
            skip
            loop
         Endif
         treceber += valorve
         If dataven >= vdatatra
            skip
            loop
         Endif
         If (vdatatra-dataven) < vdiastol
            skip
            loop
         Endif
         tatrrec += valorve
         Dbskip()
      End

      * cheques a prazo
	      
      sele chq
      set order to 12
      go top
      seek vcodicli
      While codicli == vcodicli .and. ! eof()
         If ! empty(datapag)
            Dbskip()
            Loop
         Endif
         trecechq += valorch
         If vencime >= vdatatra
            Dbskip()
            Loop
         Endif
         If ( vdatatra - vencime) < emp->diastch
            skip
            loop
         Endif
         tatrchq += valorch
         Dbskip()
      End
   endif
   vlimite = tcredito-(treceber+trecechq)
   ocredito:Refresh()
   orecechq:Refresh()
   oreceber:Refresh()
   olimite:Refresh()
   osaldocc:Refresh()

   Return .T.

   //----------------------------------------------------------------------------------------
Function Enche_Var()
   // Funcao criada para atualizar as variaves de pesquisa de codigo , para nao ter a necessidade de se repetir no programa
   If vmateliv="S"
      vcodifor:=vcodiven    // variavel para gravacao - reaproveitada
      vnomefor:=vnomeven    // variavel para gravacao - reaproveitada
      vcodicli:=vcodiven    // variavel para gravacao - reaproveitada
      vnomecli:=vnomeven    // variavel para gravacao - reaproveitada
   Else
      If vmatetex="S"
         vcodifor:=vcodicli  // variavel para gravacao - reaproveitada
         vnomefor:=vnomecli  // variavel para gravacao - reaproveitada
         vcodiven:=vcodicli  // variavel para gravacao - reaproveitada
         vnomeven:=vnomecli  // variavel para gravacao - reaproveitada
      Else
         vnomefor:=vnomecli  // variavel para gravacao - reaproveitada
         vcodifor:=vcodicli  // variavel para gravacao - reaproveitada
         vcodiven:=vcodicli  // variavel para gravacao - reaproveitada
         vnomeven:=vnomecli  // variavel para gravacao - reaproveitada
      Endif
   Endif
   If vpedifun="S"
      vcodifun:=codifun//; ocodifun:Refresh()
   Endif
   Return .T.
	*
Function HIDE_FUN()
   if vpedifun="S"
      otext5:SHOW()
      ocodifun:SHOW()
      onomefun:SHOW()
   else
      otext5:HIDE()
      ocodifun:HIDE()
      onomefun:HIDE()
   endif
   Return .t.

Function Transf_Ref_Pro(oLbxorc)
   sele pro
   cPesq=space(len(pro->referen))
   IF MsgGet( "Procura", "Digite a Referência", @CPesq,cbitmaps+"LUPA.BMP")
      sele pro
      SET ORDER TO 7
      SEEK ALLTRIM(UPPER(cPesq))
      IF EOF()
         MSGINFO("Referência não Localizada !!!","Informação")
         sele itra
         go top
         oLbxorc:Refresh()
      ELSE
         sele itra
         go top
         locate for codipro=pro->codipro
         oLbxorc:Refresh()
         xsetfocus(oLbxorc)
      ENDIF
   ENDIF
   sele itra
   oLbxorc: refresh()
   return .t.