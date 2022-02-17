unit u_start;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

procedure themenbilder(n:integer);  //damit ein anderes Formular diese Prozedur mit nutzen kann

type

  { Tstart }

  Tstart = class(TForm)
    B_gw1: TButton;
    B_gw2: TButton;
    B_kraftenergie: TButton;
    B_groessenrelationen: TButton;
    B_gedaempftharmonisch: TButton;
    B_startetest: TButton;
    B_beenden: TButton;
    B_pendel: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    T_ueberschrift: TLabel;
    T_allesverstanden: TLabel;
    T_einfuehrung: TLabel;
    T_untertitel: TLabel;
    P_orange: TPanel;
    P_hgbild: TPanel;
    P_strich: TPanel;
    procedure B_gedaempftharmonischClick(Sender: TObject);
    procedure B_groessenrelationenClick(Sender: TObject);
    procedure B_gw1Click(Sender: TObject);
    procedure B_beendenClick(Sender: TObject);
    procedure B_gw2Click(Sender: TObject);
    procedure B_kraftenergieClick(Sender: TObject);
    procedure B_startetestClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
  var  thema:integer;
  end;

var
  start: Tstart;

implementation
uses u_themen, u_test;  //bindet Bezugsunits ein

{$R *.lfm}

{ Tstart }

procedure themenbilder(n:integer);
begin
  themen.B_bilder.picture:=NIL;   //setzt das Bild auf 'not in list'
  case n of   //für den jeweiligen Button / für das jeweiligw Thema wird das dementsprechende Bild angezeigt
       1: begin
          themen.B_bilder.picture.loadfromfile('bilder/grundwissen1.jpg');  //zeigt Bilder an für jeweilige Themennummer
          start.panel1.Color:=clgreen;
          themen.T_untertitel.caption:='Grundwissen 1';
          end;
       2: begin
          themen.B_bilder.picture.loadfromfile('bilder/grundwissen2.jpg');
          start.panel2.Color:=clgreen;
          themen.T_untertitel.caption:='Grundwissen 2';
          end;
       3: begin
          themen.B_bilder.picture.loadfromfile('bilder/Kraft_Energiebeschreibung.jpg');
          start.panel3.Color:=clgreen;
          themen.T_untertitel.caption:='Kraft und Energiebeschreibung';
          end;
       4: begin
          themen.B_bilder.picture.loadfromfile('bilder/spez_Groessen_relationen.jpg');
          start.panel4.Color:=clgreen;
          themen.T_untertitel.caption:='spezifische Größen und Relationen';
          end;
       5: begin
          themen.B_bilder.picture.loadfromfile('bilder/harmonische_gedaempfte_schwingungen.jpg');
          start.panel5.Color:=clgreen;
          themen.T_untertitel.caption:='harmonische und gedämpfte Schwingungen';
          end;
  end;
  if n=1 then themen.B_zurueck.enabled:=false  //vor und zurück Button werden aktiviert / deaktiviert wenn Bedingung erfüllt
  else themen.B_zurueck.enabled:=true;
  if n=5 then themen.B_vor.enabled:=false
  else themen.B_vor.enabled:=true;
end;

procedure Tstart.B_beendenClick(Sender: TObject);
begin
  close;  //schließt Formular
end;

procedure Tstart.B_gw2Click(Sender: TObject);
begin
  themen.show;
  start.hide;
  thema:=2;  //setzt einen Zähler für das aktuelle Thema auf 2, wichtig für vor und zurück Navigation
  themenbilder(2);  //ruft Themenprozedur mit den Wert 2 auf
end;

procedure Tstart.B_kraftenergieClick(Sender: TObject);
begin
  themen.show;
  start.hide;
  thema:=3;  //setzt einen Zähler für das aktuelle Thema auf 3, wichtig für vor und zurück Navigation
  themenbilder(3);  //ruft Themenprozedur mit den Wert 3 auf
end;

procedure Tstart.B_startetestClick(Sender: TObject);
begin
  wissenstest.show;
  start.hide;
end;

procedure Tstart.FormCreate(Sender: TObject);
begin
  B_pendel.picture.loadfromfile('bilder/pendel_startseite.jpg'); // lädt Pendelbild für Startseite
end;

procedure Tstart.B_gw1Click(Sender: TObject);
begin
  themen.show;
  start.hide;
  thema:=1;  //setzt einen Zähler für das aktuelle Thema auf 1, wichtig für vor und zurück Navigation
  themenbilder(1);  //ruft Themenprozedur mit den Wert 1 auf
end;

procedure Tstart.B_groessenrelationenClick(Sender: TObject);
begin
  themen.show;
  start.hide;
  thema:=4;  //setzt einen Zähler für das aktuelle Thema auf 4, wichtig für vor und zurück Navigation
  themenbilder(4);  //ruft Themenprozedur mit den Wert 4 auf
end;

procedure Tstart.B_gedaempftharmonischClick(Sender: TObject);
begin
  themen.show;
  start.hide;
  thema:=5;  //setzt einen Zähler für das aktuelle Thema auf 5, wichtig für vor und zurück Navigation
  themenbilder(5);  //ruft Themenprozedur mit den Wert 5 auf
end;

end.

