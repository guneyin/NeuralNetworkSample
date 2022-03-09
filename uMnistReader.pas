unit uMnistReader;

interface

Uses System.Classes, System.Generics.Collections, System.SysUtils, uTypes;

type
  CMnistReader = class
  private
    ImageRecordList: TImageRecordList;
    function GetByteFromStream(const Stream: TMemoryStream; const Offset, Index: Integer): String;
    function GetBytesFromStream(const Stream: TMemoryStream; const Offset, Index, Buffer: Word): String;
  public
    procedure Init(const LabelFile, ImageFile: string);
    constructor Create;
  end;

implementation

Uses uDatabase;

{ CMinstReader }

function Bytes2String(const ABytes: TBytes): string;
var
  I: Integer;
begin
  Result := '';

  for I := Low(ABytes) to High(ABytes) do
  begin
    if I = 0 then
      Result := IntToStr(ABytes[I])
    else
      Result := Result + ',' + IntToStr(ABytes[I])
  end;
end;

procedure CMnistReader.Init(const LabelFile, ImageFile: string);
var
  ImageRecord: TImageRecord;
  LabelStream,
  ImageStream: TMemoryStream;
  I: Word;
begin
  LabelStream := TMemoryStream.Create;
  ImageStream := TMemoryStream.Create;

  LabelStream.LoadFromFile(LabelFile);
  ImageStream.LoadFromFile(ImageFile);

  ImageRecordList.Clear;

  for I := 0 to 59999 do
  begin
    try
      ImageRecord.Digit := GetByteFromStream(LabelStream, 8, I);
      ImageRecord.Content := GetBytesFromStream(ImageStream, 16, I, 784);
      ImageRecordList.Add(ImageRecord);
    except
    end;
  end;

  Database.SaveImageRecordList(ImageRecordList);
end;

constructor CMnistReader.Create;
begin
  ImageRecordList := TImageRecordList.Create;
end;

function CMnistReader.GetByteFromStream(const Stream: TMemoryStream; const Offset, Index: Integer): string;
var
  Bytes: TBytes;
begin
  SetLength(Bytes, 1);
  Stream.Position := Offset + Index;
  Stream.ReadBuffer(Pointer(Bytes)^, 1);

  Result := Bytes[0].ToString;
end;

function CMnistReader.GetBytesFromStream(const Stream: TMemoryStream; const Offset, Index, Buffer: Word): String;
var
  I: Integer;
  R: string;
begin
  Result := '';

  for I := 1 to Buffer do
  begin
    R := GetByteFromStream(Stream, Offset + (Index * Buffer), I);

    if R = '0' then
      Result := Result + '0'
    else
      Result := Result + '1';
  end;
end;

end.
