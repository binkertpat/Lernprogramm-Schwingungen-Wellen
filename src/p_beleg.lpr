program p_beleg;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, u_start, u_themen, u_test
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tstart, start);
  Application.CreateForm(Tthemen, themen);
  Application.CreateForm(Twissenstest, wissenstest);
  Application.Run;
end.

