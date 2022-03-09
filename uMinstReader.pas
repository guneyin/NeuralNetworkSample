unit uMinstReader;

interface

type

  CMinstReader = class
  private
    FImageFile,
    FLabelFile: string;
    procedure ReadImages
  public
    constructor Create(const ImageFile, LabelFile: string);
  end;

implementation

{ CMinstReader }

constructor CMinstReader.Create(const ImageFile, LabelFile: string);
begin
  FImageFile := ImageFile;
  FLabelFile := LabelFile;
end;

end.
