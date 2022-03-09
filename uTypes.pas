unit uTypes;

interface

Uses System.Classes, System.Generics.Collections, System.StrUtils, System.SysUtils;

type
  TNeuronType = (ntBinary, ntSinus, ntValue);

  TByteArray = array of Byte;

  TDecimalArray = array of Double;

  TMatrixArray = array of TDecimalArray;

  TImageRecord = record
    Id: Integer;
    Digit: string;
    Value: Double;
    Content: string;
  private
    function getContentAsArray: TByteArray;
  public
    property ContentAsArray: TByteArray read getContentAsArray;
  end;

  TImageRecordList = Class(TList<TImageRecord>);

implementation

{ TImageRecord }

function TImageRecord.getContentAsArray: TByteArray;
var
  CharArray: array of char;
  I: Word;
begin
  SetLength(Result, Length(Content));
  SetLength(CharArray, Length(Content));

  StrLCopy(PChar(@CharArray[0]), PChar(Content), High(CharArray)+1);

  for I := 0 to Length(Result)-1 do
    Result[I] := StrToInt(CharArray[I])
end;

end.
