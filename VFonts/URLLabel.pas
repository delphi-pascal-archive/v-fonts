unit URLLabel;

// Peric 16.01.2001

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,EXtCtrls,Shellapi;


   {$R URLLabel.res}
type
  TOnMouseOverEvent = procedure(Sender: TObject) of object;
  TOnMouseOutEvent = procedure(Sender: TObject) of object;
  TURLLabel = class(TCustomLabel)
private
  FURL:string;
  FCop: string;
  //FFontname:TFontName;
  FUnderline:Boolean;
  FMouseInPos : Boolean;
  //FFontSize:integer;
  FFColorAfter: TColor;
  FFColorIn: TColor;
  FFColorOut: TColor;
  FOnMouseOver: TOnMouseOverEvent;
  FOnMouseOut: TOnMouseOutEvent;
  procedure CMMouseEnter(var AMsg: TMessage);
  message CM_MOUSEENTER;
  procedure CMMouseLeave(var AMsg: TMessage);
  message CM_MOUSELEAVE;
  procedure SetFontColorin(Value: TColor);
 procedure SetFontColorOut(Value: TColor);
 procedure SetFontColorAfter(Value: TColor);
   //procedure SetFontname(Value: TFontname);
  function GetCop: string;
  procedure SetCop(const Value: string);
  procedure SetURL(AURL: string);
    { Private declarations }
protected
  //procedure SetFontSize(AFontsize:integer);
  procedure setUnderline(aUnderline:boolean);
  procedure Click;override;

    { Protected declarations }
public
  constructor Create(AOwner: TComponent); override;
    { Public declarations }
published
  //property Fontsize:integer
  ////read  FFontsize write SetFontsize default 8;
  property Copyright: string read GetCop write SetCop;
  property URL: string read FURL write SetURL;
  //property Fontname: TFontname read FFontname write SetFontname;
  property FontColorin: TColor read FFColorin write SetFontColorin;
  property FontColorOut: TColor read FFColorOut write SetFontColorOut;
  property FontColorAfter: TColor read FFColorAfter write SetFontColorAfter;
  property OnMouseOver: TOnMouseOverEvent read FOnMouseOver write FOnMouseOver;
  property OnMouseOut: TOnMouseOutEvent read FOnMouseOut write FOnMouseOut;
  property Underline: boolean read FUnderline write setUnderline default true;
    { Published declarations }
  property Parentfont;
  property Font;
  property Alignment;
  property AutoSize;
  property Color;
  property Enabled;
  property ParentColor;
  property ParentShowHint;
  property Transparent;
  property Layout;
  property Visible;

  end;

procedure Register;

implementation

constructor TURLLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //Parentfont:=false;
  //FFontsize:=8;
  //Font.size:=FFontsize;
  FFColorIn:=clBlue;
  FFColorOut:=clBlack;
  FFColorAfter:=clMaroon;
  FCop:='Copyright © 2001 by Peric';
  Cursor:=crHandPoint;
  FURL:='www.PTT.yu';
  Caption:=FURL;
  FUnderline:=true;
  //FFontName:=Font.name;


end;

procedure TURLLabel.click;

var
  AnUrl: array[0..255] of char;
begin
  StrPCopy(AnUrl, 'http://'+caption);
  ShellExecute(Application.Handle, 'open', AnUrl, nil, nil, SW_NORMAL);
  FFColorOut:=FFColorAfter;
end;


{procedure TURLLabel.SetFontsize(AFontsize:integer);

begin

 FFontsize:=AFontsize;
 Font.size:=AFontsize;
end;  }

procedure TURLLabel.CMMouseEnter(var AMsg: TMessage);
begin
  if Assigned(FOnMouseOver) then FOnMouseOver(Self);
  FMouseInPos := True;
  Font.Color := FFColorIn;
  if not enabled then exit;
  if FUnderline
  then Font.Style := Font.Style + [fsUnderline]
  else Font.Style := Font.Style - [fsUnderline];
end;

procedure TURLLabel.CMMouseLeave(var AMsg: TMessage);
begin
  if Assigned(FOnMouseOut) then FOnMouseOut(Self);
  FMouseInPos := False;
  Font.Color := FFColorOut;
  if FUnderline
  then Font.Style := Font.Style + [fsUnderline]
  else Font.Style := Font.Style - [fsUnderline];
end;

procedure TURLLabel.SetURL(AURL: string);
begin
  FURL:=AURL;
  Caption:=AURL;
end;

procedure TURLLabel.SetCop(const Value: string);
begin
  FCop:=FCop;
end;

procedure TURLLabel.setUnderline(AUnderline:boolean);
begin
 FUnderline:= AUnderline;
end;

procedure TURLLabel.SetFontColorin(Value: TColor);
begin
  FFColorin:=Value;
end;

procedure TURLLabel.SetFontColorAfter(Value: TColor);
begin
  FFColorAfter:=Value;
end;


{procedure TURLLabel.SetFontName(Value: TFontname);
begin
  FFontname:=Value;
  font.name:=value;
end; }

procedure TURLLabel.SetFontColorOut(Value: TColor);
begin
  FFColorOut:=Value;
  Font.color:=value;
end; 

function TURLLabel.GetCop: string;
begin
  Result:=FCop;
end;

procedure Register;
begin
  RegisterComponents('[BlueMan] Web', [TURLLabel]);
end;

end.
