unit u_test;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { Twissenstest }

  Twissenstest = class(TForm)
    B_auswertung: TButton;
    B_check: TButton;
    B_next: TButton;
    B_starten: TButton;
    B_beenden: TButton;
    E_name: TEdit;
    T_fragentext: TLabel;
    T_fragennr: TLabel;
    T_korrekt: TLabel;
    T_wissenstest: TLabel;
    P_orange: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    T_ueberschrift: TLabel;
    T_untertitel: TLabel;
    T_wissenstest1: TLabel;
    procedure B_auswertungClick(Sender: TObject);
    procedure B_beendenClick(Sender: TObject);
    procedure B_checkClick(Sender: TObject);
    procedure B_nextClick(Sender: TObject);
    procedure B_startenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  wissenstest: Twissenstest;

implementation
uses u_start;  //bindet Bezugsunits ein
type Tfragenkatalog = record   //Fragenkatlogrecord
   index: integer;
   frage: string[250];
   antwort1:string[100];
   antwort2:string[100];
   antwort3:string[100];
   loesung:integer;
end;
var datei:file of Tfragenkatalog;
    datensatz: Tfragenkatalog;
    fragen:array [0..14, 0..3] of string;    //Fragen und Antworten
    richtige:array [0..14,0..1] of integer;  //Index und Lösungen
    antwortsch:array[0..14] of integer;   //speichern der Antworten der Schüler
    nameschueler,nameschuel:string;
    fragenzaehler,antwort,punkte,note:integer;
    ergebnisse:textfile;   //Textdateideklaration

{$R *.lfm}

{ Twissenstest }
procedure reseten;
begin
 fragenzaehler:=0;  //initiert die Variablen für neuen Versuch
 punkte:=0;
 wissenstest.B_starten.show;  //initiert Oberfläche für neuen Versuch
 wissenstest.E_name.show;
 wissenstest.T_wissenstest.show;
 wissenstest.T_wissenstest1.show;
 wissenstest.RadioButton1.hide;
 wissenstest.RadioButton2.hide;
 wissenstest.RadioButton3.hide;
 wissenstest.T_fragentext.hide;
 wissenstest.T_fragennr.hide;
 wissenstest.B_check.hide;
 wissenstest.B_next.hide;
 wissenstest.T_korrekt.hide;
 wissenstest.B_auswertung.hide;
 wissenstest.E_name.text:='';
end;

procedure kontrolle;
begin
 wissenstest.B_check.hide;   //verstecke Prüfen-Button
 if wissenstest.radiobutton1.checked then antwort:=1;  //Eingabe der Schülerantwort
 if wissenstest.radiobutton2.checked then antwort:=2;
 if wissenstest.radiobutton3.checked then antwort:=3;
 if richtige[fragenzaehler,1]=antwort then    //Vergleiche Schülerantwort mit Lösung
  begin
    wissenstest.T_korrekt.show;  //Text und Farbe für richtige Lösung
    wissenstest.T_korrekt.caption:='Deine Antwort war richtig!';
    wissenstest.T_korrekt.font.color:=clgreen;
    Inc(punkte);
    antwortsch[fragenzaehler]:=antwort;
  end
 else
 begin
   wissenstest.T_korrekt.show;   //Text und Farbe für falsche Lösung
   wissenstest.T_korrekt.caption:='Deine Antwort war falsch!';
   wissenstest.T_korrekt.font.color:=clred;
   antwortsch[fragenzaehler]:=antwort;
 end;
 if fragenzaehler=14 then
 begin
   wissenstest.B_auswertung.show;
   wissenstest.RadioButton1.checked:=false;
   wissenstest.RadioButton2.checked:=false;
   wissenstest.RadioButton3.checked:=false;
   wissenstest.B_next.hide;
 end
 else wissenstest.B_next.enabled:=true;  //aktiviere Button für die nächste Frage
end;

procedure fragenerzeugen;
begin
 wissenstest.T_fragennr.caption:='Frage ' + inttostr(richtige[fragenzaehler,0]) + ':';  //liest aus dem Array die Antworten, Fragen und den Index ein
 if length(fragen[fragenzaehler,0])>100 then wissenstest.T_fragentext.height:=48
 else wissenstest.T_fragentext.height:=24;
 wissenstest.T_fragentext.caption:=fragen[fragenzaehler,0] + '?';   //füllt Elemente mit Inhalt
 wissenstest.RadioButton1.caption:=fragen[fragenzaehler,1];
 wissenstest.RadioButton2.caption:=fragen[fragenzaehler,2];
 wissenstest.RadioButton3.caption:=fragen[fragenzaehler,3];
end;

procedure Twissenstest.B_beendenClick(Sender: TObject);
begin
 reseten;  //bei beenden wird der Urzustand wiederhergestellt
 wissenstest.close;
 start.show;
end;

