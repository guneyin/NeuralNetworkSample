unit uNeuron;

interface

Uses System.SysUtils, Math;

type
  CNeuron = class
  private
    FWeightValue,
    FEdgeValue,
    FInternalValue,
    FInputValue: Double;
  public
    procedure Fire(const InputValue: Double);
    function GetOutputValue: Double; virtual; abstract;
    constructor Create;
  end;

  CBinaryNeuron = class(CNeuron)
    function GetOutputValue: Double; override;
  end;

  CSinusNeuron = class(CNeuron)
    function GetOutputValue: Double; override;
  end;

  CValueNeuron = class(CNeuron)
    function GetOutputValue: Double; override;
  end;

implementation

{ CNeuron }

procedure CNeuron.Fire(const InputValue: Double);
begin
  FInputValue := RoundTo(FWeightValue * InputValue, -2);
  FInternalValue := FInternalValue + FInputValue;
end;

constructor CNeuron.Create;
begin
  FWeightValue := RandomRange(-100, 100) / 100;
  FEdgeValue := RandomRange(-100, 100) / 100;

  if FEdgeValue = 0 then
    FEdgeValue := FEdgeValue + 0.01;
end;

{ CBinaryNeuron }

function CBinaryNeuron.GetOutputValue: Double;
begin
  if FInternalValue > FEdgeValue then
    Result := 1
  else
    Result := 0
end;

{ CSinusNeuron }

function CSinusNeuron.GetOutputValue: Double;
begin
  Result := (1 / (1 + Exp(-FInternalValue / FEdgeValue)));
end;

{ CValueNeuron }

function CValueNeuron.GetOutputValue: Double;
begin
  Result := FInternalValue;
end;

end.
