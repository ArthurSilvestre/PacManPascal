program Pacman;
uses crt, wincrt, dos, graph, SaveRestoreScreen,sysutils,MMSystem;

Var GraphicsDriver,GraphicsMode:smallint;
Var cTeclaPrecionada,cTeclaPrecionadaMovimento,
    cTeclaPrecionadaCapituraNome:char;
Var tArquivoRank:Text;
Var nTopControleRank,nContaTopCarregaBolas,nControleCarregaBolas,
    nControlaTopPacman,nControlaLeftPacman,nAcumulaPontos:Integer;
Var Conteudo,sNomeJogador:String;
Var aCordenadasBolas:Array[1..1600,1..800] of integer;
Var lFimGame:Boolean;
Var nChecaFimGameX,nChecaFimGameY:Integer;
Var conteudoRank:String;
Var tRanking:Text;
Var aRanking:Array[1..20] of string;
Var nContaRegisRank:Integer;

procedure telainicial;
   begin
     Setcolor(14);
     Circle(683,350,50);
     Setfillstyle(1,14);
     floodfill(684,351,14);
     Setcolor(15);
     Circle(672,330,8);
     Setfillstyle(1,15);
     floodfill(670,325,15);
     Setcolor(0);
     Line(683,355,760,300);
     Line(683,355,760,390);
     Line(727,300,727,400);
     Setfillstyle(1,0);
     Floodfill(720,330,0);
     floodfill(730,330,0);
     Setcolor(0);
     Circle(674,329,3);
     Setfillstyle(1,0);
     Floodfill(675,329,0);
     Circle(672,330,8);
     Setcolor(14);
     OutTextXY(655,470,'PAC MAN');
     OutTextXY(575,500,'Pressione espaco para iniciar.');

     repeat
        cTeclaPrecionada := readkey;
     until cTeclaPrecionada = ' ';
   end;

procedure ConsultaRank;
   Begin
      ClearDevice;
      Assign(tArquivoRank,'./Rank.txt');
      reset(tArquivoRank);
      nTopControleRank:=50;
      OutTextXY(660,20,'RANKING');
      While true do
         Begin
            nTopControleRank:=nTopControleRank+20;
            ReadLn(tArquivoRank,conteudo);
            IF conteudo <> 'Fim' then
               OutTextXY(580,nTopControleRank,conteudo)
            Else
               Break;
         end;
      delay(1000);
      delay(1000);
      delay(1000);
      Close(tArquivoRank);
   end;

procedure SaveRaking(nome,pontos: string);
  Begin
     assign(tRanking,'./rank.txt');
     reset(tRanking);
     nContaRegisRank:=0;

     While true do
        Begin
           nContaRegisRank:=nContaRegisRank+1;
           ReadLn(tRanking,conteudoRank);
           IF conteudoRank <> 'Fim' then
              aRanking[nContaRegisRank]:=conteudoRank
           Else
              Break;
        end;

     For nContaRegisRank:=1 to 20 do
        Begin
           IF aRanking[nContaRegisRank] = '' then
              Begin
                aRanking[nContaRegisRank]:=IntToStr(nContaRegisRank) + ' - ' + nome + Pontos;
                Break;
              end;
        End;

     Rewrite(tRanking);

     For nContaRegisRank:=1 to 20 do
        Begin
           IF aRanking[nContaRegisRank] <> '' then
              Begin
                Writeln(tRanking,aRanking[nContaRegisRank]);
              end;
        End;


     //aRanking
     //aRankingTemp

   end;

Procedure CarregaMapa;
   Begin
      Setcolor(1);
      Rectangle(20,25,35,685);
      Rectangle(1325,25,1340,685);
      Rectangle(20,25,1340,40);
      Rectangle(20,670,1340,685);
      Rectangle(100,570,300,585);
      Rectangle(100,395,115,585);
      Rectangle(1040,570,1255,585);
      Rectangle(1240,395,1255,585);
      Rectangle(1040,120,1255,135);
      Rectangle(1240,120,1255,310);
      Rectangle(100,120,300,135);
      Rectangle(100,120,115,320);
      Rectangle(300,200,315,500);
      Rectangle(1025,200,1040,500);
      Rectangle(300,500,1040,515);
      Rectangle(300,200,500,215);
      Rectangle(840,200,1040,215);
      Setfillstyle(1,1);
      Bar(20,25,35,685);
      Bar(1325,25,1340,685);
      Bar(20,25,1340,40);
      Bar(20,670,1340,685);
      Bar(100,570,300,585);
      Bar(100,395,115,585);
      Bar(1240,395,1255,585);
      Bar(1040,570,1255,585);
      Bar(1040,120,1255,135);
      Bar(1240,120,1255,310);
      Bar(100,120,300,135);
      Bar(100,120,115,320);
      Bar(300,200,315,500);
      Bar(1025,200,1040,500);
      Bar(300,500,1040,515);
      Bar(300,200,500,215);
      Bar(840,200,1040,215);
   end;

