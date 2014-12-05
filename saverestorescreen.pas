unit SaveRestoreScreen;

interface
uses
  crt,graph;
var
     size1:word;
     imag:pointer;

Procedure SaveGraphScreen (xi,yi,xf,yf:integer);
Procedure RestGraphScreen (xi,yi:integer);

implementation


Procedure SaveGraphScreen (xi,yi,xf,yf:integer);
begin
  Size1 := ImageSize(xi,yi,xf,yf);
  GetMem(Imag, Size1);
  GetImage(xi,yi,xf,yf,Imag^);
end; { SaveScreen }


Procedure RestGraphScreen (xi,yi:integer);
begin
  PutImage(xi, yi, Imag^, NormalPut);
  FreeMem(Imag,Size1);
end; { RestScreen }


begin
end.
