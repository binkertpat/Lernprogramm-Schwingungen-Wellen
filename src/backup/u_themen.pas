unit u_themen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { Tthemen }

  Tthemen = class(TForm)
    B_zurueck: TButton;
    Button7: TButton;
    B_bilder: TImage;
    B_vor: TButton;
    Label1: TLabel;
    T_untertitel: TLabel;
    Panel1: TPanel;
    procedure Button7Click(Sender: TObject);
    procedure B_vorClick(Sender: TObject);
    procedure B_zurueckClick(Sender: TObject);
  private

  public

  end;

var
  themen: Tthemen;

implementation
uses u_start;
{$R *.lfm}

{ Tthemen }

procedure Tthemen.Button7Click(Sender: TObject);
begin
  themen.close;
  start.show;
end;

procedure Tthemen.B_vorClick(Sender: TObject);
begin
  themenbilder(start.thema+1);
  start.thema:=start.thema+1;
end;

procedure Tthemen.B_zurueckClick(Sender: TObject);
begin
  themenbilder(start.thema-1);
  start.thema:=start.thema-1;
end;

end.