Procedure CarregaBolas;
   Begin
     Setcolor(7);
     nContaTopCarregaBolas:=0;
     for nControleCarregaBolas:=1 to 18 do
        Begin
           nContaTopCarregaBolas:=nContaTopCarregaBolas+30;
           aCordenadasBolas[70,70+nContaTopCarregaBolas]:=1;

           Circle(70,70+nContaTopCarregaBolas,5);
           Setfillstyle(1,7);
           floodfill(71,71+nContaTopCarregaBolas,7);
        end;
     nContaTopCarregaBolas:=0;
     for nControleCarregaBolas:=1 to 18 do
        Begin
           nContaTopCarregaBolas:=nContaTopCarregaBolas+30;
           aCordenadasBolas[1300,70+nContaTopCarregaBolas]:=1;

           Circle(1300,70+nContaTopCarregaBolas,5);
           Setfillstyle(1,7);
           floodfill(1301,71+nContaTopCarregaBolas,7);
        end;
     nContaTopCarregaBolas:=0;
     for nControleCarregaBolas:=1 to 40 do
        Begin
           nContaTopCarregaBolas:=nContaTopCarregaBolas+30;
           aCordenadasBolas[70+nContaTopCarregaBolas,100]:=1;

           Circle(65+nContaTopCarregaBolas,100,5);
           Setfillstyle(1,7);
           floodfill(66+nContaTopCarregaBolas,101,7);
        end;
     nContaTopCarregaBolas:=0;
     for nControleCarregaBolas:=1 to 40 do
        Begin
           nContaTopCarregaBolas:=nContaTopCarregaBolas+30;
           aCordenadasBolas[70+nContaTopCarregaBolas,610]:=1;

           Circle(65+nContaTopCarregaBolas,610,5);
           Setfillstyle(1,7);
           floodfill(66+nContaTopCarregaBolas,611,7);
        end;
     nContaTopCarregaBolas:=0;
     for nControleCarregaBolas:=1 to 37 do
        Begin
           nContaTopCarregaBolas:=nContaTopCarregaBolas+30;
           aCordenadasBolas[100+nContaTopCarregaBolas,550]:=1;

           Circle(100+nContaTopCarregaBolas,550,5);
           Setfillstyle(1,7);
           floodfill(101+nContaTopCarregaBolas,551,7);
        end;
     nContaTopCarregaBolas:=0;
     for nControleCarregaBolas:=1 to 37 do
        Begin
           nContaTopCarregaBolas:=nContaTopCarregaBolas+30;
           aCordenadasBolas[100+nContaTopCarregaBolas,160]:=1;

           Circle(100+nContaTopCarregaBolas,160,5);
           Setfillstyle(1,7);
           floodfill(101+nContaTopCarregaBolas,161,7);
        end;
     nContaTopCarregaBolas:=0;
     for nControleCarregaBolas:=1 to 12 do
        Begin
           nContaTopCarregaBolas:=nContaTopCarregaBolas+30;
           aCordenadasBolas[130,160+nContaTopCarregaBolas]:=1;

           Circle(130,165+nContaTopCarregaBolas,5);
           Setfillstyle(1,7);
           floodfill(130,166+nContaTopCarregaBolas,7);
        end;
     nContaTopCarregaBolas:=0;
     for nControleCarregaBolas:=1 to 12 do
        Begin
           nContaTopCarregaBolas:=nContaTopCarregaBolas+30;
           aCordenadasBolas[1210,160+nContaTopCarregaBolas]:=1;

           Circle(1210,165+nContaTopCarregaBolas,5);
           Setfillstyle(1,7);
           floodfill(1210,166+nContaTopCarregaBolas,7);
        end;
   end;

