unit uNeuralNetwork;

interface

Uses System.Generics.Collections, uTypes, uNeuralLayer;

type
  CNeuralNetwork = class
  private
    FNeuronType: TNeuronType;
    FLayerCount,
    FInputCount: Byte;
    FInputData: TByteArray;
    FInputMatrix: TMatrixArray;
    FLayers: TObjectList<CNeuralLayer>;
    procedure AddLayer(const NeuronCount: Byte);
  public
    function GetOutputValues: TDecimalArray;
    constructor Create(const NeuronType: TNeuronType; const LayerCount, InputCount, NeuronCount: Byte; const InputData: TByteArray);
    destructor Destroy; override;
  end;

implementation

{ CNeuralNetwork }

procedure CNeuralNetwork.AddLayer(const NeuronCount: Byte);
begin
  FLayers.Add(CNeuralLayer.Create(FNeuronType, NeuronCount))
end;

constructor CNeuralNetwork.Create(const NeuronType: TNeuronType; const LayerCount, InputCount, NeuronCount: Byte; const InputData: TByteArray);
var
  I: Byte;
begin
  FNeuronType := NeuronType;
  FLayerCount := LayerCount;
  FInputCount := InputCount;
  FInputData := InputData;

  FLayers := TObjectList<CNeuralLayer>.Create;

  for I := 0 to LayerCount-1 do
    AddLayer(NeuronCount-(I*1));
end;

destructor CNeuralNetwork.Destroy;
begin
  FLayers.Free;
  FInputMatrix := Nil;
end;

function CNeuralNetwork.GetOutputValues: TDecimalArray;
var
  OutputValues: TDecimalArray;

  InputValueSize,
  I, J, Index: Word;
  ColCount,
  RowCount: Byte;
begin
  InputValueSize := Length(FInputData);
  ColCount := FInputCount;
  RowCount := InputValueSize div ColCount;

  Index := 0;

  if (InputValueSize mod ColCount) > 0 then
    Inc(RowCount);

  SetLength(FInputMatrix, RowCount);

  for I := 0 to RowCount-1 do
  begin
    SetLength(FInputMatrix[I], ColCount);

    for J := 0 to ColCount-1 do
    begin
      if Index < InputValueSize then
        FInputMatrix[I][J] := FInputData[Index]
      else
        FInputMatrix[I][J] := 0;

      Inc(Index);
    end;
  end;

  for I := 0 to RowCount-1 do
  begin
    OutputValues := FInputMatrix[I];

    for J := 0 to FLayers.Count-1 do
      OutputValues := FLayers[J].GetOutputValues(OutputValues);
  end;

  Result := OutputValues;
end;

end.
