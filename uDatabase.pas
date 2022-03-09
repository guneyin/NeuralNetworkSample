unit uDatabase;

interface

Uses System.Classes, System.SysUtils, VCL.Forms, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.DApt, FireDAC.VCLUI.Wait,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Async, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, FireDAC.Stan.Param, uTypes;

type
  CDatabase = class
  private
    FConnection: TFDConnection;
    procedure InitTables;
    function IsTableExists(const TableName: string): Boolean;
    procedure InsertImageRecord(const ImageRecord: TImageRecord);
  public
    procedure SaveImageRecordList(const ImageRecordList: TImageRecordList);
    procedure SetImageRecordList(var ImageRecordList: TImageRecordList; const Limit: Integer = -1);
    procedure SaveImageRecord(const ImageRecord: TImageRecord);
    procedure SetImageRecord(var ImageRecord: TImageRecord);
    procedure Flush;
    constructor Create(const AppPath: string);
  end;

var
  Database: CDatabase;

procedure InitDatabase;

implementation

procedure InitDatabase;
var
  Path: string;
begin
  Path := ExtractFilePath(Application.Exename);

  Database := CDatabase.Create(Path)
end;

{ CDatabase }

constructor CDatabase.Create(const AppPath: string);
begin
  try
    FConnection := TFDConnection.Create(Nil);
    FConnection.Params.Values['DriverID'] := 'SQLite';
    FConnection.Params.Values['Database'] := AppPath + '\database.db';
    FConnection.LoginPrompt := False;
    FConnection.Connected := True;

    InitTables;
  except
  end;
end;

procedure CDatabase.Flush;
begin
  FConnection.ExecSQL('DELETE FROM mnist_dataset');
end;

procedure CDatabase.InitTables;
var
  SQLText: TStrings;
begin
  SQLText := TStringList.Create;

  if IsTableExists('mnist_dataset') = False then
  begin
    SQLText.Clear;
    SQLText.Add('CREATE TABLE mnist_dataset (');
    SQLText.Add('	id INTEGER PRIMARY KEY AUTOINCREMENT,');
    SQLText.Add('	digit CHARACTER(1),');
    SQLText.Add('	value REAL,');
    SQLText.Add('	content CHARACTER(800)');
    SQLText.Add(');');

    FConnection.ExecSQL(SQLText.Text)
  end;

  SQLText.Free;
end;

procedure CDatabase.InsertImageRecord(const ImageRecord: TImageRecord);
var
  q: TFDQuery;
begin
  q := TFDQuery.Create(Nil);
  q.Connection := FConnection;

  q.SQL.Text := 'insert into mnist_dataset (digit, content) values (:digit, :content)';
  q.Params.ParamByName('digit').Value := ImageRecord.Digit;
  q.Params.ParamByName('content').Value := ImageRecord.Content;
  q.ExecSQL;

  q.Free;
end;

function CDatabase.IsTableExists(const TableName: string): Boolean;
var
  q: TFDQuery;
begin
  q := TFDQuery.Create(Nil);
  q.Connection := FConnection;

  q.SQL.Text := Format('SELECT name FROM sqlite_master WHERE type = ''table'' AND name = %s', [QuotedStr(TableName)]);
  q.Open;

  Result := q.RecordCount > 0;

  q.Free
end;

procedure CDatabase.SaveImageRecord(const ImageRecord: TImageRecord);
var
  q: TFDQuery;
begin
  q := TFDQuery.Create(Nil);
  q.Connection := FConnection;

  q.SQL.Text := 'update mnist_dataset set value = :value where id = :id';
  q.Params.ParamByName('value').Value := ImageRecord.Value;
  q.Params.ParamByName('id').Value := ImageRecord.Id;
  q.ExecSQL;

  q.Free;
end;

procedure CDatabase.SaveImageRecordList(const ImageRecordList: TImageRecordList);
var
  ImageRecord: TImageRecord;
begin
  Database.Flush;

  for ImageRecord in ImageRecordList do
    InsertImageRecord(ImageRecord);
end;

procedure CDatabase.SetImageRecord(var ImageRecord: TImageRecord);
var
  q: TFDQuery;
begin
  q := TFDQuery.Create(Nil);
  q.Connection := FConnection;

  q.SQL.Text := 'select * from mnist_dataset limit 1';
  q.Open;

  ImageRecord.Digit := q.FieldByName('digit').Value;
  ImageRecord.Content := q.FieldByName('content').Value;

  q.Close;
  q.Free;
end;

procedure CDatabase.SetImageRecordList(var ImageRecordList: TImageRecordList; const Limit: Integer);
var
  q: TFDQuery;
  ImageRecord: TImageRecord;
begin
  q := TFDQuery.Create(Nil);
  q.Connection := FConnection;

  q.SQL.Text := Format('select * from mnist_dataset limit %d', [Limit]);
  q.Open;

  while q.Eof = False do
  begin
    ImageRecord.Id := q.FieldByName('id').Value;
    ImageRecord.Digit := q.FieldByName('digit').Value;
    ImageRecord.Content := q.FieldByName('content').Value;
    ImageRecordList.Add(ImageRecord);

    q.Next;
  end;

  q.Close;
  q.Free;
end;

end.