Procedure CarregaFantasmas;
   Begin

     Setcolor(4);
     Circle(130+180,550,10);
     Rectangle(120+180,550,140+180,565);
     Setfillstyle(1,4);
     floodfill(131+180,551,4);
     floodfill(130+180,550,4);
     floodfill(130+180,561,4);
     Setcolor(15);
     Circle(127+180,544,3);
     Circle(133+180,544,3);
     Setfillstyle(1,15);
     floodfill(128+180,543,15);
     floodfill(134+180,543,15);
     Setcolor(0);
     Circle(127+180,544,2);
     Circle(133+180,544,2);
     Setfillstyle(1,0);
     floodfill(128+180,543,0);
     floodfill(134+180,543,0);

     aCordenadasBolas[130+180,550]:=2;


     Setcolor(2);
     Circle(130+180+540,550,10);
     Rectangle(120+180+540,550,140+180+540,565);
     Setfillstyle(1,2);
     floodfill(131+180+540,551,2);
     floodfill(130+180+540,550,2);
     floodfill(130+180+540,561,2);
     Setcolor(15);
     Circle(127+180+540,544,3);
     Circle(133+180+540,544,3);
     Setfillstyle(1,15);
     floodfill(128+180+540,543,15);
     floodfill(134+180+540,543,15);
     Setcolor(0);
     Circle(127+180+540,544,2);
     Circle(133+180+540,544,2);
     Setfillstyle(1,0);
     floodfill(128+180+540,543,0);
     floodfill(134+180+540,543,0);

     aCordenadasBolas[130+180+540,550]:=2;


     Setcolor(5);
     Circle(750+520,100,10);
     Rectangle(740+520,100,760+520,115);
     Setfillstyle(1,5);
     floodfill(751+520,101,5);
     floodfill(750+520,100,5);
     floodfill(750+520,111,5);
     Setcolor(15);
     Circle(747+520,96,3);
     Circle(753+520,96,3);
     Setfillstyle(1,15);
     floodfill(748+520,97,15);
     floodfill(754+520,97,15);
     Setcolor(0);
     Circle(747+520,96,2);
     Circle(753+520,96,2);
     Setfillstyle(1,0);
     floodfill(748+520,97,0);
     floodfill(754+520,97,0);

     aCordenadasBolas[750+520,100]:=2;


     Setcolor(3);
     Circle(750-680,400,10);
     Rectangle(740-680,400,760-680,415);
     Setfillstyle(1,3);
     floodfill(751-680,401,3);
     floodfill(750-680,400,3);
     floodfill(750-680,411,3);
     Setcolor(15);
     Circle(747-680,396,3);
     Circle(753-680,396,3);
     Setfillstyle(1,15);
     floodfill(748-680,397,15);
     floodfill(754-680,397,15);
     Setcolor(0);
     Circle(747-680,396,2);
     Circle(753-680,396,2);
     Setfillstyle(1,0);
     floodfill(748-680,397,0);
     floodfill(754-680,397,0);

     aCordenadasBolas[750-680,400]:=2;

   end;

Procedure CarregaPacMan;
   Begin
     Setcolor(14);
     Circle(70+nControlaLeftPacman,640-nControlaTopPacman,10);
     Setfillstyle(1,14);
     floodfill(70+nControlaLeftPacman,641-nControlaTopPacman,14);
     Setcolor(15);
     Circle(67+nControlaLeftPacman,636-nControlaTopPacman,3);
     Setfillstyle(1,15);
     floodfill(68+nControlaLeftPacman,637-nControlaTopPacman,15);
     Setcolor(0);
     Circle(70+nControlaLeftPacman,640-nControlaTopPacman,10);
     Line(69+nControlaLeftPacman,641-nControlaTopPacman,85+nControlaLeftPacman,625-nControlaTopPacman);
     Line(69+nControlaLeftPacman,641-nControlaTopPacman,85+nControlaLeftPacman,655-nControlaTopPacman);
     Setfillstyle(1,0);
     Floodfill(80+nControlaLeftPacman,642-nControlaTopPacman,0);
     Circle(67+nControlaLeftPacman,636-nControlaTopPacman,1);
     Setfillstyle(1,0);
     Circle(67+nControlaLeftPacman,636-nControlaTopPacman,3);
   end;