procedure Twissenstest.B_auswertungClick(Sender: TObject);
var zeile,dateiname:string; i:integer;
begin
 case punkte of  //berechnet Note
   13..15: note:=1;
   10..12: note:=2;
   8..9: note:=3;
   5..7: note:=4;
   2..4: note:=5;
   0..1: note:=6;
 end;
 case note of    //Panelfarbe für erreichte Note
   1..2: start.panel6.color:=clgreen;
   3..4: start.panel6.color:=clyellow;
   5..6: start.panel6.color:=clred;
 end;
 showmessage('Hallo ' + nameschueler + ', du hast mit ' + inttostr(punkte) + ' Punkten die Note ' + inttostr(note) + ' erreicht!');  //MessageBox mit Punkten und Note
 dateiname:='schuelerergebnisse/ergebnis_'+nameschueler+'.txt';
 assignfile(ergebnisse,dateiname);  //nachfolgend Schreiben in textdatei
 rewrite(ergebnisse);
 zeile:='Ergebnis des Wissenstests für ' + nameschueler + ' :';
 writeln(ergebnisse,zeile);
 zeile:='';
 writeln(ergebnisse,zeile);
 for i:=0 to 14 do
  begin
    zeile:='Frage ' + inttostr(richtige[i,0]) + ' :';  //schreibt Fragen
    writeln(ergebnisse,zeile);
    zeile:=fragen[i,0] + '?';
    writeln(ergebnisse,zeile);
    zeile:='a) ' + fragen[i,1];  //schreibt Antworten
    writeln(ergebnisse,zeile);
    zeile:='b) ' + fragen[i,2];
    writeln(ergebnisse,zeile);
    zeile:='c) ' + fragen[i,3];
    writeln(ergebnisse,zeile);
    if antwortsch[i]=richtige[i,1] then  zeile:='Die Antwort ' + inttostr(richtige[i,1]) + ' war korrekt.' //schreibt Schülerantwort in Abhägngikeit der Richtigkeit
    else zeile:='Die Antwort ' + inttostr(antwortsch[i]) + ' war falsch, richtig wäre ' + inttostr(richtige[i,1]) + ' gewesen!';
    writeln(ergebnisse,zeile);
    zeile:='';
    writeln(ergebnisse,zeile);
  end;
 zeile:='';
 writeln(ergebnisse,zeile);  //schreibt Punkte und Note
 zeile:=nameschueler + ' hat mit ' + inttostr(punkte) + ' Punkten die Note ' + inttostr(note) + ' erreicht!';
 writeln(ergebnisse,zeile);
 closefile(ergebnisse);
 reseten;
 wissenstest.close;
 start.show;
end;

procedure Twissenstest.B_checkClick(Sender: TObject);
begin
kontrolle;  //führt Kontrollprozedur aus
end;

procedure Twissenstest.B_nextClick(Sender: TObject);
begin
 RadioButton1.checked:=false;   //setzt Radiobutton auf unchecked sonst bleibt vorherige Auswahl erhalten
 RadioButton2.checked:=false;
 RadioButton3.checked:=false;
 inc(fragenzaehler);
 T_korrekt.hide;
 B_check.show;
 B_next.enabled:=false;
 fragenerzeugen;
end;

procedure Twissenstest.B_startenClick(Sender: TObject);
var i,j,pos:integer;
begin
 nameschuel:=E_name.text;  //initieert Wissenstestoberfläche
 for i:=1 to length(nameschuel) do
  begin
    if nameschuel[i]=' ' then //überprüft auf Leerezeichen
     begin
       pos:=i;
       for j:=1 to pos-1 do nameschueler:=nameschueler+nameschuel[j];  //liest alles vorm Leerzeichen
       nameschueler:=nameschueler+'_';  //Unterstrich zwischen Vor und Nachname
       for j:=pos+1 to length(nameschuel) do nameschueler:=nameschueler+nameschuel[j]; //liest alles nach dem Leerzeichen
     end;
  end;
 T_fragennr.show;
 T_fragentext.show;
 RadioButton1.show;
 RadioButton2.show;
 RadioButton3.show;
 B_check.show;
 B_next.show;
 B_next.enabled:=false;
 E_name.hide;
 T_wissenstest.hide;
 T_wissenstest1.hide;
 B_starten.hide;
 fragenerzeugen;
 fragenzaehler:=0;  //initiert Variablen
 punkte:=0;
end;

procedure Twissenstest.FormCreate(Sender: TObject);
var i:integer;
begin
 assignfile(datei,'fragen_fuer_quiz.db');    //lesen der Datei
 reset(datei);
 seek(datei,0);
 for i:=0 to 14 do
  begin
   seek(datei,i);  //füllen des Arrays aus typisierter Datei
   read(datei,datensatz);
   fragen[i,0]:=datensatz.frage;
   fragen[i,1]:=datensatz.antwort1;
   fragen[i,2]:=datensatz.antwort2;
   fragen[i,3]:=datensatz.antwort3;
  end;
 for i:=0 to 14 do
  begin
   seek(datei,i);
   read(datei,datensatz);  //füllen des Arrays  aus typisierter Datei
   richtige[i,0]:=datensatz.index;
   richtige[i,1]:=datensatz.loesung;
  end;
 closefile(datei);
end;

end.

