unit uNeuralLayer;

interface

Uses System.Generics.Collections, uTypes, uNeuron;

type
  CNeuralLayer = class
  private
    FNeuronType: TNeuronType;
    FNeuronCount: Byte;
    FBinaryNeurons: TObjectList<CBinaryNeuron>;
    FSinusNeurons: TObjectList<CSinusNeuron>;
    FValueNeurons: TObjectList<CValueNeuron>;
    procedure AddNeuron;
    procedure Fire(const Index: Byte; const Value: Double);
    procedure SetOutputValuesForBinary(var OutputValues: TDecimalArray);
    procedure SetOutputValuesForSinus(var OutputValues: TDecimalArray);
    procedure SetOutputValuesForValue(var OutputValues: TDecimalArray);
  public
    function GetOutputValues(const InputValues: TDecimalArray): TDecimalArray;
    constructor Create(const NeuronType: TNeuronType; const NeuronCount: Byte);
    destructor Destroy; override;
  end;

implementation

{ CNeuralLayer }

procedure CNeuralLayer.AddNeuron;
begin
  case FNeuronType of
    TNeuronType.ntBinary: FBinaryNeurons.Add(CBinaryNeuron.Create);
    TNeuronType.ntSinus: FSinusNeurons.Add(CSinusNeuron.Create);
    TNeuronType.ntValue: FValueNeurons.Add(CValueNeuron.Create);
  end;
end;

constructor CNeuralLayer.Create(const NeuronType: TNeuronType; const NeuronCount: Byte);
var
  I: SmallInt;
begin
  FNeuronType := NeuronType;
  FNeuronCount := NeuronCount;

  case FNeuronType of
    TNeuronType.ntBinary: FBinaryNeurons := TObjectList<CBinaryNeuron>.Create;
    TNeuronType.ntSinus: FSinusNeurons := TObjectList<CSinusNeuron>.Create;
    TNeuronType.ntValue: FValueNeurons := TObjectList<CValueNeuron>.Create;
  end;

  for I := 1 to FNeuronCount do
    AddNeuron;
end;

destructor CNeuralLayer.Destroy;
begin
  case FNeuronType of
    TNeuronType.ntBinary: FBinaryNeurons.Free;
    TNeuronType.ntSinus: FSinusNeurons.Free;
    TNeuronType.ntValue: FValueNeurons.Free;
  end;
end;

procedure CNeuralLayer.Fire(const Index: Byte; const Value: Double);
begin
  case FNeuronType of
    TNeuronType.ntBinary: FBinaryNeurons[Index].Fire(Value);
    TNeuronType.ntSinus: FSinusNeurons[Index].Fire(Value);
    TNeuronType.ntValue: FValueNeurons[Index].Fire(Value);
  end;
end;

function CNeuralLayer.GetOutputValues(const InputValues: TDecimalArray): TDecimalArray;
var
  InputValueSize,
  I, J: Word;
  OutputValues: TDecimalArray;
begin
  SetLength(OutputValues, FNeuronCount);

  InputValueSize := Length(InputValues);

  for I := 0 to FNeuronCount-1 do
  begin
    for J := 0 to InputValueSize-1 do
      Fire(I, InputValues[J])
  end;

  case FNeuronType of
    TNeuronType.ntBinary: SetOutputValuesForBinary(OutputValues);
    TNeuronType.ntSinus: SetOutputValuesForSinus(OutputValues);
    TNeuronType.ntValue: SetOutputValuesForValue(OutputValues);
  end;

  Result := OutputValues;
end;

procedure CNeuralLayer.SetOutputValuesForBinary(var OutputValues: TDecimalArray);
var
  I: Byte;
begin
  for I := 0 to FNeuronCount-1 do
    OutputValues[I] := FBinaryNeurons[I].GetOutputValue;
end;

procedure CNeuralLayer.SetOutputValuesForSinus(var OutputValues: TDecimalArray);
var
  I: Byte;
begin
  for I := 0 to FNeuronCount-1 do
    OutputValues[I] := FSinusNeurons[I].GetOutputValue;
end;

procedure CNeuralLayer.SetOutputValuesForValue(var OutputValues: TDecimalArray);
var
  I: Byte;
begin
  for I := 0 to FNeuronCount-1 do
    OutputValues[I] := FValueNeurons[I].GetOutputValue;
end;

end.