Procedure FimDoJogo;
   Begin
     ClearDevice;
     OutTextXY(600,300, 'Fim do Jogo.');
     Delay(500);
     //SaveRaking(sNomeJogador,IntToStr(nAcumulaPontos));
   end;

Procedure MovimentoPacMan;
   Begin
      lFimGame:=False;
      Setcolor(0);
      Bar(1200,10,1300,20);
      Setcolor(14);
      OutTextXY(1200,10,'Pontos: '+ IntToStr(nAcumulaPontos));
      OutTextXY(600,10,'Pressione 2 para sair.');
      While lFimGame = False do
        Begin

           lFimGame:=True;
           For nChecaFimGameX:=1 to 1600 do
              Begin
                 For nChecaFimGameY:=1 to 800 do
                    IF aCordenadasBolas[nChecaFimGameX,nChecaFimGameY] = 1 then
                       lFimGame:=False;
              end;

           IF lFimGame = True then
              Begin
                FimDoJogo;
                Break;
              end
           Else
              Begin
                 cTeclaPrecionadaMovimento:=ReadKey;
                 Case cTeclaPrecionadaMovimento of
                    'a':Begin
                        IF nControlaLeftPacman<30 then
                           MovimentoPacMan;
                        IF ((nControlaLeftPacman =   60) and ( (nControlaTopPacman = 60) or (nControlaTopPacman = 90) or (nControlaTopPacman = 120) or (nControlaTopPacman = 150) or (nControlaTopPacman = 180) or (nControlaTopPacman = 210) or (nControlaTopPacman = 240) or (nControlaTopPacman =330) or (nControlaTopPacman =360) or (nControlaTopPacman =390) or (nControlaTopPacman =420) or (nControlaTopPacman =450) or (nControlaTopPacman =480) or (nControlaTopPacman = 510)))  then
                           MovimentoPacMan;
                        IF ((nControlaLeftPacman = 1200) and ( (nControlaTopPacman = 60) or (nControlaTopPacman = 90) or (nControlaTopPacman = 120) or (nControlaTopPacman = 150) or (nControlaTopPacman = 180) or (nControlaTopPacman = 210) or (nControlaTopPacman = 240) or (nControlaTopPacman =330) or (nControlaTopPacman =360) or (nControlaTopPacman =390) or (nControlaTopPacman =420) or (nControlaTopPacman =450) or (nControlaTopPacman =480) or (nControlaTopPacman = 510)))  then
                           MovimentoPacMan;
                        IF ((nControlaLeftPacman =  270) and ( (nControlaTopPacman = 60) or (nControlaTopPacman = 120) or (nControlaTopPacman = 150) or (nControlaTopPacman = 180) or (nControlaTopPacman = 210) or (nControlaTopPacman = 240) or (nControlaTopPacman = 270) or (nControlaTopPacman = 300) or (nControlaTopPacman =330) or (nControlaTopPacman =360) or (nControlaTopPacman =390) or (nControlaTopPacman =420) or (nControlaTopPacman =450) or (nControlaTopPacman = 510)))  then
                           MovimentoPacMan;
                        IF ((nControlaLeftPacman =  450) and ( (nControlaTopPacman = 420) or (nControlaTopPacman = 450) ))  then
                           MovimentoPacMan;
                        IF ((nControlaLeftPacman =  990) and ( (nControlaTopPacman = 60) or (nControlaTopPacman = 120) or (nControlaTopPacman = 150) or (nControlaTopPacman = 180) or (nControlaTopPacman = 210) or (nControlaTopPacman = 240) or (nControlaTopPacman = 270) or (nControlaTopPacman = 300) or (nControlaTopPacman =330) or (nControlaTopPacman =360) or (nControlaTopPacman =390) or (nControlaTopPacman =420) or (nControlaTopPacman =450) or (nControlaTopPacman = 510)))  then
                           MovimentoPacMan;

                          Setcolor(0);
                          FillEllipse(70+nControlaLeftPacman,640-nControlaTopPacman,10,10);
                          nControlaLeftPacman:=nControlaLeftPacman-30;
                        end;
                    'd':Begin
                          IF nControlaLeftPacman>1200 then
                             MovimentoPacMan;
                          IF ((nControlaLeftPacman =    0) and ( (nControlaTopPacman = 60) or (nControlaTopPacman = 90) or (nControlaTopPacman = 120) or (nControlaTopPacman = 150) or (nControlaTopPacman = 180) or (nControlaTopPacman = 210) or (nControlaTopPacman = 240) or (nControlaTopPacman =330) or (nControlaTopPacman =360) or (nControlaTopPacman =390) or (nControlaTopPacman =420) or (nControlaTopPacman =450) or (nControlaTopPacman =480) or (nControlaTopPacman = 510)))  then
                             MovimentoPacMan;
                          IF ((nControlaLeftPacman = 1140) and ( (nControlaTopPacman = 90) or (nControlaTopPacman = 120) or (nControlaTopPacman = 150) or (nControlaTopPacman = 180) or (nControlaTopPacman = 210) or (nControlaTopPacman = 240) or (nControlaTopPacman =330) or (nControlaTopPacman =360) or (nControlaTopPacman =390) or (nControlaTopPacman =420) or (nControlaTopPacman =450) or (nControlaTopPacman =480)))  then
                             MovimentoPacMan;
                          IF ((nControlaLeftPacman =  210) and ( (nControlaTopPacman = 120) or (nControlaTopPacman = 150) or (nControlaTopPacman = 180) or (nControlaTopPacman = 210) or (nControlaTopPacman = 240) or (nControlaTopPacman = 270) or (nControlaTopPacman = 300) or (nControlaTopPacman =330) or (nControlaTopPacman =360) or (nControlaTopPacman =390) or (nControlaTopPacman =420) or (nControlaTopPacman =450)))  then
                             MovimentoPacMan;
                          IF ((nControlaLeftPacman =  930) and ( (nControlaTopPacman = 60) or (nControlaTopPacman = 120) or (nControlaTopPacman = 150) or (nControlaTopPacman = 180) or (nControlaTopPacman = 210) or (nControlaTopPacman = 240) or (nControlaTopPacman = 270) or (nControlaTopPacman = 300) or (nControlaTopPacman =330) or (nControlaTopPacman =360) or (nControlaTopPacman =390) or (nControlaTopPacman =420) or (nControlaTopPacman =450) or (nControlaTopPacman = 510)))  then
                             MovimentoPacMan;
                          IF ((nControlaLeftPacman =  750) and ( (nControlaTopPacman = 420) or (nControlaTopPacman = 450) ))  then
                             MovimentoPacMan;

                          Setcolor(0);
                          FillEllipse(70+nControlaLeftPacman,640-nControlaTopPacman,10,10);
                          nControlaLeftPacman:=nControlaLeftPacman+30;
                        End;
                    'w':Begin
                          IF nControlaTopPacman>560 then
                             MovimentoPacMan;
                          IF ((nControlaTopPacman = 30) and ((nControlaLeftPacman =  30) or (nControlaLeftPacman =  60) or (nControlaLeftPacman =  90) or (nControlaLeftPacman =  120) or (nControlaLeftPacman =  150) or (nControlaLeftPacman =  180) or (nControlaLeftPacman =  210) or (nControlaLeftPacman =  240) or (nControlaLeftPacman =  960) or (nControlaLeftPacman =  990)  or (nControlaLeftPacman =  1020) or (nControlaLeftPacman =  1050) or (nControlaLeftPacman =  1080) or (nControlaLeftPacman =  1110) or (nControlaLeftPacman =  1140) or (nControlaLeftPacman =  1170))) then
                             MovimentoPacMan;
                          IF ((nControlaTopPacman = 480) and ((nControlaLeftPacman =  30) or (nControlaLeftPacman =  60) or (nControlaLeftPacman =  90) or (nControlaLeftPacman =  120) or (nControlaLeftPacman =  150) or (nControlaLeftPacman =  180) or (nControlaLeftPacman =  210) or (nControlaLeftPacman =  240) or (nControlaLeftPacman =  960) or (nControlaLeftPacman =  990)  or (nControlaLeftPacman =  1020) or (nControlaLeftPacman =  1050) or (nControlaLeftPacman =  1080) or (nControlaLeftPacman =  1110) or (nControlaLeftPacman =  1140) or (nControlaLeftPacman =  1170))) then
                             MovimentoPacMan;
                          IF ((nControlaTopPacman = 90) and ((nControlaLeftPacman >=  240) and (nControlaLeftPacman <=  960))) then
                             MovimentoPacMan;
                          IF ((nControlaTopPacman = 390) and (((nControlaLeftPacman >=  270) and (nControlaLeftPacman <=  420))  or ((nControlaLeftPacman >= 780) and (nControlaLeftPacman <=  960)))) then
                             MovimentoPacMan;
                          IF ((nControlaTopPacman = 300) and (((nControlaLeftPacman =  30) or (nControlaLeftPacman =  1170)))) then
                             MovimentoPacMan;

                          Setcolor(0);
                          FillEllipse(70+nControlaLeftPacman,640-nControlaTopPacman,10,10);
                          nControlaTopPacman:=nControlaTopPacman+30;
                        End;
                    's':Begin
                          IF nControlaTopPacman<30 then
                             MovimentoPacMan;
                          IF ((nControlaTopPacman = 90) and ((nControlaLeftPacman =  30) or (nControlaLeftPacman =  60) or (nControlaLeftPacman =  90) or (nControlaLeftPacman =  120) or (nControlaLeftPacman =  150) or (nControlaLeftPacman =  180) or (nControlaLeftPacman =  210) or (nControlaLeftPacman =  240) or (nControlaLeftPacman =  960) or (nControlaLeftPacman =  990)  or (nControlaLeftPacman =  1020) or (nControlaLeftPacman =  1050) or (nControlaLeftPacman =  1080) or (nControlaLeftPacman =  1110) or (nControlaLeftPacman =  1140) or (nControlaLeftPacman =  1170))) then
                             MovimentoPacMan;
                          IF ((nControlaTopPacman = 540) and ((nControlaLeftPacman =  30) or (nControlaLeftPacman =  60) or (nControlaLeftPacman =  90) or (nControlaLeftPacman =  120) or (nControlaLeftPacman =  150) or (nControlaLeftPacman =  180) or (nControlaLeftPacman =  210) or (nControlaLeftPacman =  240) or (nControlaLeftPacman =  960) or (nControlaLeftPacman =  990)  or (nControlaLeftPacman =  1020) or (nControlaLeftPacman =  1050) or (nControlaLeftPacman =  1080) or (nControlaLeftPacman =  1110) or (nControlaLeftPacman =  1140) or (nControlaLeftPacman =  1170))) then
                             MovimentoPacMan;
                          IF ((nControlaTopPacman = 180) and ((nControlaLeftPacman >=  240) and (nControlaLeftPacman <=  960))) then
                             MovimentoPacMan;
                          IF ((nControlaTopPacman = 480) and (((nControlaLeftPacman >=  270) and (nControlaLeftPacman <=  420))  or ((nControlaLeftPacman >= 780) and (nControlaLeftPacman <=  960)))) then
                             MovimentoPacMan;
                          IF ((nControlaTopPacman = 270) and (((nControlaLeftPacman =  30) or (nControlaLeftPacman =  1170)))) then
                             MovimentoPacMan;

                          Setcolor(0);
                          FillEllipse(70+nControlaLeftPacman,640-nControlaTopPacman,10,10);
                          nControlaTopPacman:=nControlaTopPacman-30;
                        End;
                    '2':lFimGame:=True;
                 End;


                 Setcolor(14);
                 Circle(70+nControlaLeftPacman,640-nControlaTopPacman,10);
                 Setfillstyle(1,14);
                 floodfill(70+nControlaLeftPacman,641-nControlaTopPacman,14);
                 Setcolor(15);
                 Circle(67+nControlaLeftPacman,636-nControlaTopPacman,3);
                 Setfillstyle(1,15);
                 floodfill(68+nControlaLeftPacman,637-nControlaTopPacman,15);
                 Setcolor(0);
                 Circle(70+nControlaLeftPacman,640-nControlaTopPacman,10);
                 Line(69+nControlaLeftPacman,641-nControlaTopPacman,85+nControlaLeftPacman,625-nControlaTopPacman);
                 Line(69+nControlaLeftPacman,641-nControlaTopPacman,85+nControlaLeftPacman,655-nControlaTopPacman);
                 Setfillstyle(1,0);
                 Floodfill(80+nControlaLeftPacman,642-nControlaTopPacman,0);
                 Circle(67+nControlaLeftPacman,636-nControlaTopPacman,1);
                 Setfillstyle(1,0);
                 Circle(67+nControlaLeftPacman,636-nControlaTopPacman,3);

                 IF nControlaLeftPacman >= -70 then
                   Begin
                     Case aCordenadasBolas[70+nControlaLeftPacman,640-nControlaTopPacman] of
                       1:Begin
                           nAcumulaPontos:=nAcumulaPontos+200;
                           aCordenadasBolas[70+nControlaLeftPacman,640-nControlaTopPacman]:= 0;
                         end;
                       2:Begin
                           lFimGame:=True;
                         end;
                     end;
                   end;

                 Setcolor(0);
                 Bar(1200,10,1300,20);
                 Setcolor(14);
                 OutTextXY(1200,10,'Pontos: '+ IntToStr(nAcumulaPontos));
              End;
        end;
   end;

Procedure PegaNomeJogador;
   Begin
      ClearDevice;
      While True do
        Begin
           OutTextXY(500,300,'Digite o nome do jogador e pressione 1.');
           OutTextXY(500,320,'Nome do Jogador: '+sNomeJogador);
           cTeclaPrecionadaCapituraNome:=ReadKey;
           Case cTeclaPrecionadaCapituraNome of
             'a':sNomeJogador:=sNomeJogador+'a';
             'b':sNomeJogador:=sNomeJogador+'b';
             'c':sNomeJogador:=sNomeJogador+'c';
             'd':sNomeJogador:=sNomeJogador+'d';
             'e':sNomeJogador:=sNomeJogador+'e';
             'f':sNomeJogador:=sNomeJogador+'f';
             'g':sNomeJogador:=sNomeJogador+'g';
             'h':sNomeJogador:=sNomeJogador+'h';
             'i':sNomeJogador:=sNomeJogador+'i';
             'j':sNomeJogador:=sNomeJogador+'j';
             'k':sNomeJogador:=sNomeJogador+'k';
             'l':sNomeJogador:=sNomeJogador+'l';
             'm':sNomeJogador:=sNomeJogador+'m';
             'n':sNomeJogador:=sNomeJogador+'n';
             'o':sNomeJogador:=sNomeJogador+'o';
             'p':sNomeJogador:=sNomeJogador+'p';
             'q':sNomeJogador:=sNomeJogador+'q';
             'r':sNomeJogador:=sNomeJogador+'r';
             's':sNomeJogador:=sNomeJogador+'s';
             't':sNomeJogador:=sNomeJogador+'t';
             'u':sNomeJogador:=sNomeJogador+'u';
             'v':sNomeJogador:=sNomeJogador+'v';
             'w':sNomeJogador:=sNomeJogador+'w';
             'x':sNomeJogador:=sNomeJogador+'x';
             'y':sNomeJogador:=sNomeJogador+'y';
             'z':sNomeJogador:=sNomeJogador+'z';
             ' ':sNomeJogador:=sNomeJogador+' ';
             '1':Begin
                   sNomeJogador:=Copy(sNomeJogador,1,20);
                   Break;
                 end;
           end;
        end;
   end;

Procedure IniciaJogo;
   Begin
     nControlaTopPacman:=0;
     nControlaLeftPacman:=0;
     nAcumulaPontos:=0;
     sNomeJogador:='';

     ClearDevice;
     PegaNomeJogador;
     ClearDevice;
     CarregaMapa;
     CarregaBolas;
     CarregaFantasmas;
     CarregaPacMan;
     MovimentoPacMan;
   end;

procedure MenuDeOpcoes;
   Begin

     ClearDevice;
     OutTextXY(650,400, '1 - Novo Jogo ');
     OutTextXY(650,450, '2 - Ranking ');
     OutTextXY(650,500, '3 - Sair ');
     repeat
        cTeclaPrecionada := readkey;
        Case cTeclaPrecionada of
           '1':IniciaJogo;
           '2':ConsultaRank;
           '3':break;
        End;
        IF cTeclaPrecionada <> '3' then
          MenuDeOpcoes;
     until true;
   end;

begin
 PlaySound('./Music.WAV',0,SND_ASYNC Or SND_LOOP);

 GraphicsDriver:=Detect;
 InitGraph(GraphicsDriver, GraphicsMode,'');

 telainicial;
 MenuDeOpcoes;
end.
